install.packages("haven", "tidyverse", "Hmisc")


# Define a function to replace NULL, NA, and empty values with NA
replace_null_na_empty <- function(data) {
    data[grep("NULL", tolower(data), value = TRUE)] <- NA
    data[grep("NA", tolower(data), value = TRUE)] <- NA
    data[data == ""] <- NA
    return(data)
}

# Define a function to remove punctuation marks from the dataframe as they may cause errors in the model training process
remove_punctuations <- function(data) {
    data <- data %>% mutate_all(funs(gsub(",", "  ", .)))
    data <- data %>% mutate_all(funs(gsub("[()]", "   ", .)))
    data <- data %>% mutate_all(funs(gsub("'", "", .)))
    data <- data %>% mutate_all(funs(gsub("’", "", .)))
    data <- data %>% mutate_all(funs(gsub('"', "", .)))
    return(data)
}

# Define a function to read and convert the data to factors
read_and_convert_data_to_factor <- function(file_path) {
    data <- read_sav(file_path)
    
    data <- haven::as_factor(data)
    
    data <- replace_null_na_empty(data)
    data <- remove_punctuations(data)
    
    return(data)
}

# Define a function to replace NA or empty values in ID1 with the value in the column "رمزالمحافظة"
replace_na_in_id1 <- function(data) {
  data$ID1 <- ifelse(is.na(data$ID1), data$`رمزالمحافظة`, data$ID1)
  return(data)
}

# Define a function to replace NA values in Localtype with the value in the column "localitytype"
replace_na_in_localtype <- function(data) {
  data$Localtype <- ifelse(is.na(data$Localtype), data$localitytype, data$Localtype)
  return(data)
}

# Define a function to replace NA or empty values in ID1 and Localtype
replace_na_in_id1_and_localtype <- function(data) {
  data <- replace_na_in_id1(data)
  data <- replace_na_in_localtype(data)
  return(data)
}

# Define a function to convert currencies to NIS
convert_currencies <- function(data) {
  JOD_ILS_in2014 <- 5.05313
  USD_ILS_in2014 <- 3.57763

  data$H3_1 <- ifelse(data$H3_2 == 2, data$H3_1*JOD_ILS_in2014,
                      ifelse(data$H3_2 == 3, data$H3_1*USD_ILS_in2014,
                             data$H3_1))

  data$H4_1 <- ifelse(data$H4_2 == 2, data$H4_1*JOD_ILS_in2014,
                      ifelse(data$H4_2 == 3, data$H4_1*USD_ILS_in2014,
                             data$H4_1))
  return(data)
}

# Define a function to create a new column "H3_H4_merged" that takes the value of H3_1 if it is not NA, otherwise it takes the value of H4_1
merge_h3_and_h4 <- function(data) {
  data$H3_H4_merged <- ifelse(is.na(data$H3_1), data$H4_1, data$H3_1)
  return(data)
}

# define a function to convert H3_H4_merged to categorical data (intervals)
convert_h3_h4_merged_to_categorical <- function(data) {
  data$H3_H4_merged <- as.numeric(data$H3_H4_merged)
  data$H3_H4_merged <- cut2(data$H3_H4_merged, g = 10)
  data <- remove_punctuations(data)

  return(data)
}

# Define a function to keep only certain columns
keep_only_certain_columns <- function(data) {
    data <- subset(data, select = -c(H3_1, H3_2, H4_1, H4_2))   #as we have merged H3 and H4, so we can remove the original columns
    data <- subset(data, select = c("ID1", "ID2", "Region", "Localtype", names(data)[-(1:32)]))
    return(data)
}

# Define a function to remove the columns that have text (not categorical nor numerical data)
remove_text_columns <- function(data) {
  text_columns <- grep("text", names(data), ignore.case = TRUE)
  data <- data[, -text_columns]
  return(data)
}

# Define a function to remove the columns that have all values as NA
drop_na_columns_and_rows <- function(data) {
  data <- data[,colSums(is.na(data))<nrow(data)]
  data <- data[rowSums(is.na(data)) != ncol(data), ]
  return(data)
}



# Load the tidyverse and haven packages
library("tidyverse")
library("haven")
library("Hmisc")


# Set the working directory
setwd("D:\\Predicting-Dwelling-Type-Using-DecisionTree")


# Use the functions to clean and prepare the data
data <- read_and_convert_data_to_factor("Dataset\\SefSec_2014_HH_weightNew.sav")
data <- replace_na_in_id1_and_localtype(data)
data <- convert_currencies(data)
data <- merge_h3_and_h4(data)
data <- convert_h3_h4_merged_to_categorical(data)
data <- keep_only_certain_columns(data)
data <- remove_text_columns(data)
data <- drop_na_columns_and_rows(data)

write_sav(data, "Dataset\\PreprocessedData.sav")