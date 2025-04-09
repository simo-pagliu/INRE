import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Define the range of azimuth values
azimuth_values = np.linspace(-170, 180, 36)   # 360 points from -180 to 180 degrees

# Define the standard deviation (sigma)
sigma = 140  # You can adjust this value to change the width of the Gaussian profile

# Total Number of Buildings
Buildings = 68967


def normalized_gaussian_profile(azimuth_values, sigma):
    # Calculate the Gaussian profile
    gaussian = np.exp(-0.5 * (azimuth_values / sigma) ** 2)

    # Normalize the Gaussian profile so that it sums to 1
    normalized_gaussian = gaussian / np.sum(gaussian)

    return normalized_gaussian

# Generate the normalized Gaussian profile
normalized_gaussian_profile_values = normalized_gaussian_profile(azimuth_values, sigma)

# Plot the normalized Gaussian profile
plt.plot(azimuth_values, normalized_gaussian_profile_values, '-o')
plt.title('Normalized Gaussian Profile Centered at 0')
plt.xlabel('Azimuth (degrees)')
plt.ylabel('Amplitude')
plt.legend()
plt.grid(True)
plt.show()

# Verify that the sum is 1
print("Sum of the normalized Gaussian profile:", np.sum(normalized_gaussian_profile_values))


# Load the filtered CSV file
filtered_cened = pd.read_csv("./Integration of Nuclear and Renewables/Project_Data/Ext_Data/FILTERED_db.csv", dtype=str)
num_municipalities = 0

# Read hourly profiles one by one
folder_path = "Integration of Nuclear and Renewables/Project_Data/Ext_Data/PVGIS_Data"
Tot_PV_Production = np.zeros(24*365)

# Iterate over all files in the directory
for filename in os.listdir(folder_path):
    # Check if the file is a CSV file
    if filename.endswith(".csv"):
        # Construct the full file path
        file_path = folder_path + "/" + filename

        # Extract municipality and azimuth from the filename
        file_base = os.path.splitext(filename)[0]  # Remove the file extension
        municipality, azimuth = file_base.split('_')  # Split on underscore

        # Convert azimuth to an integer or float if needed
        azimuth = float(azimuth)

        # Find the share of the current azimuth in the azimuth array
        index = np.where(azimuth_values == azimuth)
        share = normalized_gaussian_profile_values[index]

        # Count the occurrences of the target municipality in the 'COMUNE_CATASTALE' column
        occurrences = filtered_cened['COMUNE_CATASTALE'].value_counts().get(municipality, 0)
        relevance = occurrences / Buildings

        # Read the CSV file into a DataFrame, skipping the first 10 rows
        df = pd.read_csv(file_path, skiprows=10)

        # Determine the number of rows to read to exclude the last 10 rows
        total_rows = len(df)
        rows_to_read = total_rows -7

        # Read the DataFrame again with the correct number of rows
        df_cleaned = pd.read_csv(file_path, skiprows=10, nrows=rows_to_read)

        # Extract the P column
        Power = df_cleaned['P'].values
        Power *= share # Scale the power values by share of the azimuth angle
        Power *= relevance # Scale the power values by relevance of the municipality (based on population)

        num_municipalities += 1

        Tot_PV_Production += Power     
Tot_PV_Production /= num_municipalities # Average the power production over all municipalities

# Save to CSV
Tot_PV_Production_df = pd.DataFrame(Tot_PV_Production, columns=['Power'])
Tot_PV_Production_df.to_csv("Integration of Nuclear and Renewables/Project_Data/Ext_Data/Tot_PV_Production.csv", index=False)