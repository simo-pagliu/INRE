import pandas as pd

# Read CABINE PRIMARIE.txt file
with open("Integration of Nuclear and Renewables/Project_Data/Ext_Data/CABINE PRIMARIE.txt", "r") as file:
# Save every line in a list
    lines = file.readlines()
# Remove empty lines and strip whitespace
    lines = [line.strip() for line in lines if line.strip()]
# Remove duplicates
    lines = list(set(lines))
# Make each line uppercase
    lines = [line.upper() for line in lines]
# Save the list to a CSV file
    with open("Integration of Nuclear and Renewables/Project_Data/Ext_Data/CABINE_PRIMARIE.csv", "w") as output_file:
        for line in lines:
            output_file.write(line + "\n")

# Load the CSV
df = pd.read_csv("C:/Users/Simo/Documents/GitHub/Fission-Reactor-Physics/Integration of Nuclear and Renewables/Project_Data/Ext_Data/CENED_db.csv", dtype=str)  # adjust the filename

# Ensure the 'RESIDENZIALE' column is treated as boolean
df['RESIDENZIALE'] = df['RESIDENZIALE'].str.lower() == 'true'

# Filter the dataframe
filtered_df = df[(df['RESIDENZIALE']) & (df['COMUNE_CATASTALE'].str.upper().isin(lines))]

# Save the filtered data
filtered_df.to_csv("/Integration of Nuclear and Renewables/Project_Data/Ext_Data/FILTERED_db.csv", index=False)
