# This procedure addresses the following question of the project:
#
# Which reviews (positive or negative) have more impact on business attendance (checkin) 
# by category (limited to restaurants and shopping).
# 

library(caret)

# Read business data
business <- read.csv("data/business.csv", stringsAsFactors = FALSE)
# Split the data in 2 subsets: one with low average rates (2 stars or less) and the 
# other with high rating (4 stars or more)
bus_low <- subset(business, stars <= 2.0, select = c(checkin_tot, stars))
bus_high <- subset(business, stars >= 4.0, select = c(checkin_tot, stars))

# Discard outliers (business with more than 500 checkins)
bus_sub <- subset(business, checkin_tot <= 500, select = c(checkin_tot, stars))
boxplot(bus_sub$checkin_tot ~ bus_sub$stars, xlab = "Stars", ylab = "Check-in", varwidth = TRUE, col = "red3", main="Distribution of total checkins accross rate (stars)")

# Explore correlation between ratings and checkin
cor(bus_low$checkin_tot, bus_low$stars)
cor(bus_high$checkin_tot, bus_high$stars)

# Plot the data
plot(density(bus_low$checkin_tot), main="Total Check-in Low", col="lightblue", lwd=3)
plot(density(bus_high$checkin_tot), main="Total Check-in High", col="lightblue", lwd=3)

hist(bus_low$stars, main="Stars Low", col="lightblue", lwd=3)
hist(bus_high$stars, main="Stars High", col="lightblue", lwd=3)

# Train a model using trees
fit_low <- train(stars ~ ., data=bus_low, method="rpart")
fit_high <- train(stars ~ ., data=bus_high, method="rpart")

# Print the resulting trees
library(rattle)
fancyRpartPlot(fit_low$finalModel)
fancyRpartPlot(fit_high$finalModel)
