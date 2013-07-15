library(shiny)

#' Calculates Column Standard Deviations
#' 
#' This function calculates and returns standard deviations of a data frame by
#' column as a vector. 
#' Note: all columns of the data.frame must be numeric to be evaluated witho
#' 
#' @param inputDF data.frame of input values
#' 
#' @export
colSDs <- function(inputDF) {
  stopifnot(is.data.frame(inputDF))
  stopifnot(sapply(inputDF, is.numeric))
  
  return(sapply(inputDF, sd, na.rm=TRUE)) # calculates SD by column, with NA values removed >>> returns numeric vector
}

#' Transforming the inputs
#' 
#' Centers and scales the data frame by column and returns the data frame 
#' as columns equivalent to ~N(0,1)
#' Formula: point - mean / sd
#' 
#' @param inputDF data.frame of input values
#' 
#' @export
center.and.scale <- function(inputDF) {
  check.NA <- sum(rowSums(is.na(inputDF)) >= 1) # count of rows with > 1 missing value
  stopifnot(check.NA / nrow(inputDF) < 0.05) # throws an error if more than 5% of rows have a missing value
  
  cols <- sapply(inputDF, is.numeric)
  numeric.inputs <- inputDF[ ,cols]
  
  input.means <- colMeans(numeric.inputs, na.rm=TRUE)
  input.sd <- colSDs(numeric.inputs) # column standard deviations as a vector
  
  output <- scale(numeric.inputs, center=input.means, scale=input.sd)
  
  counter <- 0 # no processing, just assignment
  for (i in 1:ncol(inputDF)) {
    if (is.numeric(inputDF[ ,i])) {
      counter <- counter + 1
      inputDF[ ,i] <- output[ ,counter]
    }
  }
  
  return(inputDF) # returns centered and scaled data frame w/ same dimensions as input
}

################# Testing script for center.and.scale & colSDs
# counts <- as.data.frame(cbind(
#   text = rep("a", length = length(1:100)), one = 1:100, ten = 1001:(1000 + length(1:100))
# ))
# counts[ ,2] <- as.numeric(counts[ ,2])
# counts[ ,3] <- as.numeric(counts[ ,3])
# output <- center.and.scale(counts)
###############################

