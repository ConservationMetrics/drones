#' Tile an image
#'
#' Tile images in a directory
#'
#' @param img Path to an image folder
#' @param crop_path Path to an  folder to be made that will have the images out
#' @param width  width in pixels of the crop
#' @param height height in pixels of the crop
#' @param buff buffer to overlap crop by x pixels
#' @param corner_x x coord of the top left corner of the crop
#' @param corner_y y coord of the top left corner of the crop
#' @return not much really.  just a list of names of images in
#' @export
#' @importFrom magick image_crop image_write
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

make_one_tile<-function(img,crop_path,width,buff,height,corner_x,corner_y){
  #crop string (WxH+offset_x+offset_y)
  crop<-paste0(width+(buff),"x",height+(buff),"+",corner_x,"+",corner_y)

  img2<-image_crop(img,geometry =crop,repage = T )

  image_write(img2,path = crop_path)
}
