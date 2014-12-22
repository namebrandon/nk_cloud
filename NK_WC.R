library('tm')
library('RColorBrewer')
library('wordcloud')

setwd('C:\\Users\\Brandon\\Desktop')
nk.corp  <-Corpus(DirSource("NK"), readerControl = list(language="lat"))


nk.corp <- tm_map(nk.corp, removePunctuation)
nk.corp <- tm_map(nk.corp, content_transformer(tolower))


nk.corp <- tm_map(nk.corp, function(x) removeWords(x, stopwords("english")))
nk.tdm <- TermDocumentMatrix(nk.corp)
nk.m <- as.matrix(nk.tdm)
nk.v <- sort(rowSums(nk.m),decreasing=TRUE)
nk.d <- data.frame(words = names(nk.v),freq=nk.v)

nk.pal <- brewer.pal(8,"Dark2")
png("NK_cloud.png", width=800,height=800)

wordcloud(nk.d$words,nk.d$freq, scale=c(8,.2),min.freq=2,
          max.words=Inf, random.order=FALSE, rot.per=.25, colors=nk.pal, use.r.layout=FALSE, fixed.asp=TRUE)
dev.off()