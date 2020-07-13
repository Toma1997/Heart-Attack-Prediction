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
# Drop target column to make new prediction on dataset.
x = subset(data, select = -c(target))
y = data$target
```

