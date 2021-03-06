% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xgb.Booster.R
\name{xgb.Booster.complete}
\alias{xgb.Booster.complete}
\title{Restore missing parts of an incomplete xgb.Booster object.}
\usage{
xgb.Booster.complete(object, saveraw = TRUE)
}
\arguments{
\item{object}{object of class \code{xgb.Booster}}

\item{saveraw}{a flag indicating whether to append \code{raw} Booster memory dump data 
when it doesn't already exist.}
}
\value{
An object of \code{xgb.Booster} class.
}
\description{
It attempts to complete an \code{xgb.Booster} object by restoring either its missing 
raw model memory dump (when it has no \code{raw} data but its \code{xgb.Booster.handle} is valid)
or its missing internal handle (when its \code{xgb.Booster.handle} is not valid 
but it has a raw Booster memory dump).
}
\details{
While this method is primarily for internal use, it might be useful in some practical situations.

E.g., when an \code{xgb.Booster} model is saved as an R object and then is loaded as an R object,
its handle (pointer) to an internal xgboost model would be invalid. The majority of xgboost methods 
should still work for such a model object since those methods would be using 
\code{xgb.Booster.complete} internally. However, one might find it to be more efficient to call the  
\code{xgb.Booster.complete} function once after loading a model as an R-object. That which would
prevent further reconstruction (potentially, multiple times) of an internal booster model.
}
\examples{

data(agaricus.train, package='xgboost')
bst <- xgboost(data = agaricus.train$data, label = agaricus.train$label, max_depth = 2, 
               eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic")
saveRDS(bst, "xgb.model.rds")

bst1 <- readRDS("xgb.model.rds")
# the handle is invalid:
print(bst1$handle)
bst1 <- xgb.Booster.complete(bst1)
# now the handle points to a valid internal booster model:
print(bst1$handle)

}

