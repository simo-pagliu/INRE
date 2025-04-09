import requests
import pandas as pd
import numpy as np

# Define the parameters
angle = 22
azimuth = np.linspace(-170, 180, 36)  # Azimuth angles from 0 to 360 degrees

loss = 0  # % of loss of the PV panel

# Read the CSV file into a DataFrame
df = pd.read_csv('Integration of Nuclear and Renewables/Project_Data/Ext_Data/CABINE_PRIMARIE_with_lat_lon.csv')

# Extract the columns into separate lists
municipalities = df['Municipality'].tolist()
latitudes = df['Latitude'].tolist()
longitudes = df['Longitude'].tolist()

# Print the lists to verify
print("Municipalities:", municipalities)
print("Latitudes:", latitudes)
print("Longitudes:", longitudes)

len = len(municipalities)

for i, municipality in enumerate(municipalities):
    lat = latitudes[i]
    lon = longitudes[i]

    print(f"Progressing {i + 1}/{len}", end="\r")  # Print progress

    for az in azimuth:
        # Construct the URL
        url = (
            f"https://re.jrc.ec.europa.eu/api/v5_3/seriescalc?"
            f"lat={lat}&"
            f"lon={lon}&"
            f"raddatabase=PVGIS-SARAH3&browser=1&outputformat=csv&userhorizon=&usehorizon=1&"
            f"angle={angle}&"
            f"aspect={az}&"
            f"startyear=2023&endyear=2023&mountingplace=free&optimalinclination=0&optimalangles=0&js=1&"
            f"select_database_hourly=PVGIS-SARAH3&hstartyear=2023&hendyear=2023&trackingtype=0&"
            f"hourlyangle={angle}&"
            f"hourlyaspect={az}&"
            f"pvcalculation=1&pvtechchoice=crystSi&peakpower=1&"
            f"loss={loss}"
        )

        # Send the GET request
        response = requests.get(url)

        # Check if the request was successful
        if response.status_code == 200:
            # Save the response content to a CSV file
        
            with open(f"./Integration of Nuclear and Renewables/Project_Data/Ext_Data/PVGIS_Data/{municipality}_{az}.csv", "wb") as file:
                file.write(response.content)
            print("Data successfully saved to solar_data.csv")
        else:
            print(f"Error: Received status code {response.status_code}")

