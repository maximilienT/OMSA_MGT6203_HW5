# 1. Load and install packages
install.packages("neuralnet")
library(neuralnet)

mydata <- read.csv("Smarket.csv")
# 2. Scale Data
mydata <- mydata[,-c(1,8)]

mydata[,-7] <- scale(mydata[,-7])

# 3. Split into test and train datasets



# 4. Fit simple neural network

# 5. Plot Neural network

# 6. display weights of neural network

# 7. Manually cacluate the values of activation and output nodes

# 8. Verify manual calculations with compute

# 9. Create more complex NN

# 10. Plot NN using plot function, get weights

# 11. Use compute function

# 12. Get predictions on test dataset

# 13. Confusion matrix to compare predicted vs actual

# 14. Run a logistic regression model on data

# 15. Compare accuracy of logistic vs NN