---
title: "Data Science Capstone Project"
author: "Ruben Adad"
date: "November/15 de 2015"
output: html_document
---

# Title
The purpose of this project is to come up with some interesting questions around the online review data available from the Yelp Data Set Challenge (http://www.yelp.com/dataset_challenge) and try to find plausible answers to them.

# Introduction
I will address the following questions:

1. Which reviews (positive or negative) have more impact on business attendance (check-in) by category (limited to restaurants and shopping).

2. Investigate which attributes have more impact on business attendance (check-in) by category (limited to restaurants and shopping). 

3. Find the most reliable users based on the number of reviews, time as yelp user, the number of tips, number of compliments, number of fans and number of friends. Derive the rules that characterize this group so any "yelper" could apply these rules to decide which reviews could be more valuable.

I think that the answers to these questions could be of interest to business owners and Yelp users as well.

In order to keep this report brief, I will only show the most relevant results. The details of the whole process I followed can be found on github:

* https://github.com/nebursm/Data-Science-Capstone 

# Methods and Data

## Data preparation
After reading the data, I loaded it into MongoDB since it directly supports JSON format. The
script for loading the data can be found in the following file **mongoscript.txt**. Then I
used the community edition of Mongo Management Studio (http://www.litixsoft.de) to browse
through the data.

Then I transform the JSON data to relational format. The reason
for this is that I believe SQL is a much more powerful language for exploratory 
analysis than MongoDB query capabilities. The R script for doing the transformation can be found in the following file **Capstone_data_preparation.R**.

After this, I loaded the data in a MySQL database. The procedure for loading the data and the
DDL to create the tables can be found in the following file **yelp_01.sql**. In the file 
**yelp_02.sql** you can find some sample queries. Finally a picture of the data model showing the
relationship between the tables can be found in **yelp_datamodel.pdf**.

Based on this exploratory analysis I formulated the research questions and device possible outcomes for each of them.

## Which reviews have more impact on business attendance

Contrary to my expectations it seems that there is no significant relationship between the
variables *stars* and *checkin_tot*. As you can see in the following lines the correlation 
of these two variables is pretty close to zero. 

I also tried to build a prediction model using trees for these two variables and the result
I got once again show me that there is no meaningful relationship regardless of the number
of stars the business has. 

The complete R script is in the file **Capstone_Question01.R**.




```r
# Read business data
business <- read.csv("data/business.csv", stringsAsFactors = FALSE)
# Split the data in 2 subsets: one with low average rates (2 stars or less) and the 
# other with high rating (4 stars or more)
bus_low <- subset(business, stars <= 2.0, select = c(checkin_tot, stars))
bus_high <- subset(business, stars >= 4.0, select = c(checkin_tot, stars))

# Discard outliers (business with more than 500 checkins)
bus_sub <- subset(business, checkin_tot <= 500, select = c(checkin_tot, stars))
boxplot(bus_sub$checkin_tot ~ bus_sub$stars, xlab = "Stars", ylab = "Check-in", varwidth = TRUE, col = "red3", main="Distribution of total checkins accross rate (stars)")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

```r
# Explore correlation between ratings and checkin
cor_tab <- data.frame(low=cor(bus_low$checkin_tot, bus_low$stars), high=cor(bus_high$checkin_tot, bus_high$stars))
cor_tab
```

```
##         low       high
## 1 0.1161453 -0.1131387
```

```r
# Train a model using trees
fit_low <- train(stars ~ ., data=bus_low, method="rpart")
```

```
## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
## trainInfo, : There were missing values in resampled performance measures.
```

```r
fit_high <- train(stars ~ ., data=bus_high, method="rpart")
```

```
## Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info =
## trainInfo, : There were missing values in resampled performance measures.
```

```r
# Print the resulting trees
library(rattle)
par(mfrow = c(1,2))
fancyRpartPlot(fit_low$finalModel)
fancyRpartPlot(fit_high$finalModel)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-2.png) 

## Investigate which attributes have more impact on business attendance



The complete R script for this question is in the file **Capstone_Question02.R**.

The general procedure is as follows:

1. Read business data. The result is a data frame with 22,075 observations and 124 variables.
2. Replace all logical variables with dummy variables.
3. Remove all unnecessary columns.
4. Remove confounding variables (tip_count and review_count because they are highly correlated with the predictor variable checkin_tot).
5. Discretize the predictor variable *checkin_tot*.
6. Subset business data into restaurant data and shopping data.
7. Remove other attributes with high correlation in each subset.
8. Create training and testing data for each subset.
9. Train a random forest model for each training subset.
10. Calculate model accuracy for each category (restaurant, shopping).
11. Print the 10 most important variables for each category.
12. Generate new models using only top 10 variables to compare with original models.

The following code partially illustrates steps 10 to 12 of the above procedure.


```r
# Calculate model accuracy for each category:
pred_rest <- predict(rest_trn_rf, newdata=test_rest)
```

```
## Error in eval(expr, envir, enclos): objeto 'By_Appointment_Only' no encontrado
```

```r
pred_shop <- predict(shop_trn_rf, newdata=test_shop)
```

```
## Error in eval(expr, envir, enclos): objeto 'By_Appointment_Only' no encontrado
```

```r
# Calculate model accuracy for each category and compare with previous model:
pred_rest2 <- predict(rest_trn_rf2, newdata=test_rest)
pred_shop2 <- predict(shop_trn_rf2, newdata=test_shop)
rest_cm2 <- confusionMatrix(pred_rest2, test_rest$checkin_tot_disc)
print("Restaurant comparision")
```

```
## [1] "Restaurant comparision"
```

```r
print(paste("Accuracy prev ==>",rest_cm$overall[1],"  Accuracy new ==>",rest_cm2$overall[1]))
```

```
## [1] "Accuracy prev ==> 0.716576279179439   Accuracy new ==> 0.659750058948361"
```

```r
shop_cm2 <- confusionMatrix(pred_shop2, test_shop$checkin_tot_disc)
print("Shopping comparision")
```

```
## [1] "Shopping comparision"
```

```r
print(paste("Accuracy prev ==>",shop_cm$overall[1],"  Accuracy new ==>",shop_cm2$overall[1]))
```

```
## [1] "Accuracy prev ==> 0.689655172413793   Accuracy new ==> 0.612068965517241"
```

## Find the most reliable users 



The complete R script for this question is in file **Capstone_Question03.R**.

To find the most reliable users I have used two different approaches. First I used an unsupervised clustering algorithm to split user data into groups. To find the number of clusters one option is to use the within sum of squares which measure the euclidean distance among the different members of each group for a different number of clusters. 


```r
set.seed(12345)
samp <- sample(nrow(user_scale), size=1000)
user_scale_samp <- user_scale[samp, ]
kclusts <- data.frame(k=1:9) %>% group_by(k) %>% do(kclust=kmeans(user_scale_samp, .$k))
clusters <- kclusts %>% group_by(k) %>% do(tidy(.$kclust[[1]]))
assignments <- kclusts %>% group_by(k) %>% do(augment(.$kclust[[1]], user_scale_samp))
clusterings <- kclusts %>% group_by(k) %>% do(glance(.$kclust[[1]]))
ggplot(assignments, aes(review_count, tot_compliments)) + geom_point(aes(color=.cluster)) + facet_wrap(~ k)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

```r
ggplot(clusterings, aes(k, tot.withinss)) + geom_line()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-2.png) 

From here we conclude that k=4 is a reasonable number of clusters. More clusters add little value according to the total within the sum of squares. Also, a visual examination of the distinct number of clusters confirms this. 

Using k-means we create 4 groups of users with the following characteristics:


```r
# get cluster means 
aggregate(user_sub,by=list(fit$cluster),FUN=mean)
```

```
##   Group.1 review_count       fans average_stars       funny      useful
## 1       1    838.82687 128.638806      3.816896  3527.76716  5112.20000
## 2       2   1602.19298 467.105263      3.832281 13242.85965 17645.64912
## 3       3     35.76066   1.214618      3.025897    19.33646    48.68826
## 4       4    371.77483  23.339781      3.780788   461.62385   867.17523
## 5       5     35.31426   1.462605      4.238075    16.69747    45.60521
##          cool tot_compliments user_friends tip_count fit.cluster user_id
## 1  4092.27463     4682.286567   503.050746 21.525373           1      NA
## 2 15104.94737    15592.561404  1075.859649 24.192982           2      NA
## 3    16.97402        9.836206     9.463203  4.429551           3      NA
## 4   543.62615      448.203522   121.970266 26.076501           4      NA
## 5    20.54235       12.793885    12.862065  4.985261           5      NA
```

So group 2 is the one with the users with more reviews, fans, friends, etc.

Now, the second approach used was using network analysis algorithms. For this, I have used the friends data to build a network with 2,576,179 nodes and 174,100 edges. Using this network I performed 2 analysis:

* Betweenness centrality: It is equal to the number of shortest paths from all vertices to all others that pass through that node. A node with high betweenness centrality has a large influence on the transfer of items through the network, under the assumption that item transfer follows the shortest paths. (https://en.wikipedia.org/wiki/Betweenness_centrality)
* Page Rank: The PageRank algorithm outputs a probability distribution used to represent the likelihood that a person randomly clicking on links will arrive at any particular page. (https://en.wikipedia.org/wiki/PageRank)

We obtain the top 20 users according to each criterion and then create a new subset from the intersection of both sets of users.

We can see the results in the following graph:


```r
# Plot the resulting network
par(mai=c(0,0,1,0)) 
plot(top_net, layout=layout.fruchterman.reingold, vertex.label.cex=0.8)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

Finally, we intersect this subset with the subset from cluster 2 to find the most influential users.

```r
# Search common user_id from cluster and network analysis:
intersect(unames[,2],user_sub_cl2$user_id)
```

```
## [1] "fczQCSmaWF78toLEmb0Zsw" "J3rNWRLRuZJ_0xsJalIhlA"
## [3] "kGgAARL2UmvCcTRfiscjug"
```

# Results

### Which reviews have more impact on business attendance
We have to further investigate if ratings influence Yelp users decision to attend a particular
business. From the results, I got it seems that ratings have little to do with business 
attendance.

### Investigate which attributes have more impact on business attendance
From the model accuracy, we can conclude that random forest generates a reasonable predicting model for business check-in. Accuracy for restaurants was 0.72 and for shopping 0.69. These models were built with 69 variables in the case of restaurants and 41 variables for shopping. If we build the models using only the 10 most influential variables we lost a little bit of accuracy, but we have more simple models. Accuracy drops from 0.72 to 0.66 in the model for restaurants, and from 0.69 to 0.61 in the one for shopping.

Most important variables for restaurants are:

```r
rest_imp <- varImp(rest_trn_rf)
plot(rest_imp, top = 10)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 

Most important variables for shopping are:

```r
shop_imp <- varImp(shop_trn_rf)
plot(shop_imp, top = 10)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

### Find the most reliable users 
Using clustering we were able to find a small group of 57 users which seems to be the most reliable because of their high participation in Yelp. Among other characteristics this group has the following (the figures were obtain using the mean value of each attribute for cluster 2):


```r
(aggregate(user_sub,by=list(fit$cluster),FUN=mean))[2,]
```

```
##   Group.1 review_count     fans average_stars    funny   useful     cool
## 2       2     1602.193 467.1053      3.832281 13242.86 17645.65 15104.95
##   tot_compliments user_friends tip_count fit.cluster user_id
## 2        15592.56      1075.86  24.19298           2      NA
```

From network analysis we obtained a group of 16 users which are the most influential according to betweenness centrality and page rank:


```r
V(user_net)[top_both]
```

```
## + 16/174100 vertices, named:
##  [1] 4ozupHULqGyO42s3zNUzOQ AaZdXn0I6F5bdIVwGpxdDA bM2OTIopnFoaQGLxK2PxPg
##  [4] cRyNICH0mhjxagvSyVr60Q CvMVd31cnTfzMUsHDXm4zQ fczQCSmaWF78toLEmb0Zsw
##  [7] J3rNWRLRuZJ_0xsJalIhlA kGgAARL2UmvCcTRfiscjug nEYPahVwXGD2Pjvgkm7QqQ
## [10] nKoB5cWZHXYUIUcQsUDogA pKh4Pc96YbOg-6hBOOajAA saiZmxzBIowJbMgPBW1Now
## [13] SfiNyNLmW7alXejl-m_iYw UKq38-9aOgEbJojosyS8gQ WKR1O8p216GT0YDQ7EjwCg
## [16] WmAyExqSWoiYZ5XEqpk_Uw
```

Finally, there are 3 users which are in both groups: cluster 2 and the 16 users from network analysis:


```r
intersect(unames[,2],user_sub_cl2$user_id)
```

```
## [1] "fczQCSmaWF78toLEmb0Zsw" "J3rNWRLRuZJ_0xsJalIhlA"
## [3] "kGgAARL2UmvCcTRfiscjug"
```

# Discussion

From the results obtained for each of my questions, the most surprising was that review ratings are not correlated to business attendance. I was trying to find if a negative review has more impact than a positive review or vice versa. There is one thing that could lead to further research. The correlation between low ratings (less or equal to 2 stars) and total check-ins is 0.12 while the correlation between high ratings (great or equal to 4 stars) and total check-ins is -0.11. Even though both values are close to zero one is positive and the other negative. Maybe if we extend the analysis to include the review text we can find something more interesting.  

The results for the other 2 questions are very interesting and could be of some values for 2 different groups. 

Remember that question 2 investigates the most significant attributes related to restaurant and shopping attendance. This results could be used by business owners to evaluate if adding some features to their places could lead to increase sales. For instance, providing wi-fi in restaurants or parking valet in shopping centers.   

In question 3 I tried to find the most reliable users using 2 approaches. The first one was to build a cluster of the user with more participation in Yelp and derive the group characteristics. So we found that users that on average have around 1,600 reviews, 400 fans, 1,000 friends, 15,000 compliments, etc. Yelp users could use this as criteria when checking a review and also could help to disregard fake reviews since I don't think fake reviews get as many compliments.

With the second approach, we used network analysis to get a list of more influential users according to their friends network. Once again, the reviews from this users could be the first to check for a Yelp user. 

Finally, all the results need to be updated periodically with new data from Yelp to keep the models current and valid.


