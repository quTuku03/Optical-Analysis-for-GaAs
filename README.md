
#  GaAs Optical Properties & Band Gap Analysis
## Overview
This project performs a computational analysis of the dielectric function ($\epsilon_2$) for **Gallium Arsenide (GaAs)** in two structural phases:
1.  **Crystalline (c-GaAs):** Ordered zincblende structure with sharp optical transitions.
2.  **Amorphous (a-GaAs):** Disordered structure with broadened absorption features.

  <img width="646" height="516" alt="image" src="https://github.com/user-attachments/assets/4c6cd4ec-812e-4e8e-94a6-a6ad9b49081f" />


The MATLAB script fits experimental data using non linear least squares optimization (`fminsearch`) to extract critical physical parameters, specifically the **Optical Band Gap ($E_g$)**.

## Theoretical Models

### 1. Lorentz Oscillator Model
Used as a baseline to model the classical electron-cloud oscillation.
$$\epsilon_2(\omega) = \sum_{j=1}^{N} \frac{A_j \gamma_j \omega}{(\omega_{0,j}^2 - \omega^2)^2 + \gamma_j^2 \omega^2}$$
* **Best for:** General shape fitting.
* **Limitation:** Does not account for the band gap onset (predicts absorption at $E=0$).
<img width="350" height="350" alt="image" src="https://github.com/user-attachments/assets/6b77d518-a460-496f-93bb-04445e21c047" />


### 2. Tauc-Lorentz Model
Used to extract the **Optical Band Gap ($E_g$)**. This model enforces zero absorption below the band gap energy.
$$\epsilon_2(\omega) \propto \frac{(\omega - E_g)^2}{\omega}$$
* **Best for:** Amorphous materials and determining the fundamental gap in semiconductors.

##  How to Run

  **Setup MATLAB:**
    Ensure all `.txt` data files are in the **Current Folder** or added to the MATLAB path.

  **Execute:**
    Run the main script in the MATLAB Command Window

  **Note:**
    To test the fit, **you will need experimental measurements for GaAs from spectroscopic ellipsometers.**
    
eg: (Photon Energy,	Re(Epsilon),	Im(Epsilon))

1.567eV 18.750000 6.875000|
1.577eV 18.747999 6.878000| 
1.587eV 18.743999 6.886000| 
1.597eV 18.736000 6.900000|


##  Expected Results

Upon running, the script generates a $2 \times 2$ plot window and outputs the following analysis to the console:

```text
Crystalline GaAs (c-GaAs):
  > Found Eg:      [Value calculated by fit] eV
  > Theoretical Eg: 1.424 eV (at 300 K)

Amorphous GaAs (a-GaAs):
  > Found Eg:      [Value calculated by fit] eV
  > Theoretical Eg: 1.5 - 1.7 eV
```
## Refrences

### 1. Fujiwara, H. Spectroscopic Ellipsometry: Principles and Applications. Springer, 2007.

### 2. Aspnes, D. E. "Optical functions of semiconductors." Handbook on Semiconductors, 1982.

### 3. Jellison, G. E., and Modine, F. A. "Parameterization of the optical functions of amorphous materials." Applied Physics Letters, vol. 69, no. 3, 1996, pp. 371–373.

<img width="100" height="105" alt="Gallium-arsenide-unit-cell-3D-balls" src="https://github.com/user-attachments/assets/a3272503-e0c7-4807-96a5-a691ceb4f8ad" />





