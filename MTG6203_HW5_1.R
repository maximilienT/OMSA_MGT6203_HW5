# 1. install and load packages
install.packages(c("tm","SnowballC","topicmodels","wordcloud"))
library(tm); library(SnowballC); library(topicmodels); library(wordcloud)

# 2. import data and convert to corpus
text_data <- read.csv("News.csv")

corp_data <- Corpus(DataframeSource(text_data))

# 3. preprocess the text data
preprocess_corp <- tm_map(corp_data, stripWhitespace)
preprocess_corp <- tm_map(preprocess_corp, removePunctuation)
preprocess_corp <- tm_map(preprocess_corp, removeNumbers)
preprocess_corp <- tm_map(preprocess_corp, removeWords, stopwords("english"))
preprocess_corp <- tm_map(preprocess_corp, stemDocument)

# 4. Create DTM
DTM <- DocumentTermMatrix(preprocess_corp, control =list(bounds = list(global = c(3, Inf))))

# 5. Perform LDA
set.seed(1000)
tm <- LDA(DTM, 20, method="Gibbs", control=list(iter=1000, verbose=50))

# 6. Extract posterior distributions
tm.res <- posterior(tm)

beta <- tm.res$terms
dim(beta)
beta[,1:5]
rowSums(beta)

theta <- tm.res$topics
dim(theta)
theta[1:5,]
rowSums(theta)[1:10]

# 7. display the 10 most relevant terms for each topic
terms(tm, 10)

# 8. Pick a news article and analyze
as.character(corp_data[2]$content)
barplot(theta[2,])

top.terms.prob <- sort(beta[16,], decreasing=TRUE)[1:50]
wordcloud(names(top.terms.prob), top.terms.prob, random.order=FALSE)
