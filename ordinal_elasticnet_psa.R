#ELASTIC-NET ORDINAL REGRESSION: A CASE STUDY ON FACTORS INFLUENCING STUDENTS’ PUBLIC SPEAKING ANXIETY#

#importing the necessary libraries
library(readxl) #import data in Excel format#
library("dplyr") #data manipulation and transformation#
library("tidyr") #reshape and clean the data#
require(foreign) #importing and exporting data#
require(ggplot2) #creating visualizations and plots#
library(fitdistrplus) #fitting probability distributions to data#
require(MASS) #GLM#
require(Hmisc) #basic descriptive statistics#
library(caret) #confusion matrix#
library(car) #ANOVA and VIF#
library(brant) #parallel lines test#
library(performance) #model evaluation#
library(corrplot) #correlation matrix#
library("ordinalNet") #regularized ordinal regression with elastic-net approach#
library(ordinalgmifs) #generalized monotone incremental forward stagewise#

#Data of Social Science Students#

#importing data into R Studio
datasoshum1 = read_excel(file.choose(),1)
datasoshum1

#converting the Y variable into an ordinal variable
Y <- datasoshum1$Y
descdist(Y, discrete = FALSE)
datasoshum1$Y <- as.ordered(datasoshum1$Y)
str(datasoshum1)

#ordinal regression without the elastic-net approach
#to first examine whether the data has multicollinearity
modelsoshum <- polr(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9, data=datasoshum1, method = "logistic", Hess = TRUE)
summary(modelsoshum)
(ctable <- coef(summary(modelsoshum)))
p1 <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE)*2
(ctable <- cbind(ctable, "p value" = p1))
Anova(modelsoshum)

#check the normality of the data
shapiro.test(datasaintek1$X1) #the data isn't normally distributed

#multicollinearity check
multicollinearity(modelsoshum)
#use "spearman" if the data is ordinal and not normally distributed
corrplot(cor(datasoshum1[c("X1","X2","X3","X4","X5","X6","X7","X8","X9")], method="spearman"), method="number")
#the data has multicollinearity issues, making the regularization elastic-net suitable for this method

#parallel lines assumption check
brant(modelsoshum) #if all p-value > alpha, the paralel lines assumption is met
#since this assumption holds for some variables but not others, the partial proporsional odds model is applied

#split the data into training and testing sets with a 75:25 ratio
samplesize=0.75*nrow(datasoshum1)
set.seed(123)
index = sample(seq_len(nrow(datasoshum1)), size = samplesize)
trainsoshum = datasoshum1[index,]
trainsoshum
testsoshum = datasoshum1[-index,]
testsoshum

#separate the variables into X (predictor variables) and Y (response variable)
y_trainsoshum = trainsoshum$Y
y_testsoshum = testsoshum$Y
x_trainsoshum = trainsoshum[,-1]
x_trainsoshum <- as.matrix(x_trainsoshum)
x_testsoshum = testsoshum[,-1]
x_testsoshum <- as.matrix(x_testsoshum)

#ELASTIC-NET#
library("ordinalNet")
library(ordinalgmifs) #generalized monotone incremental forward stagewise
fit_soshum <- ordinalNet(x_trainsoshum, y_trainsoshum, family="cumulative", link="logit", parallelTerms=TRUE, nonparallelTerms=TRUE)
summary(fit_soshum)
coef(fit_soshum, matrix=TRUE)

fit_soshum_tune <- ordinalNetTune(x_trainsoshum, y_trainsoshum, family="cumulative", link="logit", parallelTerms=TRUE, nonparallelTerms=TRUE, nFolds=5, printProgress=FALSE)
bestLambdaIndex_soshum <- which.max(rowMeans(fit_soshum_tune$loglik))
bestLambdaIndex_soshum
bestlambda_soshum <- fit_soshum_tune$lambda[bestLambdaIndex_soshum]
bestlambda_soshum
coef(fit_soshum_tune$fit, matrix=TRUE, lambda=bestlambda_soshum)

set.seed(123)
nFolds <- 5
n <- nrow(x_trainsoshum)
indexRandomOrder<-sample(n)
folds <- split(indexRandomOrder, rep(1:nFolds, length.out=n))
fit_soshum_cv <- ordinalNetCV(x_trainsoshum, y_trainsoshum, family="cumulative", link="logit", alpha=0.5, parallelTerms=TRUE, nonparallelTerms=TRUE, printProgress = FALSE, nFolds=5, nLambda=20, tuneMethod="cvLoglik")
summary(fit_soshum_cv)
coef(fit_soshum_cv$fit, matrix=TRUE, lambda=bestlambda_soshum)
elasticnet_soshum <- predict(fit_soshum_cv$fit, type = "class", newx = x_testsoshum, lambda=bestlambda_soshum)

#elastic-net prediction social
y_actual <- factor(testsoshum$Y)
elasticnet_pred <-factor(elasticnet_soshum)
u <- union(y_actual, elasticnet_pred)
actual<-factor(y_actual, u)
predict<-factor(elasticnet_pred, u)
t<-table(predict,actual)
confusionMatrix(t)

#--------------------------------------------------------------------------------#

#Data of Natural Science Students#

#importing data into R Studio
datasaintek1 = read_excel(file.choose(),2)
datasaintek1

#converting the Y variable into an ordinal variable
Y <- datasaintek1$Y
descdist(Y, discrete = FALSE)
datasaintek1$Y <- as.ordered(datasaintek1$Y)
str(datasaintek1)

#ordinal regression without the elastic-net approach
#to first examine whether the data has multicollinearity
modelsaintek <- polr(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9, data=datasaintek1, method = "logistic", Hess = TRUE)
summary(modelsaintek)
(ctable <- coef(summary(modelsaintek)))
p1 <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE)*2
(ctable <- cbind(ctable, "p value" = p1))
Anova(modelsaintek)

#check the normality of the data
shapiro.test(datasaintek1$X1) #the data isn't normally distributed

#multicollinearity check
multicollinearity(modelsaintek)
#use "spearman" if the data is ordinal and not normally distributed 
corrplot(cor(datasaintek1[c("X1","X2","X3","X4","X5","X6","X7","X8","X9")], method="spearman"), method="number")
#the data has multicollinearity issues, making the regularization elastic-net suitable for this method

#parallel lines assumption check
brant(modelsaintek) #if all p-value > alpha, the paralel lines assumption is met
#since this assumption holds for some variables but not others, the partial proporsional odds model is applied

#split the data into training and testing sets with a 75:25 ratio
samplesize=0.75*nrow(datasaintek1)
set.seed(123)
index = sample(seq_len(nrow(datasaintek1)), size = samplesize)
trainsaintek = datasaintek1[index,]
trainsaintek
testsaintek = datasaintek1[-index,]
testsaintek

#separate the variables into X (predictor variables) and Y (response variable)
y_trainsaintek = trainsaintek$Y
y_testsaintek = testsaintek$Y
x_trainsaintek = trainsaintek[,-1]
x_trainsaintek <- as.matrix(x_trainsaintek)
x_testsaintek = testsaintek[,-1]
x_testsaintek <- as.matrix(x_testsaintek)

#ELASTIC-NET#
fit_saintek <- ordinalNet(x_trainsaintek, y_trainsaintek, family="cumulative", link="logit", parallelTerms=TRUE, nonparallelTerms=TRUE)
summary(fit_saintek)
coef(fit_saintek, matrix=TRUE)

fit_saintek_tune <- ordinalNetTune(x_trainsaintek, y_trainsaintek, family="cumulative", link="logit", parallelTerms=TRUE, nonparallelTerms=TRUE, nFolds=5, printProgress=FALSE)
bestLambdaIndex_saintek <- which.max(rowMeans(fit_saintek_tune$loglik))
bestLambdaIndex_saintek
bestlambda_saintek <- fit_saintek_tune$lambda[bestLambdaIndex_saintek]
bestlambda_saintek
coef(fit_saintek_tune$fit, matrix=TRUE, lambda=bestlambda_saintek)

set.seed(123)
nFolds <- 5
n <- nrow(x_trainsaintek)
fit_saintek_cv <- ordinalNetCV(x_trainsaintek, y_trainsaintek, family="cumulative", link="logit", alpha=0.5, parallelTerms=TRUE, nonparallelTerms=TRUE, printProgress = FALSE, nFolds=5, nLambda=20, tuneMethod="cvLoglik")
summary(fit_saintek_cv)
coef(fit_saintek_cv$fit, matrix=TRUE, lambda=bestlambda_saintek)
elasticnet_saintek <- predict(fit_saintek_cv$fit, type = "class", newx = x_testsaintek, lambda=bestlambda_saintek)

#elastic-net prediction natural
y_actual1 <- factor(testsaintek$Y)
elasticnet_pred1 <-factor(elasticnet_saintek)
u1 <- union(y_actual1, elasticnet_pred1)
actual1<-factor(y_actual1, u1)
predict1<-factor(elasticnet_pred1, u1)
t1<-table(predict1,actual1)
confusionMatrix(t1)