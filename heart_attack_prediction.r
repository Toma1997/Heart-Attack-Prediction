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
str(data) # List the structure of the data.
```


