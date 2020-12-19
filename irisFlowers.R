library(caret);
#
irisDataSet = read.csv("iris.csv", header=TRUE, stringsAsFactors=T);
#colnames(irisDataSet) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")

#create a list of 80% of the rows in the original dataset we can use for training
validation_index = createDataPartition(irisDataSet$Species, p=0.80, list=FALSE);

#select 20% of the data for validation
validation = irisDataSet[-validation_index,];
#use remaining 80% of ata to training and testing the models
irisDataSet = irisDataSet[validation_index,]

#dimensions of dataset
dim(irisDataSet)

# #list types for each attributes
sapply(irisDataSet, class);
# #take a peek at the first 5 rows of the data
head(irisDataSet)

# #list the levels for the lass
levels(irisDataSet$Species)

# #summarize the class distribution
percentage = prop.table(table(irisDataSet$Species)) * 100;
cbind(freq=table(irisDataSet$Species), percentage=percentage)

summary(irisDataSet)

#summary(irisDataSet)  
#split input and output                                                         
x = irisDataSet[,1:4];
y = irisDataSet[,5];

#boxplot or each attribute on one image
par(mfrow=c(1,4))
for(i in 1:4) {
    boxplot(x[,i], main=names(iris)[i])
}

#barplot for class breakdown
plot(y);

#scatter plot matrix
featurePlot(x=x, y=y, plot="ellipse");

#box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")

#density plots for each attribute by class value
scales = list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales);

#Run algorithms using 10-fold cross validation
control = trainControl(method="cv", number=10);
metric = "Accuracy"

#a) linear algorithms
set.seed(7)
fit.lda = train(Species~., data=irisDataSet, method="lda", metric=metric, trControl=control)
#b) nonlinear algorithms
#CART
set.seed(7)
fit.cart = train(Species~., data=irisDataSet, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn = train(Species~., data=irisDataSet, method="knn", metric=metric, trControl=control)
#c) advanced algoithms
#SVM
set.seed(7)
fit.svm = train(Species~., data=irisDataSet, method="svmRadial", metric=metric, trControl=control)
#Random Forest
set.seed(7)
fit.rf = train(Species~., data=irisDataSet, method="rf", metric=metric, trControl=control)

print(fit.lda);

# #summarize accuracy of models
results = resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
# #compare accuracy of models
dotplot(results)

#estimate skills of LDA on the validatio dataset
predictions = predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species);