# 1. Load and install packages
#install.packages("neuralnet")
library(neuralnet)

mydata <- read.csv("Smarket.csv")
# 2. Scale Data
mydata <- mydata[,-c(1,8)]

mydata[,-7] <- scale(mydata[,-7])

# 3. Split into test and train datasets
n.train <- floor(nrow(mydata)*0.8)
set.seed(1000)
ind.train<- sample(1:nrow(mydata),n.train)
data.train <- mydata[ind.train,]
data.test <- mydata[-ind.train,]

# 4. Fit simple neural network
nn <- neuralnet(Up ~ Lag1 + Lag2, data = data.train, hidden = 2 , linear.output = FALSE )
load("Smarket_nn1.Rda")

# 5. Plot Neural network
plot(nn, rep="best")

# 6. display weights of neural network
nn$weights

# 7. Manually calculate the values of activation and output nodes
data.test[1,]
s1 <- (-1.5526810)+(-0.4006151)*(-0.5516457)+(0.3979986)*(0.9047775)
s1 <- exp(s1)/(1+exp(s1))

s2 <- (-20.092955)+(1.325688)*(-0.5516457)+(33.606746)*(0.9047775)
s2 <- exp(s2)/(1+exp(s2))

p1 <- (-0.2670554) + (2.5133068)*s1+(-0.7918837)*s2
p1 <- exp(p1)/(1+exp(p1))

# 8. Verify manual calculations with compute
compute(nn, data.test[1,])

# 9. Create more complex NN
nn <- neuralnet(Up ~ ., data = data.train, hidden = c(4,2), linear.output=FALSE )
load("Smarket_nn2.Rda")

# 10. Plot NN using plot function, get weights
plot(nn, rep="best")

# 11. Use compute function
pred <- compute(nn, data.test)
compute(nn,data.test[1,])

# 12. Get predictions on test dataset
pred.class <- rep(FALSE, nrow(data.test))
pred.class[pred$net.result > 0.5] <- TRUE

# 13. Confusion matrix to compare predicted vs actual

confusion <- table(pred.class, data.test$Up)
confusion

sum(diag(confusion))/sum(confusion)

# 14. Run a logistic regression model on data
logit.res <- glm(Up ~ ., data = data.train, family = binomial(link=logit))
summary(logit.res)

logit.pred.prob <- predict(logit.res, data.test, type="response")
logit.pred <- rep(FALSE, nrow(data.test))
logit.pred[logit.pred.prob > 0.5] <- TRUE


# 15. Compare accuracy of logistic vs NN
confusion.logit <- table(logit.pred, data.test$Up)
confusion.logit

sum(diag(confusion.logit))/sum(confusion.logit)