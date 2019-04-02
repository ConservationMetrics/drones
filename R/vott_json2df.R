
#' Read VoTT JSON as data.frame
#'
#' Tracks a VoTT JSON file and reads the tags and images to build a tidy data.frame
#'
#' @param json_path Path to a VoTT json file
#' @return a data.frame in long format with one row per bounding box
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate select bind_rows
#' @importFrom jsonlite read_json
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

vott_json2df<-function(json_path){
  json<-read_json(json_path,simplifyVector = T)

  dat=NULL
  for(i in 1:length(json$frames)){
    # get bounding box and tags
    temp<-json$frames[[i]] %>%
      as.data.frame
    if(nrow(temp)==0)temp<-data.frame(filename=NA,class=NA,xmin=NA,xmax=NA,ymin=NA,ymax=NA,width=NA,height=NA)
    # add image name
    temp$filename<-names(json$`frames`[i])

    # format
    # (box is attached but also a column with a datafram in in so gets messy)
    # (tags is a list of values in each cell so make it flat)
    temp2<-temp %>%
      select(-box) %>%
      mutate(class=unlist(temp$tags),
             xmin=x1/width,
             xmax=x2/width,
             ymin=y1/height,
             ymax=y2/height) %>%
      select(filename,class,xmin,xmax,ymin,ymax,width,height)

    dat<-bind_rows(dat,temp2)
  }
  return(dat)
}
