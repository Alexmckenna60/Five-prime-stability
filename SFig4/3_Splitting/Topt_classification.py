#exec(open("Topt_classification.py").read())
import pandas as pd

df = pd.read_csv("GC3_TOPT.csv")

df.columns = df.columns.str.strip() 
print(df.columns)

print(df['Predicted Optimum Growth Temperature'])

df['Predicted Optimum Growth Temperature'] = df['Predicted Optimum Growth Temperature'].str.replace(' ℃', '').astype(float)

print("\nNaN values in the 'Predicted Optimum Growth Temperature' column:")
print(df[df['Predicted Optimum Growth Temperature'].isna()])

topt_column = 'Predicted Optimum Growth Temperature'

print(f"\nFirst few rows of the {topt_column} column:")
print(df[topt_column].head())

hyperthermophile_threshold = 80
thermophile_threshold = 45
mesophile_threshold = 20

hyperthermophiles = df[df[topt_column] > hyperthermophile_threshold]
thermophiles = df[(df[topt_column] <= hyperthermophile_threshold) & (df[topt_column] > thermophile_threshold)]
mesophiles = df[(df[topt_column] <= thermophile_threshold) & (df[topt_column] > mesophile_threshold)]
psychrophiles = df[df[topt_column] <= mesophile_threshold]

#Number of species in each category 
print("\nNumber of species in each group:")
print(f"Hyperthermophiles: {len(hyperthermophiles)}")
print(f"Thermophiles: {len(thermophiles)}")
print(f"Mesophiles: {len(mesophiles)}")
print(f"Psychrophiles: {len(psychrophiles)}")

hyperthermophiles.to_csv('Hyperthermophiles.csv', index=False)
thermophiles.to_csv('Thermophiles.csv', index=False)
mesophiles.to_csv('Mesophiles.csv', index=False)
psychrophiles.to_csv('Psychrophiles.csv', index=False)

print("\nCSV files created for each group.")
