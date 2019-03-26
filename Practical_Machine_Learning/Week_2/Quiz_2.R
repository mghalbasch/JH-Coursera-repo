# Question 1 Asks that we create a training and test set

library(AppliedPredictiveModeling)
library(caret)

data(AlzheimerDisease)
adData=data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.5, list = FALSE)
train=adData[trainIndex,]
test = adData[-trainIndex,]

# Question 2 asks about the cement data:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# We want to make a plot of CompressiveStrength versus the index.
library(ggplot2)
library(Hmisc)
x <- 1:length(training$CompressiveStrength)

training %>% mutate(index = x) %>% 
#  select(index, CompressiveStrength, Age,FlyAsh) %>%
  melt(id.vars=c("CompressiveStrength","index")) %>%
  group_by(variable) %>% mutate(value = cut(value, 4, labels=FALSE)) %>% 
  ggplot(aes(y=CompressiveStrength, x=index, color=value)) +
  geom_point() +
  facet_wrap(vars(variable)) +
  theme(legend.position="None")

# FlyAsh kind of predictive but not fully explanatory...


# Question 3 also considers the cement data loaded above.
# We now want to look at the SuperPlasticizer Variable:
training %>% ggplot(aes(x=Superplasticizer)) +
  geom_histogram(bins=20, fill='deepskyblue3', color='black')

# data is skewed by lots of 0's. Log transform would be bad because
# even adding 1 and logging you still get 0.


# Question 4 looks at Alzheimer's data:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# We want to look at those variables starting with IL, and find
# the number of pc's required to explain 90% of variance.
training %>% select(starts_with("IL")) -> IL_data
preProcess(IL_data, method="pca", thresh=0.9) -> preproc
preproc$numComp

# Question 5 also looks at the same Alzheimer's data.
# Now we want to create a training datat set with only IL variables
# and the diagnosis. We want to build 2 predictive models,
# using the basic predictors and the PCA explaining 80% of the
# variance. Use 'glm' method to train.

training %>% select(starts_with("IL")) -> IL_data_5
testing %>% select(starts_with("IL")) -> test_IL_data_5
train(IL_data_5, training$diagnosis, method="glm") -> no_PCA
predict.train(object=no_PCA, test_IL_data_5) -> no_PCA_predictions
confusionMatrix(no_PCA_predictions, testing$diagnosis)

# Accuracy for glm with no preprocessing is 0.6463



preproc_5 <- preProcess(IL_data_5, method="pca", thresh=0.8)
train_data_5 <- predict(preproc_5, IL_data_5)
test_data_5 <- predict(preproc_5, test_IL_data_5)
train(train_data_5, training$diagnosis, method="glm") -> PCA
predict.train(object=PCA, test_data_5) -> PCA_predictions
confusionMatrix(PCA_predictions, testing$diagnosis)

# Accuracy for glm with preprocessing is 0.7195