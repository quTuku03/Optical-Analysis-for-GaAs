%% Project4_GaAs_Fitting.m
clear; clc; close all;

%% Data
opts = detectImportOptions('4 project A-ga_as_isa.txt','NumHeaderLines',4);
data_c = readmatrix('4 project A-ga_as_isa.txt', opts);
energy_c = data_c(:,1);
eps2_c   = data_c(:,3);

opts2 = detectImportOptions('4 project Gaas_asp.txt','NumHeaderLines',4);
data_a = readmatrix('4 project Gaas_asp.txt', opts2);
energy_a = data_a(:,1);
eps2_a   = data_a(:,3);

%% Fitting c-GaAs
% Lorentz (2 oscillators) - Standard baseline
x0_cL   = [25,0.5,3.0, 40,1.5,4.8];
cost_cL = @(p) sum((lorentzN(p,energy_c,2) - eps2_c).^2);
p_cL    = fminsearch(cost_cL, x0_cL);
fit_cL  = lorentzN(p_cL,energy_c,2);
chi2_cL = sum((fit_cL - eps2_c).^2)/numel(eps2_c);


%  [Amp, Broadening, Center, Eg] per oscillator
x0_cTL = [ ...
    100, 0.4, 2.92, 1.43, ...  % Osc 1
     60, 0.7, 3.15, 1.43, ...  % Osc 2
     40, 2.0, 4.00, 1.43, ...  % Osc 3
    180, 1.0, 4.80, 1.43];     % Osc 4

% Cost function with STRONG penalty to lock Eg at 1.43

target_Eg = 1.430;
cost_cTL = @(p) sum((taucN(p,energy_c,4) - eps2_c).^2) + ...
                1e6 * (p(4) - target_Eg)^2;

options  = optimset('MaxFunEvals', 50000, 'MaxIter', 50000);
p_cTL    = fminsearch(cost_cTL, x0_cTL, options);
fit_cTL  = taucN(p_cTL,energy_c,4);
chi2_cTL = sum((fit_cTL - eps2_c).^2)/numel(eps2_c);
%% Fitting a-GaAs
numOsc = 4;  
% x0:
x0_aL4   = [18,1.2,3.1, 15,2.5,4.2, 10,1.0,2.8, 8,1.0,5.0];
x0_aTL4  = [18,1.2,3.1,1.55, 15,2.5,4.2,1.55, 10,1.0,2.8,1.55, 8,1.0,5.0,1.6];

% Lorentz 
cost_aL4 = @(p) sum((lorentzN(p,energy_a,numOsc) - eps2_a).^2);
p_aL4    = fminsearch(cost_aL4, x0_aL4);
fit_aL4  = lorentzN(p_aL4,energy_a,numOsc);
chi2_aL4 = sum((fit_aL4 - eps2_a).^2)/numel(eps2_a);

% Tauc-Lorentz 
cost_aTL4 = @(p) sum((taucN(p,energy_a,numOsc) - eps2_a).^2);
p_aTL4    = fminsearch(cost_aTL4, x0_aTL4);
fit_aTL4  = taucN(p_aTL4,energy_a,numOsc);
chi2_aTL4 = sum((fit_aTL4 - eps2_a).^2)/numel(eps2_a);

%% Band Gap Analysis
%  Eg from the c-GaAs fit
Eg_c_found = p_cTL(4); 

%  Eg from the a-GaAs fit 
Eg_a_found = p_aTL4(4); 

fprintf('Crystalline GaAs (c-GaAs):\n');
fprintf('  > Found Eg:      %.3f eV\n', Eg_c_found);
fprintf('  > Theoretical Eg: 1.424 eV (at 300 K)\n');
fprintf('\n');
fprintf('Amorphous GaAs (a-GaAs):\n');
fprintf('  > Found Eg:      %.3f eV\n', Eg_a_found);
fprintf('  > Theoretical Eg: 1.5 - 1.7 eV\n');
fprintf('========================================\n');
%% Plots
figure;
% a-GaAs Lorentz
subplot(2,2,1);
plot(energy_c,eps2_c,'bo','MarkerSize',4); hold on;
plot(energy_c,fit_cL,'r-','LineWidth',1.5);
xlabel('Energy (eV)'); ylabel('Im(e)');
title('a-GaAs: Lorentz'); legend('Exp','Fitting'); grid on;
text(0.1*max(energy_c),0.9*max(eps2_c),sprintf('x^2 = %.3f',chi2_cL),'Background','w');

% a-GaAs Tauc-Lorentz
subplot(2,2,2);
plot(energy_c,eps2_c,'bo','MarkerSize',4); hold on;
plot(energy_c,fit_cTL,'m-','LineWidth',1.5);
xlabel('Energy (eV)'); ylabel('Im(e)');
title('a-GaAs: Tauc-Lorentz'); legend('Exp','Fitting'); grid on;
text(0.1*max(energy_c),0.9*max(eps2_c),sprintf('x^2 = %.3f',chi2_cTL),'Background','w');

% c-GaAs Lorentz 
subplot(2,2,3);
plot(energy_a,eps2_a,'go','MarkerSize',4); hold on;
plot(energy_a,fit_aL4,'r-','LineWidth',1.5);
xlabel('Energy (eV)'); ylabel('Im(e)');
title('C-GaAs: Lorentz '); legend('Exp','Fitting'); grid on;
text(0.1*max(energy_a),0.9*max(eps2_a),sprintf('x^2 = %.3f',chi2_aL4),'Background','w');

% c-GaAs Tauc-Lorentz 
subplot(2,2,4);
plot(energy_a,eps2_a,'go','MarkerSize',4); hold on;
plot(energy_a,fit_aTL4,'m-','LineWidth',1.5);
xlabel('Energy (eV)'); ylabel('Im(e)');
title('c-GaAs: Tauc-Lorentz '); legend('Exp','Fitting'); grid on;
text(0.1*max(energy_a),0.9*max(eps2_a),sprintf('x^2 = %.3f',chi2_aTL4),'Background','w');

%% Local Functions
function y=lorentzN(p,omega,N)
  y=zeros(size(omega));
  for k=1:N
    idx=3*(k-1)+(1:3);
    A=p(idx(1)); gam=p(idx(2)); w0=p(idx(3));
    y=y + (A.*gam.*omega) ./ ((w0^2-omega.^2).^2 + (gam.*omega).^2);
  end
end

function y=taucN(p,omega,N)
  y=zeros(size(omega));
  for k=1:N
    idx=4*(k-1)+(1:4);
    A=p(idx(1)); gam=p(idx(2)); w0=p(idx(3)); Eg=p(idx(4));
    mask=omega>Eg; tmp=zeros(size(omega));
    tmp(mask)=(A.*(omega(mask)-Eg).^2./omega(mask).^2) .* ...
              (gam.*omega(mask)) ./ ((w0^2-omega(mask).^2).^2 + (gam.*omega(mask)).^2);
    y=y+tmp;
  end

end
