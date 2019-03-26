# Question 1 asks us to fit a model using the rpart method in caret
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(dplyr)

train <- segmentationOriginal %>% filter(Case == "Train") %>% select(-Case)
test <- segmentationOriginal %>% filter(Case == "Test") %>% select(-Case)

train_x <- select(train, -Class)
train_y <- factor(train$Class)

set.seed(125)
output <- train(train_x, train_y, method = "rpart")

# Question 3 uses the pgmm package, and asks us to fit a classification tree
# for the Area of the olive oil.
library(pgmm)
data(olive)
olive = olive[,-1]
#train3_x <- select(olive, -Area)
#train3_y <- factor(olive$Area)

out3 <- tree(factor(Area) ~ ., data = olive)
predict(out3, newdata = as.data.frame(t(colMeans(olive))))


# Question 4 wants us to fit a logistic regression:
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

trainSA_y <- factor(trainSA$chd)
trainSA_x <- select(trainSA, c(age, alcohol, obesity, tobacco, typea, ldl))

testSA_y <- factor(testSA$chd)
testSA_x <- select(testSA, c(age, alcohol, obesity, tobacco, typea, ldl))

set.seed(13234)
out4 <- train(trainSA_x, trainSA_y, method = "glm", family = "binomial")

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

train_probs <- predict(out4$finalModel, trainSA_x, type = "response")
missClass(trainSA_y, train_probs)

test_probs <- predict(out4$finalModel, testSA_x, type = "response")
missClass(testSA_y, test_probs)


# Question 5 asks us to fit a random forest to the vowel data set.
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

train <- mutate(vowel.train, y = factor(y))
test <- mutate(vowel.test, y = factor(y))
set.seed(33833)

out5 <- randomForest(y ~ ., data = train)
varImp(out5)

