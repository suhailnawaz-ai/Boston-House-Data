install.packages("MASS")
install.packages("caret")
install.packages("e1071")
install.packages("randomForest")


bostton_data <.read.csv("C:\Users\Suhail Nawaz\Desktop\Boston House DataSet\boston_housing.xls") 

library(MASS)
library(caret)
library(e1071)
library(randomForest)

data("Boston")
head(Boston)

summary(Boston)

# Plotting
pairs(~., data = Boston)
set.seed(123)
trainIndex <- createDataPartition(Boston$medv, p = .8, 
                                  list = FALSE, 
                                  times = 1)
BostonTrain <- Boston[ trainIndex,]
BostonTest  <- Boston[-trainIndex,]
lm_model <- lm(medv ~ ., data = BostonTrain)
summary(lm_model)


rf_model <- randomForest(medv ~ ., data = BostonTrain)
print(rf_model)

lm_pred <- predict(lm_model, BostonTest)
rf_pred <- predict(rf_model, BostonTest)

postResample(lm_pred, BostonTest$medv)
postResample(rf_pred, BostonTest$medv)
plot(BostonTest$medv, lm_pred, main="Linear Regression Predictions",
     xlab="Actual Prices", ylab="Predicted Prices")
abline(0, 1)

plot(BostonTest$medv, rf_pred, main="Random Forest Predictions",
     xlab="Actual Prices", ylab="Predicted Prices")
abline(0, 1)
