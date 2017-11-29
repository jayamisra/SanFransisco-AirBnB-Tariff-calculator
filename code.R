library(psych)
library(lattice)
library(glmnet)
library(caret)

data_airbnb<- readRDS("./data_airbnb.rds")

data_private <- data_airbnb[data_airbnb$room_type == 'Private room', ]
data_shared <- data_airbnb[data_airbnb$room_type == 'Shared room', ]
data_home <- data_airbnb[data_airbnb$room_type == 'Entire home/apt', ]

lasso_private <- train(price ~ neighborhood+accommodates+bedrooms,
               data = data_private,
               preProcess = c("center", "scale"),
               method = "glmnet",
               tuneGrid= expand.grid(
                 alpha=1,
                 lambda = seq(0,10, .1)))

lasso_shared <- train(price ~ neighborhood+accommodates+bedrooms,
               data = data_shared,
               preProcess = c("center", "scale"),
               method = "glmnet",
               tuneGrid= expand.grid(
                 alpha=1,
                 lambda = seq(0,10, .1)))

lasso_home <- train(price ~ neighborhood+accommodates+bedrooms,
               data = data_home,
               preProcess = c("center", "scale"),
               method = "glmnet",
               tuneGrid= expand.grid(
                 alpha=1,
                 lambda = seq(0,10, .1)))
saveRDS(unique(data_airbnb$neighborhood),file="./neighbourhoods.rds")
saveRDS(lasso_private,file = "./lasso_private.rds")
saveRDS(lasso_shared,file = "./lasso_shared.rds")
saveRDS(lasso_home,file = "./lasso_home.rds")



