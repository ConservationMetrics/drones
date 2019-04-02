
#' create list of polygons from a data.frame row
#'
#' Take a row from a data.frame and using xmin.xmax,ymin,ymax coordinents make
#' a list of polygons
#'
#' @param dat data.frame with column names specified in x* and y* below
#' @param xmin quoted column name
#' @param xmax quoted column name
#' @param ymin quoted column name
#' @param ymax quoted column name
#' @return a list with each entry a sf Polygon object
#' @export
#' @importFrom sf st_polygon
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

# create list of SF Polygons (1 polygon per row == bounding box)
polygon_list_from_rows<-function(dat,
                                 xmin='image_xmin', xmax='image_xmax',
                                 ymin='image_ymin', ymax='image_ymax'){
  lst <- lapply(1:nrow(dat), function(x){
    ## create a matrix of coordinates that also 'close' the polygon
    res <- matrix(c(dat[x, xmax], dat[x, ymin],
                    dat[x, xmax], dat[x, ymax],
                    dat[x, xmin], dat[x, ymax],
                    dat[x, xmin], dat[x, ymin],
                    dat[x, xmax], dat[x, ymin])  ## need to close the polygon so first point==last point
                  , ncol =2, byrow = T)
    ## create polygon objects
    st_polygon(list(res))

  })
  return(lst)
}
