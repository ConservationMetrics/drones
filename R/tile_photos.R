#' Tile an image
#'
#' Tile images in a directory
#'
#' @param in_folder Path to an image folder
#' @param out_folder Path to an  folder to be made that will have the images out
#' @param width max width in pixels of the output crops
#' @param height max height in pixels of the output crops
#' @param buff buffer to overlap crop by x pixels
#' @param file_type file extentions
#' @return not much really.  just a list of names of images in
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr mutate select bind_rows
#' @importFrom magick image_read image_info image_crop
#' @importFrom purrr pmap
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

tile_photos <- function(in_folder = "//NAS1/NAS3_2Mar15/Images/FC_BBAL_Drone_Images/",
                        out_folder = '//NAS1/NAS3_2Mar15/Images/FC_BBAL_Drone_Images_tiled',
                        width = 1000, height = 600,
                        buff = 30, file_type="jpg") {
  # list files
  file_type_regex<-paste0(".", file_type, "$")
  if(!utils::file_test("-f",in_folder)){
  files<-list.files(in_folder, full.names = T, pattern = file_type_regex, recursive = F)
  }else{
  files=in_folder
}
  #make out dir
  if(!dir.exists(out_folder)){
    dir.create(out_folder, recursive = T)
  }

  # loop images
  for(k in 1:(length(files))){

    # get image info
    img <- image_read(files[k])
    file_name<-basename(files[k]) %>% gsub(file_type_regex,"",.)
    img_info<-image_info(img)

    n_horz=ceiling(img_info$width/width)+1
    n_vert=ceiling(img_info$height/height)+1

    # calc crop h/w
    if(!is.null(n_vert)){
      height=img_info$height/n_vert;
      width=img_info$width/n_horz;
    }

    # if(!is.null(width)&!is.null(height)){
    #   width=width-(2*buff)
    #   height=height-(2*buff)
    #   n_vert=floor(img_info$height/height)
    #   n_horz=floor(img_info$width/width)
    # }

    corners<-expand.grid(corner_x=(0:(n_horz-1))*width, corner_y=(0:(n_vert-1))*height)

    crop_paths<-file.path(out_folder,paste0(file_name,"_",round(corners$corner_x),"_",round(corners$corner_y),".JPG"))

    pmap(.l = list(crop_paths,corners$corner_x,corners$corner_y),
         .f = function(x,y,z) make_one_tile(crop_path=x,corner_x=y,corner_y=z,img=img,buff=buff,width=width,height=height))
  }
}

