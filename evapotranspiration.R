library(readr)
library(dplyr)
library(stringr)
sahel_rfh_20240618_rainfall_data <- read_csv("C:/Users/AHema/OneDrive - CGIAR/Desktop/2024/WFP/Spatial climate data/sahel_et0_20240618.csv")
sahel_rfh_20240618_rainfall_data$annee = lubridate::year(sahel_rfh_20240618_rainfall_data$time)
sahel_rfh_20240618_rainfall_data$mois = lubridate::month(sahel_rfh_20240618_rainfall_data$time)
sahel_rfh_20240618_rainfall_data$jour = lubridate::day(sahel_rfh_20240618_rainfall_data$time)
sahel_rfh_20240618_rainfall_data = sahel_rfh_20240618_rainfall_data %>% 
  mutate(ID = paste0(location,mois,jour))

sahel_rfh_20240618_rainfall_data_rfh_avg = sahel_rfh_20240618_rainfall_data %>% 
  filter(annee >=1989 & annee <= 2018)
sahel_rfh_20240618_rainfall_data_rfh_avg = sahel_rfh_20240618_rainfall_data_rfh_avg %>% 
  group_by(ID) %>% 
  mutate(rfh_avg2 = mean(rfh,na.rm = T)) %>% 
  ungroup() %>% 
  select(ID,rfh_avg2) %>% 
  distinct()

rain_fall = left_join(sahel_rfh_20240618_rainfall_data,sahel_rfh_20240618_rainfall_data_rfh_avg) %>% 
  select(time, location,rfh,rfh_avg2,rfh_avg,valids)

writexl::write_xlsx(rain_fall,"sahel_rfh_20240618_rainfall_data.xlsx")
