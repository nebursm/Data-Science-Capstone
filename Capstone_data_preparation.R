# Prepare the data

# This procedure transforms JSON data to relational in order to do exploratory analysis
# using SQL.

setwd("~/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset")
library(jsonlite)

# Extract general business data
business_data <- stream_in(file("yelp_academic_dataset_business.json"))
# business_sub <- business_data[1:100,]
business_tab <- subset(business_data,,select=c("business_id", "full_address", "open", "city", 
                                               "state",  "review_count", "name", "longitude", 
                                               "latitude", "stars", "type"))
write.csv(business_tab, file = "business_tab.csv")

# Extract business category data
b_id <- character(nrow(business_data)*10)
b_cat <- character(nrow(business_data)*10)
rnum <- 0
for (i in 1:nrow(business_data)) {
  if (length(business_data$categories[i][[1]]) > 0) {
    for (j in 1:length(business_data$categories[i][[1]])) {
      rnum <- rnum + 1
      #print(paste(rnum, business_data$business_id[i], business_data$categories[i][[1]][j]))
      b_id[rnum] <- business_data$business_id[i]  
      b_cat[rnum] <- business_data$categories[i][[1]][j]
    } 
  }
}
b_id <- b_id[b_id != ""]
b_cat <- b_cat[b_cat != ""]
cat_tab <- data.frame(b_id, b_cat)
write.csv(cat_tab, file = "cat_tab.csv")

# Extract business attribute data
att_name <- names(business_data$attributes)
att_tab <- data.frame(business_data$business_id, stringsAsFactors = F)
for (i in 1:length(att_name)) {
  att_tab[att_name[i]] <- business_data$attributes[i]
}

att_name <- names(att_tab$Ambience)
for (i in 1:length(att_name)) {
  att_tab[paste0("ambience.",att_name[i])] <- att_tab$Ambience[i]
}
att_tab <- subset(att_tab, select = -Ambience)

att_name <- names(att_tab$"Good For")
for (i in 1:length(att_name)) {
  att_tab[paste0("good_for.",att_name[i])] <- att_tab$"Good For"[i]
}
att_name <- "Good For"
att_tab <- att_tab[,! names(att_tab) == att_name]

att_name <- names(att_tab$Parking)
for (i in 1:length(att_name)) {
  att_tab[paste0("parking.",att_name[i])] <- att_tab$"Parking"[i]
}
att_name <- "Parking"
att_tab <- att_tab[,! names(att_tab) == att_name]

att_name <- names(att_tab$Music)
for (i in 1:length(att_name)) {
  att_tab[paste0("music.",att_name[i])] <- att_tab$"Music"[i]
}
att_name <- "Music"
att_tab <- att_tab[,! names(att_tab) == att_name]

att_name <- names(att_tab$"Hair Types Specialized In")
for (i in 1:length(att_name)) {
  att_tab[paste0("hair.",att_name[i])] <- att_tab$"Hair Types Specialized In"[i]
}
att_name <- "Hair Types Specialized In"
att_tab <- att_tab[,! names(att_tab) == att_name]

att_name <- names(att_tab$"Payment Types")
for (i in 1:length(att_name)) {
  att_tab[paste0("payment.",att_name[i])] <- att_tab$"Payment Types"[i]
}
att_name <- "Payment Types"
att_tab <- att_tab[,! names(att_tab) == att_name]

att_name <- names(att_tab$"Dietary Restrictions")
for (i in 1:length(att_name)) {
  att_tab[paste0("dietary.",att_name[i])] <- att_tab$"Dietary Restrictions"[i]
}
att_name <- "Dietary Restrictions"
att_tab <- att_tab[,! names(att_tab) == att_name]

flatten2 <- function(x) {
  len <- sum(rapply(x, function(x) 1L))
  y <- vector('list', len)
  i <- 0L
  rapply(x, function(x) { i <<- i+1L; y[[i]] <<- x })
  y
}

for (i in 1:length(att_tab$"Accepts Credit Cards")) {    
  att_tab$"Accepts Credit Cards" <- att_tab$"Accepts Credit Cards"[[i]]  
}

write.csv(att_tab, file = "att_tab.csv", na = " ")

# Extract checkin data
checkin_data <- stream_in(file("yelp_academic_dataset_checkin.json"))
checkin_sub <- checkin_data[1:100,]
b_id <- checkin_data$business_id
att_name <- names(checkin_data$checkin_info)
att_name <- gsub("([0-9 ]+)-0", "sun-\\1",att_name)
att_name <- gsub("([0-9 ]+)-1", "mon-\\1",att_name)
att_name <- gsub("([0-9 ]+)-2", "tue-\\1",att_name)
att_name <- gsub("([0-9 ]+)-3", "wed-\\1",att_name)
att_name <- gsub("([0-9 ]+)-4", "thr-\\1",att_name)
att_name <- gsub("([0-9 ]+)-5", "fri-\\1",att_name)
att_name <- gsub("([0-9 ]+)-6", "sat-\\1",att_name)
checkin_tab <- data.frame(checkin_data$business_id)
for (i in 1:length(names(checkin_data$checkin_info))) {
  checkin_tab[att_name[i]] <- checkin_data$checkin_info[i] 
}
checkin_tab[is.na(checkin_tab)] <- 0
write.csv(checkin_tab, file = "checkin_tab.csv")

# Extract review data
review_data <- stream_in(file("yelp_academic_dataset_review.json"))
review_sub <- review_data[1:100,]
review_tab <- subset(review_data,,select=c("business_id", "user_id", "review_id", "date", 
                                               "stars",  "text"))
att_name <- names(review_data$votes)
for (i in 1:length(names(review_data$votes))) {
  review_tab[att_name[i]] <- review_data$votes[i] 
}
write.csv(review_tab, file = "review_tab.csv")

# Extract tip data
tip_data <- stream_in(file("yelp_academic_dataset_tip.json"))
tip_sub <- tip_data[1:100,]
tip_tab <- subset(tip_data,,select=c("business_id", "user_id", "date", 
                                          "likes",  "text"))
write.csv(tip_tab, file = "tip_tab.csv")

# Extract user general data
user_data <- stream_in(file("yelp_academic_dataset_user.json"))
user_sub <- user_data[1:100,]
user_tab <- subset(user_data,,select=c("user_id", "name", "yelping_since", "review_count",
                                    "fans",  "average_stars"))
att_name <- names(user_data$votes)
for (i in 1:length(names(user_data$votes))) {
  user_tab[att_name[i]] <- user_data$votes[i] 
}
write.csv(user_tab, file = "user_tab.csv")

# Extract user friends
u_id <- character(nrow(user_data)*50)
u_frnd <- character(nrow(user_data)*50)
rnum <- 0
for (i in 1:nrow(user_data)) {
  if (length(user_data$friends[[i]]) > 0) {
    for (j in 1:length(user_data$friends[[i]])) {
      rnum <- rnum + 1
      u_id[rnum] <- user_data$user_id[i]  
      u_frnd[rnum] <- user_data$friends[[i]][j]
    } 
  }
}
u_id <- u_id[u_id != ""]
u_frnd <- u_frnd[u_frnd != ""]
friend_tab <- data.frame(u_id, u_frnd)
write.csv(friend_tab, file = "friend_tab.csv")

# Extract user compliments
att_name <- names(user_data$compliments)
compl_tab <- data.frame(user_data$user_id)
for (i in 1:length(names(user_data$compliments))) {
  compl_tab[att_name[i]] <- user_data$compliments[i] 
}
compl_tab[is.na(compl_tab)] <- 0
write.csv(compl_tab, file = "compl_tab.csv")
