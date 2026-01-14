
#  GaAs Optical Properties & Band Gap Analysis
## Overview
This project performs a computational analysis of the dielectric function ($\epsilon_2$) for **Gallium Arsenide (GaAs)** in two structural phases:
1.  **Crystalline (c-GaAs):** Ordered zincblende structure with sharp optical transitions.
2.  **Amorphous (a-GaAs):** Disordered structure with broadened absorption features.

The MATLAB script fits experimental data using non linear least squares optimization (`fminsearch`) to extract critical physical parameters, specifically the **Optical Band Gap ($E_g$)**.

## Theoretical Models

### 1. Lorentz Oscillator Model
Used as a baseline to model the classical electron-cloud oscillation.
$$\epsilon_2(\omega) = \sum_{j=1}^{N} \frac{A_j \gamma_j \omega}{(\omega_{0,j}^2 - \omega^2)^2 + \gamma_j^2 \omega^2}$$
* **Best for:** General shape fitting.
* **Limitation:** Does not account for the band gap onset (predicts absorption at $E=0$).

### 2. Tauc-Lorentz Model
Used to extract the **Optical Band Gap ($E_g$)**. This model enforces zero absorption below the band gap energy.
$$\epsilon_2(\omega) \propto \frac{(\omega - E_g)^2}{\omega}$$
* **Best for:** Amorphous materials and determining the fundamental gap in semiconductors.

---

##  Repository Structure

| File Name | Description |
| :--- | :--- |
| `Project4_GaAs_Fitting.m` | Main MATLAB script containing optimization logic and plotting. |
| `4 project Gaas_asp.txt` | **Crystalline** GaAs Experimental Data (Sharp peaks). |
| `4 project A-ga_as_isa.txt` | **Amorphous** GaAs Experimental Data (Broad hump). |
| `README.md` | Project documentation. |

---

## 🚀 How to Run

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YourUsername/GaAs-Optical-Analysis.git](https://github.com/YourUsername/GaAs-Optical-Analysis.git)
    ```
2.  **Setup MATLAB:**
    Ensure all `.txt` data files are in the **Current Folder** or added to the MATLAB path.
3.  **Execute:**
    Run the main script in the MATLAB Command Window:
    ```matlab
    Project4_GaAs_Fitting
    ```

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

    Fujiwara, H. Spectroscopic Ellipsometry: Principles and Applications. Springer, 2007.

    Aspnes, D. E. "Optical functions of semiconductors." Handbook on Semiconductors, 1982.

    Jellison, G. E., and Modine, F. A. "Parameterization of the optical functions of amorphous materials." Applied Physics Letters, vol. 69, no. 3, 1996, pp. 371–373.
<img width="1994" height="244" alt="image" src="https://github.com/user-attachments/assets/e64c53e9-f3ec-4006-b33a-57f832856bbb" />




