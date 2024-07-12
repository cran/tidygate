## ----setup, echo=FALSE, include=FALSE-----------------------------------------
library(knitr)
library(tidygate)
library(dplyr)
library(ggplot2)
library(stringr)
library(readr)

knitr::opts_chunk$set(cache = TRUE, warning = FALSE, message = FALSE, cache.lazy = FALSE)

## ----eval=FALSE---------------------------------------------------------------
#  # From Github
#  devtools::install_github("stemangiola/tidygate")
#  
#  # From CRAN
#  install.package("tidygate")

## -----------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(stringr)
library(readr)
library(tidygate)

mtcars |>
  head()

## ----eval=FALSE---------------------------------------------------------------
#  mtcars_gated <-
#    mtcars |>
#    mutate(gated = gate(x = mpg, y = wt, colour = disp))

## ----echo=FALSE---------------------------------------------------------------
load("../data/demo_gate_data.rda")

# Load pre-recorded brush path from data for example
tidygate_env <<- rlang::env()
tidygate_env$gates <- demo_gate_data

mtcars_gated <- 
  mtcars |>
  mutate(gated = gate(x = mpg, y = wt, programmatic_gates = tidygate_env$gates))

## -----------------------------------------------------------------------------
# Select points within any gate
mtcars_gated |> 
  filter(!is.na(gated))

# Select points within gate 2
mtcars_gated |>
  filter(str_detect(gated, "2"))

## -----------------------------------------------------------------------------
# Inspect previously drawn gates
tidygate_env$gates |>
  head()

## ----eval=FALSE---------------------------------------------------------------
#  # Save if needed
#  tidygate_env$gates |>
#    write_rds("important_gates.rds")

## ----eval=FALSE---------------------------------------------------------------
#  important_gates <-
#    read_rds("important_gates.rds")
#  
#  mtcars |>
#    mutate(gated = gate(x = mpg, y = wt, programmatic_gates = important_gates)) |>
#    filter(!is.na(gated))

## ----echo=FALSE---------------------------------------------------------------
mtcars |>
  mutate(gated = gate(x = mpg, y = wt, programmatic_gates = tidygate_env$gates)) |>
  filter(!is.na(gated))

## -----------------------------------------------------------------------------
sessionInfo()

