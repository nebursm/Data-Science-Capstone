# This procedure addresses the following question of the project:
#
# Find the most reliable users based on number of reviews, time as yelp user, 
# number of tips, number of compliments, number of fans and number of friends. 
# Derive the rules that characterizes this group so any "yelper" could apply 
# these rules to decide which reviews could be more valuable.
# 

library(doMC)
registerDoMC(cores = 6)

library(cluster)
library(broom)
library(sqldf)
library(igraph)
library(dplyr)
library(ggplot2)


# Read user data
user <- read.csv("data/user.csv", stringsAsFactors = FALSE)

user_sub <- na.omit(user[, 5:13])
user_scale <- scale(user_sub)

set.seed(12345)
samp <- sample(nrow(user_scale), size=1000)
user_scale_samp <- user_scale[samp, ]
kclusts <- data.frame(k=1:9) %>% group_by(k) %>% do(kclust=kmeans(user_scale_samp, .$k))
clusters <- kclusts %>% group_by(k) %>% do(tidy(.$kclust[[1]]))
assignments <- kclusts %>% group_by(k) %>% do(augment(.$kclust[[1]], user_scale_samp))
clusterings <- kclusts %>% group_by(k) %>% do(glance(.$kclust[[1]]))
ggplot(assignments, aes(review_count, fans)) + geom_point(aes(color=.cluster)) + facet_wrap(~ k)
ggplot(assignments, aes(review_count, tot_compliments)) + geom_point(aes(color=.cluster)) + facet_wrap(~ k)
ggplot(assignments, aes(review_count, average_stars)) + geom_point(aes(color=.cluster)) + facet_wrap(~ k) 
ggplot(clusterings, aes(k, tot.withinss)) + geom_line()
# From here we conclude that k=4 is a reasonable number of clusters
# More clusters add little value according to the total within sum of squares


# K-Means Cluster Analysis
fit <- kmeans(user_scale, 4) # 4 cluster solution
# get cluster means 
aggregate(user_sub,by=list(fit$cluster),FUN=mean)
# append cluster assignment
user_sub <- data.frame(user_sub, fit$cluster)
# append user_id
user_sub$user_id <- user$user_id
# subset cluster 2 which has the user_id with more reviews, fans, compliments, etc.
user_sub_cl2 <- user_sub[user_sub$fit.cluster == 2,]

       
# Network analysis of user friends
user_nodes <- read.csv("data/user_friend.csv", stringsAsFactors = FALSE)
dropcols <- grep("row_id",names(user_nodes))
user_nodes <- user_nodes[, -dropcols]
user_net <- graph.data.frame(user_nodes, directed=F)
summary(user_net)
max(degree(user_net))

# calculate the in and out degrees separately
outdeg <- degree(user_net, mode="out")
indeg <- degree(user_net, mode="in")
totdeg <- degree(user_net, mode="total")

# see which nodes have the max out and indegree
# in this case all are the same since we are using an undirected graph
V(user_net)[which.max(outdeg)]
V(user_net)[which.max(indeg)]
V(user_net)[which.max(totdeg)]

# find undirected betweenness (betweenness()) scores and then nodes with the max betweenness
# warning *** the following procedure could take many hours to complete ***
bet <- betweenness.estimate(user_net, directed=FALSE, cutoff=10)
V(user_net)[which.max(bet)]

# find the neighbors of this node
V(user_net)[V(user_net)[nei(which.max(bet))]]

# calculate Page Rank and find the node having the highest pagerank
pr <- page.rank(user_net)
V(user_net)[which.max(pr$vector)]

# Rank betweeness and page rank scores 
bet_rank <- rank(-unname(bet))
pr_rank <- rank(-unname(pr$vector))

# Get top nodes and find the intersection of nodes that are in both: top betweeness and top page rank 
n <- 20 # number of top nodes
top_bet <- V(user_net)[match(bet[bet_rank <= n], bet)]
top_pr <- V(user_net)[match(pr$vector[pr_rank <= n], pr$vector)]
top_both <- intersect(top_bet, top_pr)

# Create a subset network including only top nodes 
top_net <- induced_subgraph(user_net, top_both)

# Replace vertex labels with user names where available, otherwise use user_id
vnames <- paste(names(V(top_net)), collapse="','")
sql <- paste0("select uname, user_id from user where user_id in('", vnames, "')")
unames <- sqldf(sql)
unames <- rbind(unames, data.frame(uname=setdiff(names(V(top_net)), unames[,2]), user_id=setdiff(names(V(top_net)), unames[,2])))
V(top_net)$label <- unames[match(names(V(top_net)), unames[,2]),1]

# Plot the resulting network
par(mai=c(0,0,1,0)) 
plot(top_net, layout=layout.fruchterman.reingold, vertex.label.cex=0.8)

# Search common user_id from cluster and network analysis:
intersect(unames[,2],user_sub_cl2$user_id)
