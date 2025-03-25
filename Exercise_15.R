# Avery Eastman, 03/25/2025

# Instructions:

# Load the tidymodels package and the penguins dataset
library(tidymodels)
library(palmerpenguins)
data("penguins")

# Set a seed (set.seed())
set.seed(123)

# Split the data into training/testing sets with a proportion of 70%/30% split
# Extract the training and test tibbles into unique objects
penguins_split <- initial_split(penguins, prop = 0.7)
penguins_train <- training(penguins_split)
glimpse(penguins_train)
penguins_test <- testing(penguins_split)
glimpse(penguins_test)

# Create a 10 fold cross validation dataset based on the training data
penguin_folds <- vfold_cv(penguins_train, v = 10)
print(penguin_folds)
