# Integration of Nuclear and Renewable Energy for Carbon Neutral Scenarios

## Abstract
This study evaluates the technical and economic feasibility of integrating Small Modular Reactors (SMRs) into the residential energy sector of the north-western province of Varese, Italy. The proposed hybrid system combines nuclear power with renewable energy sources, hydrogen production, and synthetic methane generation to meet regional energy demands and support decarbonization efforts. The analysis includes dynamic simulations of the plant's operation, economic assessments, and environmental impact evaluations over a 60-year period. The methodology involves data collection from regional energy databases, dynamic modeling using Dymola software, and economic analysis considering capital and operational expenditures, as well as revenue streams from electricity, hydrogen, and synthetic gas sales. The study demonstrates that hybrid energy systems can significantly reduce carbon emissions by eliminating fossil fuel use for electricity generation. While the high initial capital costs of a full hybrid system may not be recovered if all components are built simultaneously, a phased implementation strategy can mitigate these costs and generate positive returns, offering a compelling opportunity for regional decarbonization and energy independence.

For more information, refer to the report file in [./Report/main.pdf](./Report/main.pdf).

## Project Structure

### Data Analysis and Processing
- **Data_Analysis.ipynb**: Analyzes the filtered CENED database to extract useful statistics.
- **Energy Demand.ipynb**: Main Jupyter notebook with preprocessing and post-processing of the simulation data.
- **Financial_Plots_Base.ipynb**: Plots the data from the economic analysis in Python for the base scenario.
- **Financial_Plots_Optimized.ipynb**: Plots the data from the economic analysis in Python for the optimized scenario.
- **m_flow_tapsteam_calc.ipynb**: Evaluates the relationship between the mass flow rate of hydrogen produced and tapped flow steam from the intermediate pressure. It processes Dymola results from sweep simulations.

### Economic Analysis
- **Economic Analysis.xlsx**: Excel file containing the economic analysis.

### Data Files
- **comuni_varese.csv**: Contains the list of municipalities for the region of interest.
- **istat_data.csv**: Contains population information.
- **CABINE_PRIMARIE.csv**: List of municipalities used for geographical data retrieval.
- **CABINE_PRIMARIE_with_lat_lon.csv**: Contains geographical coordinates for municipalities.
- **FILTERED_db.csv**: Filtered version of the CENED database.
- **Tot_PV_Production.csv**: Reference photovoltaic profile computed from PVGIS data.

### Scripts
- **solar_data.py**: Populates the PVGIS_Data directory with solar data.
- **solar_production.py**: Computes the reference photovoltaic profile.
- **ISTAT.ipynb**: Computes the total population of the area.
- **filter_db.py**: Filters the CENED database CSV and creates FILTERED_db.csv.
- **geographical_data.py**: Uses the Nominatim API to get coordinates for municipalities and saves them in CABINE_PRIMARIE_with_lat_lon.csv.

### Directories
- **./Report**: Contains the LaTeX project for the report (main.pdf).
- **./Modelica Files**: Contains the files for the package of models developed or modified.
- **./Ext_Data**: Contains external data from the CENED Database, GSE, geographical coordinates, Termolog dynamic calculations (in ./Ext_Data/Termolog_Calcolo_Dinamico), and photovoltaic production data from PVGIS (in ./Ext_Data/PVGIS_Data).
- **./Exports**: Contains results from Energy_Demand.ipynb to be used as input for Dymola simulations (in ./Exports/Data for Dymola) and post-processed data and plots for each scenario (in ./Exports/Results).
- **./Dymola_Results**: Contains the Dymola exports for each simulated scenario.
