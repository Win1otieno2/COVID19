# 📊 COVID-19 Daily Deaths Visualization

This R script visualizes daily COVID-19 death counts per country using data from the **World Health Organization (WHO)**. It reads a CSV dataset, computes mean values, and plots time-series line charts for each country with average lines highlighted.

---

## 🧩 Features

- Reads COVID-19 death data from a CSV file  
- Converts date strings to proper `Date` objects  
- Calculates the mean number of deaths per country  
- Produces a **faceted line plot** showing trends per country  
- Adds dashed horizontal lines representing country averages  
- Customizes axis labels, gridlines, and title styles  

---

## 📦 Requirements

Make sure the following R packages are installed:

```r
install.packages(c("dplyr", "magrittr", "plyr", "ggplot2"))
```

---

## 📂 Input Data

The script expects a file named **`datafile.csv`** in the working directory.  

### Required Columns:
| Column   | Type   | Description |
|-----------|--------|-------------|
| `Day`     | Date or string (convertible to Date) | The date of record |
| `Country` | String | Country name |
| `Value`   | Numeric | Number of daily deaths |

Example of `datafile.csv`:
```csv
Day,Country,Value
2020-05-01,USA,1500
2020-05-01,Italy,350
2020-05-02,USA,1300
2020-05-02,Italy,300
```

---

## 🧮 Code Overview

### Load Libraries
```r
library(dplyr)
library(magrittr)
library(plyr)
library(ggplot2)
```

### Read Data
```r
data <- read.csv("datafile.csv")
data$Day <- as.Date(data$Day)
```

### Compute Country Means
```r
mu <- ddply(data, "Country", summarise, grp.mean = mean(Value))
```

### Plot Data
```r
ggplot(data, aes(x = Day, y = Value)) +
  geom_line(aes(color = Country, group = 1)) +
  facet_grid(Country ~ .) +
  geom_point() +
  labs(
    title = "Covid-19 Daily Deaths 05-May-20",
    y = "Deaths",
    x = "Day - (by Winstan, Data Source: World Health Organization - https://covid19.who.int/)"
  ) +
  scale_x_date(date_breaks = "2 day", date_labels = "%b %d") +
  geom_hline(data = mu, aes(yintercept = grp.mean, color = Country), linetype = "dashed") +
  theme(
    legend.position = "none",
    axis.title.x = element_text(size = 8),
    plot.title = element_text(size = 11, colour = "red"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
```

---

## 📈 Output

The script outputs a **faceted line chart** displaying:

- X-axis: Days  
- Y-axis: Number of daily deaths  
- Each facet: One country  
- Dashed line: Average daily deaths for that country  

---

## 🧠 Notes

- Ensure the `datafile.csv` uses consistent date formatting (e.g., `YYYY-MM-DD`).
- The code suppresses the legend for clarity, but it can be re-enabled by removing `legend.position = "none"`.
- Adjust `date_breaks` or `date_labels` in `scale_x_date()` to fit your data range.

---

## 📜 Author & Attribution

**Author:** Winstan  
**Data Source:** [World Health Organization (WHO) COVID-19 Dashboard](https://covid19.who.int/)

