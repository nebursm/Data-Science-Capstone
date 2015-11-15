# This procedure addresses the following question of the project:
#
# Investigate which attributes have more impact on business attendance (checkin) 
# by category (limited to restaurants and shopping).
#

# library(leaps)
library(doMC)
registerDoMC(cores = 6)

library(Hmisc)
library(caret)

# Read business data
business <- read.csv("data/business.csv", stringsAsFactors = FALSE)

# Replace logical values with dummy variables
for(t in unique(business$Alcohol)) {
  business[paste("Alcohol",t,sep=".")] <- ifelse(business$Alcohol==t,1,0)
}
for(t in unique(business$Noise_Level)) {
  business[paste("Noise_Level",t,sep=".")] <- ifelse(business$Noise_Level==t,1,0)
}
for(t in unique(business$Attire)) {
  business[paste("Attire",t,sep=".")] <- ifelse(business$Attire==t,1,0)
}
for(t in unique(business$Smoking)) {
  business[paste("Smoking",t,sep=".")] <- ifelse(business$Smoking==t,1,0)
}
for(t in unique(business$Wi_Fi)) {
  business[paste("Wi_Fi",t,sep=".")] <- ifelse(business$Wi_Fi==t,1,0)
}
for(t in unique(business$BYOB_Corkage)) {
  business[paste("BYOB_Corkage",t,sep=".")] <- ifelse(business$BYOB_Corkage==t,1,0)
}
for(t in unique(business$Ages_Allowed)) {
  business[paste("Ages_Allowed",t,sep=".")] <- ifelse(business$Ages_Allowed==t,1,0)
}

# Remove the columns that have been replaced with dummy variables
dropcols <- c("Alcohol","Noise_Level","Attire","Smoking","Wi_Fi","BYOB_Corkage","Ages_Allowed")
business <- business[, !names(business) %in% dropcols]

# Remove all "hair*" variables since they have nothing to do with restaurants or general shopping:
dropcols <- grep("hair_.",names(business))
business <- business[, -dropcols]

# Remove all "checkin" variables except "checkin_tot" which will be our predictor variable
dropcols <- c("checkin_mon","checkin_tue","checkin_wed","checkin_thr","checkin_fri","checkin_sat","checkin_sun")
business <- business[, !names(business) %in% dropcols]
dropcols <- grep("checkin_[0-9]",names(business))
business <- business[, -dropcols]

# Remove descriptive attributes 
dropcols <- c("row_id","business_id","full_address","open","city","state","bname","longitude","latitude","btype")
business <- business[, !names(business) %in% dropcols]
business[is.na(business)] <- -1

# Remove tip_count and review_count attributes since they can be counfounding variables
# because they are highly correlated with the predictor variable checkin_tot
dropcols <- c("tip_count", "review_count")
business <- business[, !names(business) %in% dropcols]

# Discretize the predictor variable "checkin_tot" and remove it from the dataframe
c <- c(50,500)
business$checkin_tot_disc <- as.numeric(cut2(business$checkin_tot, cuts = c))
bins <- levels(cut2(business$checkin_tot, cuts = c))
business$checkin_tot_disc[business$checkin_tot_disc == 1] <- "low"
business$checkin_tot_disc[business$checkin_tot_disc == 2] <- "med"
business$checkin_tot_disc[business$checkin_tot_disc == 3] <- "high"
dropcols <- c("checkin_tot")
business <- business[, !names(business) %in% dropcols]

# Subset business data into restaurant data and shopping data:
restaurants <- subset(business, category == "Restaurants")
shopping <- subset(business, category == "Shopping")
dropcols <- c("checkin_tot", "category")
restaurants <- restaurants[, !names(business) %in% dropcols]
shopping <- shopping[, !names(business) %in% dropcols]

# Remove other attributes with high correlation in restaurants:
cormat <- cor(restaurants[, 1:92])
cormat[is.na(cormat)] <- 1
hc = findCorrelation(cormat, cutoff=0.8)
restaurants_final <- restaurants[, -hc]
restaurants_final$checkin_tot_disc <- restaurants$checkin_tot_disc

# Remove other attributes with high correlation in shopping:
cormat <- cor(shopping[, 1:92])
cormat[is.na(cormat)] <- 1
hc = findCorrelation(cormat, cutoff=0.8)
shopping_final <- shopping[, -hc]
shopping_final$checkin_tot_disc <- shopping$checkin_tot_disc

# Create training and testing data for restaurants
set.seed(975)
ixTrain = createDataPartition(restaurants$checkin_tot_disc, p = 3/4)[[1]]
train_rest = restaurants_final[ ixTrain,]
test_rest = restaurants_final[-ixTrain,]

# Create training and testing data for shopping
set.seed(975)
ixTrain = createDataPartition(shopping$checkin_tot_disc, p = 3/4)[[1]]
train_shop = shopping_final[ ixTrain,]
test_shop = shopping_final[-ixTrain,]

# Train a random forest model for restaurants:
# *** warning: this could take several hours to complete ***
rest_trn_rf <- train(checkin_tot_disc ~ ., method="rf", data=train_rest, importance = T)

# Train a random forest model for shopping:
# *** warning: this could take several hours to complete ***
shop_trn_rf <- train(checkin_tot_disc ~ ., method="rf", data=train_shop, importance = T)

# Calculate model accuracy for each category:
pred_rest <- predict(rest_trn_rf, newdata=test_rest)
pred_shop <- predict(shop_trn_rf, newdata=test_shop)
rest_cm <- confusionMatrix(pred_rest, test_rest$checkin_tot_disc)
print(rest_cm$overall)
shop_cm <- confusionMatrix(pred_shop, test_shop$checkin_tot_disc)
print(shop_cm$overall)

# Variable importance for restaurants:
rest_imp <- varImp(rest_trn_rf)
plot(rest_imp, top = 10)

# Variable importance for shopping:
shop_imp <- varImp(shop_trn_rf)
plot(shop_imp, top = 10)

# Generate new models using only top 10 variables to compare with original models
rest_newcols <- row.names(rest_imp[1]$importance[order(rest_imp$importance[1], decreasing=T),])[1:10]
shop_newcols <- row.names(shop_imp[1]$importance[order(shop_imp$importance[1], decreasing=T),])[1:10]
rest_new <- restaurants[, names(restaurants) %in% rest_newcols]
rest_new$checkin_tot_disc <- restaurants$checkin_tot_disc
shop_new <- shopping[, names(shopping) %in% shop_newcols]
shop_new$checkin_tot_disc <- shopping$checkin_tot_disc

# Create training and testing data for reduced restaurants dataset
set.seed(975)
ixTrain = createDataPartition(rest_new$checkin_tot_disc, p = 3/4)[[1]]
train_rest = rest_new[ ixTrain,]
test_rest = rest_new[-ixTrain,]

# Create training and testing data for reduced shopping dataset
set.seed(975)
ixTrain = createDataPartition(shop_new$checkin_tot_disc, p = 3/4)[[1]]
train_shop = shop_new[ ixTrain,]
test_shop = shop_new[-ixTrain,]

# Train a random forest model for reduced restaurants dataset:
rest_trn_rf2 <- train(checkin_tot_disc ~ ., method="rf", data=train_rest, importance = T)

# Train a random forest model for reduced shopping dataset:
shop_trn_rf2 <- train(checkin_tot_disc ~ ., method="rf", data=train_shop, importance = T)

# Calculate model accuracy for each category and compare with previous model:
pred_rest2 <- predict(rest_trn_rf2, newdata=test_rest)
pred_shop2 <- predict(shop_trn_rf2, newdata=test_shop)
rest_cm2 <- confusionMatrix(pred_rest2, test_rest$checkin_tot_disc)
print(rest_cm$overall)
print(rest_cm2$overall)
shop_cm2 <- confusionMatrix(pred_shop2, test_shop$checkin_tot_disc)
print(shop_cm$overall)
print(shop_cm2$overall)

