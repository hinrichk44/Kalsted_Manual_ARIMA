#Manual ARIMA Parameter Selection
#We will be working with the lynx dataset
#Annual numbers of lynx trappings for 1821--1934 in Canada.
#Let's test for stationarity first
library(tseries)
adf.test(lynx)
#The results confirm that this dataset is stationary 
#Stationarity means we can set the "d" in ARIMA(p,d,q) to 0
#Remember that "p" is for autoregression and "q" is for moving average
#Let's test for autoregression next using tsdisplay
library(forecast)
tsdisplay(lynx)
#Generally, the lags on ACF are for MA or parameter "q"
#The lags on PACF are for AR or parameter "p"
#On PACF it looks like the first two lags are significant
#Let's test out an ARIMA model now
lynxarima <- Arima(lynx, order = c(2,0,0))
#Let's check the residuals to see if they're random and normally distributed
checkresiduals(lynxarima)
#On the ACF plot there are significant lags at 7, 9, and 19
#let's adjust our ARIMA model based on the residuals
lynxarima <- Arima(lynx, order = c(3,0,0))
checkresiduals(lynxarima)
#We still have problematic lags
#Let's do another adjustment
lynxarima <- Arima(lynx, order = c(4,0,0))
checkresiduals(lynxarima)
#We have elimated autoregression, but there does seem to be a spike in 
#the residuals. Indicates not entirely random. 