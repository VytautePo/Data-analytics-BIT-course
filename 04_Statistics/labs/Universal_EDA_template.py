# =========================
# BASIC EDA TEMPLATE
# =========================

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# ---- LOAD DATA ----
df = pd.read_csv("YOUR_FILE.csv")

# ---- QUICK LOOK ----
print("\nHEAD")
print(df.head())

print("\nSHAPE")
print(df.shape)

print("\nINFO")
print(df.info())

print("\nDESCRIBE NUMERIC")
print(df.describe())

print("\nDESCRIBE ALL")
print(df.describe(include="all"))

print("\nMISSING VALUES")
print(df.isna().sum())

# ---- HISTOGRAMS ----
df.hist(figsize=(12,8))
plt.show()

# ---- CORRELATION ----
num = df.select_dtypes("number")
plt.figure(figsize=(10,8))
sns.heatmap(num.corr(), annot=True, cmap="coolwarm")
plt.show()

# ---- PAIRPLOT (sample if large) ----
sns.pairplot(num.sample(min(len(num),1000)))
plt.show()


# ---- if i have a target

sns.scatterplot(x="ram", y="price", data=df)
plt.show()

sns.boxplot(x=df["price"])
plt.show()

# ranks the strongest corr with a target variable
df.select_dtypes("number").corr()["price"].sort_values(ascending=False)