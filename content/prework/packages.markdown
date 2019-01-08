---
title: Install R packages
author: ''
date: "2019-01-08"
slug: packages
categories: []
tags: []
linktitle: "Install R packages"
menu:
  prework:
    parent: "Local setup"
    weight: 3
toc: yes
type: docs
---



For this workshop, you'll need to install several R packages. This page will guide you through installing the packages we will use. 

To do so, please run the following in the your R console:


```r
from_cran <- c(
  "DT", 
  "glue", 
  "flexdashboard", 
  "rmarkdown",
  "rsconnect",
  "shiny", 
  "shinydashboard", 
  "shinythemes", 
  "tidyverse",
  "xaringan"
  )
```


```r
install.packages(from_cran, dependencies = TRUE)
```
