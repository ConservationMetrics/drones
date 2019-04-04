#' Script for tiling images

#' @author Abram Fleishman CMI
#' @email abram@@conservationmetrics.com
#' 2 Apr 2019

# Load packages -----------------------------------------------------------

# tidy data
library(stringr)
library(dplyr)
library(lubridate)

# image manipulation
library(magick)
library(drones)

# tile images to fit algorithm
# -resolution is dependent on the base model that you are using for transfer learning
# -faster_rcnn_resnet50_coco_2018_01_28 uses 1000x600px images
# -choose overlap for tiles (overlap should be ~1.5 x max target object size?)

# Tile photos -------------------------------------------------------------
# figure out how many crops you might want
img2<-image_read("C:/Users/ConservationMetrics/Downloads/20180825 Island_transparent_mosaic_group1_3_1.tif" )
img_info<-image_info(img2)

# horizontal option
n_crop_horz<-numbers::divisors(img_info$width)

# Vertical options
n_crop_vert<-numbers::divisors(img_info$height)

# Options common to both horz and vert
n_crop_horz[n_crop_vert%in%n_crop_horz]

# faster rcnn will downsize to max width = 1024, max height=600 so aim for this
#  ball park to use the maximum amount of info in an image

n_horz=5
n_vert=8

# try the crop
height=img_info$height/n_vert;
width=img_info$width/n_horz;

width;height

crop<-paste0(width,"x",height,"+",width*3,"+",height*2)
img2<-image_crop(img2,geometry =crop,repage = T )

#view it (need to be expanded since it will display at full res)
img2

# Run the function

tile_photos(in_folder='C:/Users/ConservationMetrics/Downloads/20180825 Island_transparent_mosaic_group1_3_1.tif',
            out_folder=paste0('C:/Users/ConservationMetrics/Desktop/eseal_temp'),
            width = width, height=height, buff=0,file_type = "tif")


