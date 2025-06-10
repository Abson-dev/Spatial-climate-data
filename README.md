# Spatial-climate-data


## Seasonal and Environmental Performance Indicators

| **Dimension**               | **Logic**                                                             | **Indicators**                                                                                                              | **Notes**                                                                                                                                       |
|----------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| **Seasonal Performance**   | Understand the overall quality of the rainy/agricultural season      | - **WFP Composite Drought Index (CDI)**<br>  - CDI sub-components:<br> &nbsp;&nbsp;&nbsp;&nbsp;- Rainfall<br> &nbsp;&nbsp;&nbsp;&nbsp;- Evapotranspiration<br> &nbsp;&nbsp;&nbsp;&nbsp;- Soil moisture | If CDI is not easily extractable, consider:<br> - 6-month rainfall anomaly (as of 31 Oct)<br> - 6-month SPI (as of 31 Oct)<br> - NDVI (as of 31 Oct) |
| **Extreme Weather Events** | Capture occurrences of weather extremes (dry spells, heavy rainfall) | - Longest number of consecutive dry days<br> - Days of heavy/intense/extreme rainfall in the past 30 days                   |                                                                                                                                                 |
| **Land Surface Temperature (LST)** | Monitor abnormal heat patterns and thermal stress                | - LST anomaly                                                                                                               | Data already available                                                                                                                           |
| **NDVI**                    | Assess vegetation condition and anomalies                             | - NDVI anomaly                                                                                                              | Data already available                                                                                                                           |


# 🌧️ Analyzing Seasonal Rainfall and Environmental Performance in Burkina Faso (2010–2024)

This project explores rainfall variability and environmental indicators in **Burkina Faso** using CHIRPS satellite rainfall data, geospatial analysis, and custom metrics such as dry spells and anomalies.

---

## 🎯 Objectives

- Assess seasonal performance of rainfall using CHIRPS data
- Compute environmental indicators such as:
  - Daily rainfall trends
  - Number of rainy days and dry spells
  - Rainfall anomalies (vs 2010–2020 baseline)
- Visualize rainfall patterns over time and space
- Perform spatial analysis using Burkina Faso shapefiles

---

## 🛠️ Methods & Tools

- **Data Source**: [CHIRPS Daily Rainfall](https://www.chc.ucsb.edu/data/chirps)
- **Time Period**: 2010–2024
- **Languages/Tools**:
  - Python (xarray, geopandas, matplotlib, rioxarray)
  - Jupyter Notebook
  - Raster and vector EDA

---

## 🧪 Key Analysis Steps

### 📥 1. Download & Preprocess CHIRPS Data

- Daily raster files were downloaded using a custom Python script.
- Data clipped to Burkina Faso boundaries using GeoPandas and RasterIO.

### 📊 2. Exploratory Analysis

- Time series plots of daily rainfall
- Count of rainy days (>1mm/day)
- Longest dry spells per year
- Raster visualizations for specific dates or monthly averages

### 🗺️ 3. Raster Visualization

- Rainfall map for July 15, 2022  
- Animated rainfall GIF for July 2022  
- Mean rainfall over the rainy season

### 🔴🔵 4. Rainfall Anomalies

- Anomaly = 2022 value – 2010–2020 daily climatology
- Animated anomaly maps over the rainy season

### 🧭 5. Shapefile Analysis

- CRS checks, geometry info, and polygon areas
- Labeled centroid plots of administrative units

---

## 📸 Sample Visualizations

### Static Map – Rainfall (July 15, 2022)

![Rainfall Map](assets/rainfall_map_july15.png)

### Animated Rainfall – July 2022

![Rainfall Animation](assets/rainfall_animation.gif)

### Animated Anomaly – 2022

![Anomaly Animation](assets/anomaly_2022.gif)

---

## 📂 Repository Structure

```plaintext
.
├── data/
│   ├── chirps_raw/
│   └── burkina_shp/
├── notebooks/
│   └── rainfall_analysis.ipynb
├── scripts/
│   └── download_chirps.py
├── assets/
│   └── rainfall_map_july15.png
│   └── rainfall_animation.gif
│   └── anomaly_2022.gif
├── README.md


