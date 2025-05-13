# Decarbonization of the Sette Laghi Region

## Table of Contents
1. [Introduction](#part-0-introduction)
2. [Data Gathering](#part-1-data-gathering)
3. [Plant Modelling](#part-2-plant-modelling)
4. [Economical Evaluation](#part-3-economical-evaluation)

## Part 0: Introduction

## Part 1: Data Gathering

### PV Evaluation
1. Extract data on the plant size and correlate it to the heated area of the building.
2. Evaluate the storage on PV plant.

### Total Demand
1. Determine the number of buildings by getting the total population of the area and dividing by the average size of a family.
2. Tune data to get coherent results of per capita electricity consumption.

### Sources
- [Terna Data](https://dati.terna.it/fabbisogno/dati-statistici#consumi/energia-elettrica-settore)
- [PVGIS](https://re.jrc.ec.europa.eu/pvg_tools/en/)
- [CENED Data](https://www.cened.it/dati-cened-2.0)
- [Energia Lombardia](https://www.energialombardia.eu/energia-e-territorio)
- [Database CENED 2](https://www.dati.lombardia.it/Energia/Database-CENED-2-Certificazione-ENergetica-degli-E/bbky-sde5/about_data)
- [Consumi Energia](https://www.consumienergia.it/portaleConsumi/it/energia-elettrica-utenze-domestiche.page)
- [GSE](https://www.gse.it/servizi-per-te/autoconsumo/mappa-interattiva-delle-cabine-primarie)

## Part 2: Plant Modelling

### Sources
- [TANDEM Models Description](https://tandemproject.eu/wp-content/uploads/2024/07/D2_3_Modelica_models_description_for_the_tandem_library_V1-1.pdf)
- [HenergyHub Models](https://tandemproject.eu/wp-content/uploads/2023/07/D1_4_Description_of_selected_study_cases_for_safety__technoeconomic_analysis_and_optimisation_V3.pdf)

### Model Components from TANDEM

#### SMR
- ThermoSysPro --> BOP --> Demo --> StaticBoP3_T_Plugged_N3Ssimple_TMPower_Tail
  - Includes everything and an output for electric generation and cogen system that needs modification.

#### H2 Production
- TANDEM --> H2 Production --> HTSE --> Test_HTSE_steam
  - Complete but consider implementing another technology for H2 production.
  - Note: This is High Temperature but our system is NOT.

### Methanator Development

1. **Reaction Definition**:
   The methanation reaction is defined as:
   $$
   \text{CO}_2 + 4\text{H}_2 \rightarrow \text{CH}_4 + 2\text{H}_2\text{O} \quad (\Delta H = -165.1 \, \text{kJ/mol})
   $$
   An irreversible rate expression is assumed:
   $$
   r = k \cdot P_{\text{CO}_2} \cdot P_{\text{H}_2}^4
   $$
   Alternatively, a more flexible Arrhenius form can be used:
   $$
   k = A \cdot \exp\left(-\frac{E_a}{R \cdot T}\right)
   $$
   $$
   r = k \cdot c_{\text{CO}_2} \cdot c_{\text{H}_2}^4
   $$

2. **Material Balance (CSTR)**:
   For each species $ i $, the material balance in a Continuous Stirred-Tank Reactor (CSTR) is given by:
   $$
   \frac{dn_i}{dt} = \dot{n}_{i,\text{in}} - \dot{n}_{i,\text{out}} + \nu_i \cdot r \cdot V
   $$
   Where:
   - $ n_i $: moles of species $ i $
   - $ \dot{n}_i $: molar flow rate
   - $ \nu_i $: stoichiometric coefficient (positive for products, negative for reactants)
   - $ V $: reactor volume

3. **Energy Balance**:
   The energy balance for the reactor is expressed as:
   $$
   \frac{dU}{dt} = \sum_i \dot{n}_{i,\text{in}} h_{i,\text{in}} - \sum_i \dot{n}_{i,\text{out}} h_{i,\text{out}} + (-\Delta H_r) \cdot r \cdot V - Q_{\text{loss}}
   $$
   Where:
   - $ h_i $: specific enthalpy
   - $ Q_{\text{loss}} $: heat removal (e.g., to keep temperature constant)


#### Source for the technological overview
  - [Source](https://www.sciencedirect.com/science/article/pii/S0960148115301610)

#### Literature References for Activation Energy

Several studies provide comprehensive reviews and experimental data on the activation energy for CO/CO₂ methanation:

- **Rönsch et al., Fuel, 2016**:
  - Comprehensive review of CO/CO₂ methanation.
  - Activation energy $ E_a $ ranges from 80–120 kJ/mol for Ni-based catalysts.
  - The exact value depends on the support (e.g., Al₂O₃, SiO₂), pre-treatment, and reactor type.

- **A. Goeppert et al., J. Energy Chem., 2012**:
  - Activation energy for CO₂ methanation over Ni/Al₂O₃ is approximately 90–110 kJ/mol.

- **Wang et al., Applied Catalysis B, 2011**:
  - Activation energy $ E_a $ is 87.5 kJ/mol for Ni/ZrO₂ catalyst.

#### Reference Values for the A Constant and Arrhenius Equation

Various studies provide reference values for the pre-exponential factor $ A $ and the Arrhenius equation:

- **Rönsch et al. (Fuel, 2016)** summarize several kinetic models; one gives:
  $$
  r = 5.0 \times 10^{11} \exp\left(-\frac{120,000}{RT}\right) \cdot c_{\text{CO}_2} \cdot c_{\text{H}_2}^4
  $$

- **Farsi et al., Int. J. Hydrogen Energy (2016)**:
  - $ A = 1.23 \times 10^9 $ (same units)
  - $ E_a = 95 \, \text{kJ/mol} $

- **Koschany et al. (Applied Catalysis B, 2016)** for Ni/Al₂O₃:
  - They fit detailed Langmuir–Hinshelwood models, but for simplified global expressions, $ A $ is approximately $ 10^9–10^{11} $.

#### On the Plant
**Manuel Gotz et al.: Renewable Power-to-Gas: A technological and economic review**
- Parte tecnica sezione 5.2
- Parte economica sezione 5.3

#### Se volessimo fare modello dinamico
@inproceedings{bader2011modelling,
  title={Modelling of a Chemical Reactor for Simulation of a Methanisation Plant},
  author={Bader, A. and Bauersfeld, S. and Brunhuber, C. and Pardemann, R. and Meyer, B.},
  booktitle={Proceedings of the 8th International Modelica Conference},
  year={2011},
  organization={Modelica Association}
}
https://2011.international.conference.modelica.org/proceedings/pages/papers/44_4_ID_202_a_fv.pdf

### Trial 2
- EnergyHUB simulator H2
- Another useful model with thermal storage: Test cases TES_direct Coupling Test_full Plant (in trial 1)

## Part 3: Economical Evaluation

### Compiler for Dymola
- [MSYS2 Installation](https://www.msys2.org/#installation)
    Then open mingw64.exe and run: pacman -S mingw-w64-x86_64-gcc
    Then open mingw32.exe and run: pacman -S mingw-w64-i686-gcc

