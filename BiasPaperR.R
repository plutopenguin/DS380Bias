library(readr)
data <- read_tsv("C:/Users/taiyo/Downloads/job-genders.tsv")
data$Occupation <- NULL
genders <- c("Male", "Female", "Neutral", "?")
counter <- list()
for (i in unique(data$Category)){
  temp = data[data$Category==i,]
  temp$Category <- NULL
  temp2 <- as.numeric(table(unlist(temp)))
  counter[[length(counter)+1]] <- temp2
}
data_prop <- data.frame('Job_Category' = substr(unique(data$Category), 1, nchar(unique(data$Category))-12), 
                           'Male' = as.numeric(lapply(counter, function(x) round(x[3]/sum(x),3))),
                           'Female' = as.numeric(lapply(counter, function(x) round(x[2]/sum(x),3))),
                           'Neutral' = as.numeric(lapply(counter, function(x) round(x[4]/sum(x),3)))
                           )
total = sum(as.numeric(lapply(counter, function(x) sum(x))))
data_prop[23,] = c('Total', 
                   round(sum(as.numeric(lapply(counter, function(x) x[3]/total))),3),
                   round(sum(as.numeric(lapply(counter, function(x) x[2]/total))),3),
                   round(sum(as.numeric(lapply(counter, function(x) x[4]/total))),3)
                   )
data_prop
