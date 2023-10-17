#  Is Fandango Still Inflating Ratings?

## In October 2015, Walt Hickey from FiveThirtyEight published a [popular article](https://fivethirtyeight.com/features/fandango-movies-ratings/) where he presented strong evidence which suggest that Fandango's movie rating system was biased and dishonest. In this project, we'll analyze more recent movie ratings data to determine whether there has been any change in Fandango's rating system after Hickey's analysis.

### Understanding the Data

# We'll work with two samples of movie ratings: the data in one sample was collected *previous* to Hickey's analysis, while the other sample was collected *after*. Let's start by reading in the two samples (which are stored as CSV files) and getting familiar with their structure.

## Read the data

library(readr)
library(dplyr)
library(stringr)
library(ggplot2)
previous <- read_csv('fandango_score_comparison.csv')
after <- read_csv('movie_ratings_16_17.csv')

head(previous)
head(after)
# Select the necessary columns needed
previous_update <-  previous %>% 
  select(
    'FILM', 'Fandango_Stars', 'Fandango_Ratingvalue', 'Fandango_votes', 'Fandango_Difference')
after_update <- after %>% 
  select (
    'movie', 'year', 'fandango')

# Our goal is to determine whether there has been any change in Fandango's rating system after Hickey's analysis. The population of interest for our analysis is made of all the movie ratings stored on Fandango's website, regardless of the releasing year.

# Because we want to find out whether the parameters of this population changed after Hickey's analysis, we're interested in sampling the population at two different periods in time — previous and after Hickey's analysis — so we can compare the two states.

# The data we're working with was sampled at the moments we want: one sample was taken previous to the analysis, and the other after the analysis. We want to describe the population, so we need to make sure that the samples are representative, otherwise we should expect a large sampling error and, ultimately, wrong conclusions.



# The movie must have been released in 2016 or later.
# The movie must have had a considerable number of votes and reviews (unclear how many from the README.md or from the data).

# This second sample is also subject to temporal trends and it's unlikely to be representative of our population of interes#
# Both these authors had certain research questions in mind when they sampled the data, and they used a set of criteria to get a sample that would fit their questions. Their sampling method is called [purposive sampling](https://www.youtube.com/watch?v=CdK7N_kTzHI&feature=youtu.be) (or judgmental/selective/subjective sampling). While these samples were good enough for their research, they don't seem too useful for us.

# Changing the Goal of our Analysis
# At this point, we can either collect new data or change our the goal of our analysis. We choose the latter and place some limitations on our initial goal.

#Instead of trying to determine whether there has been any change in Fandango's rating system after Hickey's analysis, our new goal is to determine whether there's any difference between Fandango's ratings for popular movies in 2015 and Fandango's ratings for popular movies in 2016. This new goal should also be a fairly good proxy for our initial goal.
                                                                                                                                           
                                                                                                                                            # * Isolating the Samples We Need
                                                                                                                                             # * With this new research goal, we have two populations of interest:
                                                                                                                                             
                                                                                                                                           # * All Fandango's ratings for popular movies released in 2015.
 # 1. All Fandango's ratings for popular movies released in 2016.
                                                                                                                                           
# We need to be clear about what counts as popular movies. We'll use Hickey's benchmark of 30 fan ratings and count a movie as popular only if it has 30 fan ratings or more on Fandango's website.

#Although one of the sampling criteria in our second sample is movie popularity, the `fandango_after` dataframe doesn't provide information about the number of fan ratings. We should be skeptical once more and ask whether this sample is truly representative and contains popular movies (movies with over 30 fan ratings).
# One quick way to check the representativity of this sample might be to sample randomly 10 movies from it and then check the number of fan ratings ourselves on Fandango's website. 
#For our purposes, we'll need to isolate only the movies released in 2015 and 2016.
 
                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                           

#isolate data from 2015 and 2016

previous_update <- previous_update %>% 
  mutate(year = str_sub(FILM, -5, -2))  

#Frequency distribution of fandango distribution
previous_update %>% 
  group_by(year) %>% 
  summarize(Freq=n())
#select only 2015 data
fandango_previous <- previous_update %>% 
  filter(year==2015
         ) 
table(fandango_previous$year)
# isolate the other dataset
fandango_after <-  after_update %>% 
  filter(year == 2016)
table(fandango_after$year)

# Comparing Distribution Shapes for 2015 and 2016
# Our aim is to figure out whether there's any difference between Fandango's ratings for popular movies in 2015 and Fandango's ratings for popular movies in 2016. One way to go about is to analyze and compare the distributions of movie ratings for the two samples.

# We'll start with comparing the shape of the two distributions using kernel density plots.

# 2015 dataframe is specified in the ggplot call

ggplot(data = fandango_previous, 
       aes(x = Fandango_Stars)) +
  geom_density() +
  # 2016 dataframe is specified in the second geom_density() call
  geom_density(data = fandango_after, 
               aes(x = fandango), color = "blue") +
  labs(title = "Comparing distribution shapes for Fandango's ratings\n(2015 vs 2016)",
       x = "Stars",
       y = "Density") +
  scale_x_continuous(breaks = seq(0, 5, by = 0.5), 
                     limits = c(0, 5))


#Two aspects are striking on the figure above:
  
 # * Both distributions are strongly left skewed.
 #* The 2016 distribution is slightly shifted to the left relative to the 2015 distribution.

#The left skew suggests that movies on Fandango are given mostly high and very high fan ratings. Coupled with the fact that Fandango sells tickets, the high ratings are a bit dubious. It'd be really interesting to investigate this further — ideally in a separate project, since this is quite irrelevant for the current goal of our analysis.

# The slight left shift of the 2016 distribution is very interesting for our analysis. It shows that ratings were slightly lower in 2016 compared to 2015. This suggests that there was a difference indeed between Fandango's ratings for popular movies in 2015 and Fandango's ratings for popular movies in 2016. We can also see the direction of the difference: the ratings in 2016 were slightly lower compared to 2015.

fandango_previous %>% 
  group_by(Fandango_Stars) %>% 
  summarize(Percentage = n() / nrow(fandango_previous) * 100)


fandango_after%>% 
  group_by(fandango) %>% 
  summarize(Percentage = n() / nrow(fandango_after) * 100)
  
  
#  2016, very high ratings (4.5 and 5 stars) had lower percentages compared to 2015. In 2016, under 1% of the movies had a perfect rating of 5 stars, compared to 2015 when the percentage was close to 7%. Ratings of 4.5 were also more popular in 2015 — there were approximately 13% more movies rated with a 4.5 in 2015 compared to 2016.

# The minimum rating is also lower in 2016 — 2.5 instead of 3 stars, the minimum of 2015. There clearly is a difference between the two frequency distributions.

# For some other ratings, the percentage went up in 2016. There was a greater percentage of movies in 2016 that received 3.5 and 4 stars, compared to 2015. 3.5 and 4.0 are high ratings and this challenges the direction of the change we saw on the kernel density plots.

## Determining the Direction of the Change

# Let's take a couple of summary metrics to get a more precise picture about the direction of the change. In what follows, we'll compute the mean, the median, and the mode for both distributions and then use a bar graph to plot the values.




# Mode function from
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

summary_2015 <- fandango_previous %>% 
  summarize(year = "2015",
    mean = mean(Fandango_Stars),
    median = median(Fandango_Stars),
    mode = mode(Fandango_Stars))

summary_2016 <- fandango_after %>% 
  summarize(year = "2016",
            mean = mean(fandango),
            median = median(fandango),
            mode = mode(fandango))

# Combine 2015 & 2016 summary dataframes
summary_df <- bind_rows(summary_2015, summary_2016)

# Gather combined dataframe into a format ready for ggplot
summary_df <- summary_df %>% 
  gather(key = "statistic", value = "value", - year)




ggplot(data = summary_df, aes(x = statistic, y = value, fill = year)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparing summary statistics: 2015 vs 2016",
       x = "",
       y = "Stars")

#The mean rating was lower in 2016 with approximately 0.2. This means a drop of almost 5% relative to the mean rating in 2015.


means <- summary_df %>% 
  filter(statistic == "mean")

means %>% 
  summarize(change = (value[1] - value[2]) / value[1])




#While the median is the same for both distributions, the mode is lower in 2016 by 0.5. Coupled with what we saw for the mean, the direction of the change we saw on the kernel density plot is confirmed: on average, popular movies released in 2016 were rated slightly lower than popular movies released in 2015.

# Conclusion
#Our analysis showed that there's indeed a slight difference between Fandango's ratings for popular movies in 2015 and Fandango's ratings for popular movies in 2016. We also determined that, on average, popular movies released in 2016 were rated lower on Fandango than popular movies released in 2015.

#We cannot be completely sure what caused the change, but the chances are very high that it was caused by Fandango fixing the biased rating system after Hickey's analysis.
