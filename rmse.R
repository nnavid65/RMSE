#RMSE 
#Navid Moghadas Copy Right ©
library("readxl")

setwd("/Users/navid/Documents/Pyhton/R")

my_data <- read_excel("data.xlsx")
#my_data[[2]]
my_data

#na_indices <- which(is.na(my_data[[2]]))
#print(na_indices)
x_values <- my_data[[1]] 
y_values <- my_data[[2]] 

interp_fun <- approxfun(x_values, y_values, rule = 2)

my_data[[2]] <- ifelse(is.na(my_data[[2]]), interp_fun(x_values), my_data[[2]])

print(my_data)


actual_values <- my_data[[3]]
predicted_values <- my_data[[2]]

valid_indices <- !is.na(actual_values) & !is.na(predicted_values)
actual_values <- actual_values[valid_indices]
predicted_values <- predicted_values[valid_indices]

rmse <- sqrt(mean((actual_values - predicted_values)^2))
print(paste("RMSE: ", rmse))



