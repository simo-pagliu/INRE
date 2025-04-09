# Share Classe energetiche provincia VA
# Raw data from the chart
raw_data = {
    'A4': 0.09,
    'A3': 0.1,
    'A2': 0.1,
    'A1': 0.13,
    'B': 0.16,
    'C': 0.27,
    'D': 0.67,
    'E': 1.12,
    'F': 1.98,
    'G': 4.14
}

# Total before normalization
total = sum(raw_data.values())

# Normalize to make the sum 100%
normalized_data = {k: v / total * 100 for k, v in raw_data.items()}

print("Normalized data:")
for k, v in normalized_data.items():
    print(f"{k}: {v:.2f}%")

import matplotlib.cm as cm
import numpy as np
colors = cm.viridis(np.linspace(1, 0.3, len(normalized_data)))
# Plot the distribution 
import matplotlib.pyplot as plt
plt.figure(figsize=(12, 6))
plt.bar(normalized_data.keys(), normalized_data.values(), color=colors, alpha=0.8)
plt.xlabel("Energy class")
plt.ylabel("Percentage")
plt.title("Energy Class Distribution in Province of VA")
plt.show()