forecastTS = function(df)
{
   library(dplyr)
   library(zoo)
   library(car)
   library(forecast)
   library(tseries)
   library(fUnitRoots)
   library(PerformanceAnalytics)

   data = df

   Date =as.Date(data$Date,format="%d/%m/%y")
   maxDate=max(as.Date(data$Date,format="%d/%m/%y"))

   #creating ts models
   TS = xts(data$TransactionAmount, order.by = as.Date(data$Date))
   m1=auto.arima(TS)

   #forecasting
   fore = forecast::forecast(m1, h=30)
   ar = as.data.frame(fore)
   sepdf=ar[,c(1,4,5)]
   date=seq(from=maxDate+1,to=maxDate+30,by=1)
   Forecast=cbind(date,sepdf)

   Date=format(date, "%Y-%m-%d")

   Forecast=ar[, 1]
   Low95=ar[,4]
   High95=ar[,5]

   return(data.frame(
   Date,Forecast,Low95,High95
   ))

}

getOutputSchema <- function() {
   return (data.frame(
   Date = prep_date(),
   Forecast = prep_decimal(),
   Low95 = prep_decimal(),
   High95 = prep_decimal()
   ))
}