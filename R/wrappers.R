#' Wrapper for as.data.frame
#'
#'
#' @param x a object you want to make a data frame
#' @param row.names NULL or a character vector giving the row names for the data frame. Missing values are not allowed
#' @param optional ogical. If TRUE, setting row names and converting column names (to syntactic names: see make.names) is optional. Note that all of R's base package as.data.frame() methods use optional only for column names treatment, basically with the meaning of data.frame(*, check.names = !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#' @return a data frame
#' @export
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

as_df<-as.data.frame

#' Wrapper for as.data.frame
#'
#'
#' @param x a object you want to make a data frame
#' @param row.names NULL or a character vector giving the row names for the data frame. Missing values are not allowed
#' @param optional ogical. If TRUE, setting row names and converting column names (to syntactic names: see make.names) is optional. Note that all of R's base package as.data.frame() methods use optional only for column names treatment, basically with the meaning of data.frame(*, check.names = !optional). See also the make.names argument of the matrix method.
#' @param ... additional arguments to be passed to or from methods.
#' @return a data frame
#' @export
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

asdf<-as.data.frame

#' Wrapper for is.na + table
#'
#'
#' @param x column you want to count NAs in
#' @export
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

na_table<-function(x) table(is.na(x))

#' Wrapper for dev.off() and graphics.off()
#'
#' @export
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

goff<-graphics.off
