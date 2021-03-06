```{r}
library(readr)
# This dataset is downloaded from Kaggle https://www.kaggle.com/nareshbhat/health-care-data-set-on-heart-attack-possibility and it will be used for heart attack prediction."
data <- read.csv("heart_attack_dataset.csv", na="NA")
head(data, 10)
```


```{r}
names(data)[1] <- "age" # Rename the first column.
head(data, 10)
```

```{r}
colSums(data, na.rm = TRUE, dims = 1) # Sum by columns without NA values.
```
```{r}
colSums(is.na(data)) # There are no missig values.
```
```{r}
# If there are some missing values, replace it with mean value.
data$thalach[is.na(data$thalach)] <- mean(data$thalach, na.rm = TRUE)
na.omit(data) # Exclude missing values.
```


```{r}
str(data) # List the structure of the data.
```

```{r}
par(mfrow = c(2, 2)) 
hist(data$age, main = "Age Distribution", xlab = "age")
hist(data$thalach, main = "Max Heart Rate Distribution", xlab = "thalach")
hist(data$chol, main = "Serum cholestoral ", xlab = "chol")
hist(data$restbps, main = "Resting blood pressure", xlab = "restbps")
#hist(data$age, main = "Pateints Age Distribution", xlab = "age")
```

```{r}
x <- data$age
y <- data$thalach 
plot(x, y, main = "Relationship between age and maximum heart rate achieved", xlab = "age", ylab = "Max heart rate achieved", pch = 15, frame = FALSE)
abline(lm(y ~ x, data = data), col = "blue") # Correlation is weak.

```


```{r}
summary(data) # Statistic informations
```
```{r}
sapply(data, class)
```
```{r}
library(corrplot)
corMatrix <- cor(data) #Compute all correlations between each other and form correlation matrix.
corrplot(corMatrix,order = "FPC",method = "color",type = "lower", tl.cex = 0.6, tl.col = "black")
# Principal Component Analysis is not necessary since there are not to much strong correlations between features and target values.
```


```{r}
data <- transform(
  data,
  age=as.integer(age),
  sex=as.factor(sex),
  cpt=as.factor(cpt),
  restbps=as.integer(restbps),
  chol=as.integer(chol),
  fbs=as.factor(fbs),
  restecg=as.factor(restecg),
  thalach=as.integer(thalach),
  exang=as.factor(exang),
  oldpeak=as.numeric(oldpeak),
  slope=as.factor(slope),
  ca=as.factor(ca),
  thal=as.factor(thal),
  target=as.factor(target)
)
str(data)
```

```{r}
# Split the data to training and test sets.
smp_size=floor(0.75*nrow(data))
train_ind=sample(seq_len(nrow(data)),size=smp_size)
train_set=subset(data[train_ind,], sample = TRUE)
test_set= subset(data[-train_ind,], sample = FALSE)
dim(train_set)
dim(test_set)
```
```{r}
library(randomForest)
# Train model with Random Forest
rfModel <- randomForest(formula =target ~ ., data=train_set, importance=TRUE)
rfModel
```

```{r}
# Test the model
predicted = predict(rfModel, newdata=test_set[-14])
confusionMatrix = table(test_set[,14], predicted)
confusionMatrix
```

```{r}
# Calculate the Model Accuracy in percentage.
model_accuracy = mean(predicted == test_set$target)
model_accuracy
```

