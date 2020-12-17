# Classification of Iris Flowers Project in Data Science 2

Classification of Iris Flowers using caret packages machine learning and other syntax in R that i have learn in Data Science 2
Learning Data Science is pretty fun for me, you will get your taste in different approach and statistical configuration in every data sets, Data science is helping people in various socioeconomic and health sectors. Therefore i realize that data and data scientist is there to help the world to become a better place. Learning Data Science in order to create better solutions for real-world problems that people may face today.

---

### Getting Started

1. Install packages

   `install.packages('caret')`

   We may need other packages, but caret should ask us if we want to load them. If you are having problems with packages, you can install the caret packages and all packages that you might need by typing:

   `install.packages("caret", dependencies=c("Depends", "Suggests"))`

   Now, lets load the package that we are going to use in this entire project setup

   `library(caret)`

   The caret package provide a consistent interface into hundreds of machine learning algorithms and provides useful convenience methods for data visualization, data resampling, model that need for training and model comparison, among other features. It's a must have tool for machine learing projects in R.

2. Load the Data

   `irisDataSet = read.csv("iris.csv", header=TRUE, stringsAsFactors=T)`

   **stringsAsFactors=T** to avoid random errors later on

   2.3 Create a Validation Dataset

   We need to know that the model we created is any good.

   Later, we will use statistical methods to estimate the accuracy of the models that we create on unseen data. We also want a more concrete estimate of the accuracy of the best model on unseen data by evaluating it on actual unseen data.
   That is, we are going to hold back some data that the algorithms will not get to see and we will use this data to get a second and independent idea of how accurate the best model might actually be.

   We will split the loaded dataset into two, 80% of which we will use to train our models and 20% that we will hold back as a validation dataset.

   #create a list of 80% of the rows in the original dataset we can use for training
   `validation_index = createDataPartition(irisDataSet$Species, p=0.80, list=FALSE);`

   #select 20% of the data for validation
   `validation = irisDataSet[-validation_index,];`

   #use remaining 80% of ata to training and testing the models
   `irisDataSet = irisDataSet[validation_index,]`
