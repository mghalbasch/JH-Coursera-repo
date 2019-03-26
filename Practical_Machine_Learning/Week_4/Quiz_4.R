library(caret)
library(tidyverse)
# Question 1 asks us to fit a boosted predictor to vowel data:
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

train <- mutate(vowel.train, y = factor(y))
test <- mutate(vowel.test, y = factor(y))
set.seed(33833)

library(randomForest)
out1_rf <- train(y ~ ., data = train, method = "rf")
out1_gbm <- train(y ~ ., data = train, method = "gbm")

rf_preds <- predict(out1_rf, select(test, -y))
gbm_preds <- predict(out1_gbm, select(test, -y), n.trees = 150)

confusionMatrix(rf_preds, test$y)$overall[1]
confusionMatrix(gbm_preds, test$y)$overall[1]

agree <- which(rf_preds == gbm_preds)
confusionMatrix(rf_preds[agree], test$y[agree])$overall[1]


# Question 2 asks us to fit Alzheimer's data with 3 different models. We then
# stack the three model's predictions together using a random forest
library(caret)

library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]

set.seed(62433)

out2_rf <- train(diagnosis ~ ., data = training, method = "rf")
out2_gbm <- train(diagnosis ~ ., data = training, method = "gbm")
out2_lda <- train(diagnosis ~ ., data = training, method = "lda")

pred2_rf <- predict(out2_rf, testing)
pred2_gbm <- predict(out2_gbm, testing)
pred2_lda <- predict(out2_lda, testing)

stacked_data <- data.frame(pred2_rf, pred2_gbm, pred2_lda, 
                      diagnosis = testing$diagnosis)

stacked_model <- train(diagnosis ~ ., data = stacked_data, method = "rf")

combined_pred2 <- predict(stacked_model, stacked_data)

confusionMatrix(pred2_rf, testing$diagnosis)$overall[1]
confusionMatrix(pred2_gbm, testing$diagnosis)$overall[1]
confusionMatrix(pred2_lda, testing$diagnosis)$overall[1]
confusionMatrix(combined_pred2, testing$diagnosis)$overall[1]

# Question 3 asks us to fit a lasso model to predict Compressive Strength
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(233)
out3 <- train(CompressiveStrength ~ ., data = training, method = "lasso")

plot(out3$finalModel, xvar = "penalty")

# Question 4 asks us to fit a forecast using the bats() function
library(lubridate) # For year() function below

dat = read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

tstest = ts(testing$visitsTumblr, start = 366)

library(forecast)

out4 <- bats(tstrain)
pred4 <- forecast(out4, level = .95, h = length(tstest))

results4 <- data.frame(pred4$lower, pred4$upper, actual=tstest)

results4 %>% mutate(good = (actual < X95..1)) %>% colSums()/length(tstest)

# Question 5 wants us to fit an SVM to predict Compressive Strength
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(325)
out5 <- svm(CompressiveStrength ~ ., training)

preds5 <- predict(out5, testing)

sqrt(sum((preds5 - testing$CompressiveStrength)^2)/length(preds5))
