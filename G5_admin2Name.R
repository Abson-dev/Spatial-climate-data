
library(sf)
library(dplyr)
my_sf <- read_sf("C:/Users/AHema/OneDrive - CGIAR/Desktop/2023/NORAD/Conflict diffusion indicator/data/G5_Sahel_adm2N/G5_Sahel_adm2N/G5_Sahel_adm2N.shp")




my_sf <- my_sf %>% 
  select(ADMIN2PCOD,ADMIN2NAME)


my_sf <- my_sf %>% sf::st_drop_geometry()

write.csv(my_sf,"C:/Users/AHema/OneDrive - CGIAR/Desktop/2024/WFP/Spatial climate data/G5_Sahel_admin2Name.csv")
