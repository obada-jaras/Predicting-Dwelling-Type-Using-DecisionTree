library("C50")

features <- c("H1", "H2", "H6", "H6_1", "H13_2", "H18_2", "H22_1",
              "H3_H4_merged", "ID1", "ID2", "I06_01", "Localtype", 
              "Region", "T2_2A")

dataframe_subset <- data[, features]
dataframe_subset$H1 <- as.factor(dataframe_subset$H1)

ctrl = C5.0Control(sample = 0.7,
                   seed = 123,
                   winnow = T,
                   fuzzyThreshold = T,
                   CF = 0.4,
                   minCases = 6)

model <- C5.0(dataframe_subset[,-1], dataframe_subset$H1, control = ctrl, trials = 3)
summary(model)


plot(model)
