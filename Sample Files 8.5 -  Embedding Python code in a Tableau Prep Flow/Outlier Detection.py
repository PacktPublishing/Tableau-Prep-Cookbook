#!/usr/bin/env python
# coding: utf-8

# import libraries

import pandas as pd
import matplotlib.pyplot as plt

from sklearn.preprocessing import StandardScaler
from sklearn.svm import OneClassSVM

# Function
def detect_outliers(input_df, outliers_fraction=0.05):
    
    # Sorting it by the Date Column
    df = input_df.sort_values('date')

    # Taking Sum of the Amounts on a given day (Remove if unique 'amount' on a given day)
    df = pd.pivot_table(df, index='date', values='amount', aggfunc='sum')
    df = df.reset_index()

    # Scaling the Data
    scaler = StandardScaler()
    scaled_data = scaler.fit_transform(pd.DataFrame(df['amount']))
    data = pd.DataFrame(scaled_data)

    # Training the OneClassSVM
    model = OneClassSVM(nu=outliers_fraction, kernel="rbf", gamma=0.1)
    model.fit(data)

    # Getting the Predicted Outliers
    df['anomaly'] = pd.Series(model.predict(data))

    # Setting the 'anomaly' column as boolean
    df['anomaly'] = [True if x == -1 else False for x in df['anomaly']]

    output_df = input_df
    
    return df

def get_output_schema():
  return pd.DataFrame({
    'date' : prep_date(),
    'amount' : prep_decimal(), 
    'anomaly' : prep_bool()
})