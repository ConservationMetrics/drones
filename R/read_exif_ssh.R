#' Read file exif data over ssh
#'
#' Reads file exif data from a folder on the nas and saves it as a csv in dropbox.
#'
#' @param ssh_host server to ssh into default is 'user at 10.74.76.105:22'
#' @param passwrd password to server
#' @param nas_image_path path of nas image folder with data to scan
#' @param dbox_project_path dropbox project folder to save csv out
#' @param tags any additional parameters to add to exiftool call (can be specific tags to get back)
#' @return a data.frame/tibble with all the exif data for the folder you scaned
#' @export
#' @importFrom ssh ssh_connect ssh_exec_internal ssh_disconnect
#' @author Abram Fleishman \email{abram@@conservationmetics.com}

read_exif_ssh<-function(ssh_host= "user@10.74.76.105:22",passwrd , nas_image_path ="//NAS1/NAS3_2Mar15/Images/CMI_Office_2015", dbox_project_path = "D:/CM,Inc/Dropbox (CMI)/CMI_Team/Analysis/2019/CMI_Office_2015",tags=""){

  if ( nchar(tags)>0){
    specific_tags<-paste(tags,collapse = " -") %>% paste0("-",.)
  }else{
    specific_tags<-tags}

  # make server connection
  server<-ssh_connect(host = ssh_host, passwd = passwrd)

  #build scan command from parameters (use ssh if local = F, list files if T)
  ScanCmd<- paste0("exiftool -r -T -csv ",specific_tags,
                   convert_paths(nas_image_path,'nas'),' > ',
                   convert_paths(nas_image_path,'nas'),"/",basename(nas_image_path),"_exif.csv")

  # submit scan command and format result
  Scan1_raw<-ssh_exec_internal(server, ScanCmd)
  ssh_disconnect(server)

  exif_path<-paste0(dbox_project_path,"/exif_data/",basename(nas_image_path),"_exif.csv")
  if(!dir.exists(dirname(exif_path))) dir.create(dirname(exif_path),recursive=T)
  file.rename(paste0(nas_image_path,"/",basename(nas_image_path),"_exif.csv"),exif_path)

  exif<-read.csv(exif_path,stringsAsFactors = F)
  return(exif)
}
