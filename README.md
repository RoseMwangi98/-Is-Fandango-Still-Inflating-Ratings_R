## Is Fandango Still Inflating Ratings?
In October 2015, a data journalist named Walt Hickey analyzed movie ratings data and found strong evidence to suggest that Fandango's rating system was biased and dishonest (Fandango is an online movie ratings aggregator). He published his analysis in this article — a great piece of data journalism that's totally worth reading.

Fandango displays a 5-star rating system on their website, where the minimum rating is 0 stars and the maximum is 5 stars.

Hickey found that there's a significant discrepancy between the number of stars displayed to users and the actual rating, which he was able to find in the HTML of the page. He was able to find that:

The actual rating was almost always rounded up to the nearest half-star. For instance, a 4.1 movie would be rounded off to 4.5 stars, not to 4 stars, as you may expect.
In the case of 8% of the ratings analyzed, the rounding up was done to the nearest whole star. For instance, a 4.5 rating would be rounded off to 5 stars.
For one movie rating, the rounding off was completely bizarre: from a rating of 4 in the HTML of the page to a displayed rating of 5 stars.

In this project, we'll analyze more recent movie ratings data to determine whether there has been any change in Fandango's rating system after Hickey's analysis.

Column	Description

movie	the name of the movie
year	the release year of the movie
metascore	the Metacritic rating of the movie (the "metascore" - critic score)
imdb	the IMDB rating of the movie (user score)
tmeter	the Rotten Tomatoes rating of the movie (the "tomatometer" - critic score)
audience	the Rotten Tomatoes rating of the movie (user score)
fandango	the Fandango rating of the movie (user score)
n_metascore	the metascore normalized to a 0-5 scale
n_imdb	the IMDB rating normalized to a 0-5 scale
n_tmeter	the tomatometer normalized to a 0-5 scale
n_audience	the Rotten Tomatoes user score normalized to a 0-5 scale
nr_metascore	the metascore normalized to a 0-5 scale and rounded to the nearest 0.5
nr_imdb	the IMDB rating normalized to a 0-5 scale and rounded to the nearest 0.5
nr_tmeter	the tomatometer normalized to a 0-5 scale and rounded to the nearest 0.5
nr_audience	the Rotten Tomatoes user score normalized to a 0-5 scale and rounded to the nearest 0.5
