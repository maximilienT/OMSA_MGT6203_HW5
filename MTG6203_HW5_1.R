# 1. install and load packages
install.packages(c("tm","SnowballC","topicmodels","wordcloud"))
library(tm); library(SnowballC); library(topicmodels); library(wordcloud)

# 2. import data and convert to corpus
text_data <- read.csv("News.csv")

corp_data <- Corpus(DataframeSource(text_data))

# 3. preprocess the text data
