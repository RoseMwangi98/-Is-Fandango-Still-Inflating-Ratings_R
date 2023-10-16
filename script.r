# # Is Fandango Still Inflating Ratings?

## In October 2015, Walt Hickey from FiveThirtyEight published a [popular article](https://fivethirtyeight.com/features/fandango-movies-ratings/) where he presented strong evidence which suggest that Fandango's movie rating system was biased and dishonest. In this project, we'll analyze more recent movie ratings data to determine whether there has been any change in Fandango's rating system after Hickey's analysis.

# Understanding the Data

##We'll work with two samples of movie ratings: the data in one sample was collected *previous* to Hickey's analysis, while the other sample was collected *after*. Let's start by reading in the two samples (which are stored as CSV files) and getting familiar with their structure.
# Read the data

library(readr)

previous <- read_csv('fandango_score_comparison.csv')
after <- read_csv('movie_ratings_16_17.csv')

head(previous)
head(after)