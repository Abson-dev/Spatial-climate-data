library(readr)
library(dplyr)
library(stringr)
sahel_rfh_20240618_rainfall_data <- read_csv("C:/Users/AHema/OneDrive - CGIAR/Desktop/2024/WFP/Spatial climate data/sahel_rfh_20240618.csv")
sahel_rfh_20240618_rainfall_data <- sahel_rfh_20240618_rainfall_data %>% 
  select(-1)

sahel_rfh_20240618_rainfall_data$annee = lubridate::year(sahel_rfh_20240618_rainfall_data$time)
sahel_rfh_20240618_rainfall_data$mois = lubridate::month(sahel_rfh_20240618_rainfall_data$time)
sahel_rfh_20240618_rainfall_data$jour = lubridate::day(sahel_rfh_20240618_rainfall_data$time)


sahel_rfh_20240618_rainfall_data = sahel_rfh_20240618_rainfall_data %>% 
  mutate(ID = paste0(location,"_",mois,"_",jour))
###############
sahel_rfh_20240618_rainfall_data_rfh_avg = sahel_rfh_20240618_rainfall_data %>% 
  filter(annee >=1989 & annee <= 2018)
sahel_rfh_20240618_rainfall_data_rfh_avg = sahel_rfh_20240618_rainfall_data_rfh_avg %>% 
  group_by(ID) %>% 
  summarise(rfh_avg_hema = mean(rfh,na.rm = T)) %>% 
  #ungroup() %>% 
  select(ID,rfh_avg_hema)
###########
rain_fall = left_join(sahel_rfh_20240618_rainfall_data,sahel_rfh_20240618_rainfall_data_rfh_avg) %>% 
  select(ID,time, location,rfh,rfh_avg_hema,rfh_avg,rfq,valids)

sahel_rfh_avg = sahel_rfh_20240618_rainfall_data %>% 
  group_by(ID) %>% 
  summarise(rfh_avg_hema2 = mean(rfh,na.rm = T)) %>% 
  #ungroup() %>% 
  select(ID,rfh_avg_hema2)

rain_fall = left_join(rain_fall,sahel_rfh_avg) %>% 
  select(time, location,rfh,rfh_avg_hema,rfh_avg_hema2,rfh_avg,rfq,valids)



rain_fall = rain_fall %>% 
  mutate(rfq_hema = (rfh + 5)*100/(rfh_avg_hema + 5),
         rfq_hema2 = (rfh + 5)*100/(rfh_avg_hema2 + 5)) %>% 
  arrange(location,time)
writexl::write_xlsx(rain_fall,"sahel_rfh_20240618_rainfall_data.xlsx")


rain_fall_notok = rain_fall %>% 
  filter(rfh_avg == 0 & rfh_avg_hema!=0)

writexl::write_xlsx(rain_fall_notok,"rain_fall_notok.xlsx")



decad_janvier = sahel_rfh_20240618_rainfall_data %>% 
  filter(mois==1 & (jour ==11|jour ==21)) %>% 
  filter(location == "BF1300") %>% 
  select(location,rfh,rfh_avg_hema,time)
