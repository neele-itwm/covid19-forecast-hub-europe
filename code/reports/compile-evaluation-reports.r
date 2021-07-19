# packages ---------------------------------------------------------------------
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(covidHubUtils)
library(lubridate)
source(here("code", "config_utils", "get_hub_config.R"))

options(knitr.duplicate.label = "allow")

report_date <- today()
wday(report_date) <- get_hub_config("forecast_week_day")

suppressWarnings(dir.create(here::here("html")))

## for (country in c("Overall", hub_locations_ecdc$location_name)) {
for (country in c("Overall", "Germany")) {
  rmarkdown::render(here::here("code", "reports", "evaluation",
                               "evaluation-report.Rmd"),
                    output_format = "html_document",
                    params = list(location_name = country,
                                  report_date = report_date,
                                  restrict_weeks = 4),
                    output_file =
                      here::here("html",
                                 paste0("evaluation-report-",
                                        country, ".html")),
                    envir = new.env())
}
