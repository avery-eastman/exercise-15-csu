# Avery Eastman, 03/25/2025
# Daily Assignment 15

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



# Model Fitting and Workflow ----------------------------------------------

# Avery Eastman, 03/31/2025
# Daily Assignment 16

# Instructions:

# Open your R script from the last daily assignment
# Add a new section for the model fitting and workflow

library(tidymodels)
install.packages("forested")
library(forested)

set.seed(123)
forested_split <- initial_split(forested, prop = .8, strata = tree_no_tree)
forested_train <- training(forested_split)
forested_test  <- testing(forested_split)
forested_folds <- vfold_cv(forested_train, v = 10)

# Define a logistic regression model and a rand_forest model 
log_mod <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification")

install.packages("ranger")

rand_forest_mod <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification")

# Set up a workflow_set() to compare the logistic regression model (the winner of lecture here) to the rand_forest model you create. Use accuracy as your primary metric to rank the models.
wf_set <- 
  workflow_set(list(forested ~ .), list(log_mod, rand_forest_mod)) |>
  workflow_map("fit_resamples", resamples = forested_folds)

autoplot(wf_set) + 
  theme_linedraw()

rank_results(wf_set, 
             rank_metric = "accuracy", 
             select_best = TRUE)

# As a comment, write a sentence about what model you think is best!
# I think the rand_forest model is best for this data set because based on accuracy it is ranked higher than the logistic regression model. 
