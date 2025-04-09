import requests
import pandas as pd

def get_lat_lon_nominatim(municipality_name):
    base_url = "https://nominatim.openstreetmap.org/search"
    params = {
        "q": municipality_name,
        "format": "json",
        "limit": 1
    }
    headers = {
        "User-Agent": "your_unique_user_agent"  # Replace with a unique user-agent string
    }

    response = requests.get(base_url, params=params, headers=headers)

    if response.status_code == 200:
        data = response.json()
        if data:
            return data[0]['lat'], data[0]['lon']
        else:
            print(f"No data found for: {municipality_name}")
            return None, None
    else:
        print(f"Error: Received status code {response.status_code} for {municipality_name}")
        return None, None

# Specify the column names if the CSV doesn't have a header
column_names = ['Municipality', 'OtherColumn1', 'OtherColumn2']  # Adjust column names as needed

# Read the CSV file without a header and assign column names
municipalities_df = pd.read_csv("./Integration of Nuclear and Renewables/Project_Data/Ext_Data/CABINE_PRIMARIE.csv", header=None, names=column_names)
print(municipalities_df.head())

# Initialize new columns for latitude and longitude
municipalities_df['Latitude'] = None
municipalities_df['Longitude'] = None

tot = len(municipalities_df)
print(f"Total municipalities to process: {tot}")

# Iterate over each municipality to get latitude and longitude
for index, row in municipalities_df.iterrows():
    municipality_name = row['Municipality']  # Use the specified column name
    latitude, longitude = get_lat_lon_nominatim(municipality_name)
    municipalities_df.at[index, 'Latitude'] = latitude
    municipalities_df.at[index, 'Longitude'] = longitude
    print(f"Processed {index + 1}/{tot}", end="\r")  # Print progress

# Save the updated DataFrame to a new CSV file
municipalities_df.to_csv("./Integration of Nuclear and Renewables/Project_Data/Ext_Data/CABINE_PRIMARIE_with_lat_lon.csv", index=False)
