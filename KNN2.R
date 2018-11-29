# Libraries.
library(caret)
library(pROC)
library(mlbench)

# Data Classification using Carevaluations.txt
data <- read.table(file.choose(), header = TRUE)
str(data)

# Partioning the data.
set.seed(50)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.70, 0.30))
training <- data[ind == 1,]
test <- data[ind == 2,]

# KNN Modeling.
trControl <- trainControl(method = "repeatedcv",
                          number = 10,
                          repeats = 3)
set.seed(100)
fit <- train(Evaluation ~.,
             data = training,
             method = "knn",
             tuneLength = 20,
             trControl = trControl)
# Model performance.
fit
plot(fit)
varImp(fit)
set.seed(100)
pred <- predict(fit, newdata = test)
confusionMatrix(pred, test$Evaluation)
