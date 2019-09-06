#!/usr/bin/env bash


###
### SOURCE: https://gitlab.com/Raw_Me/findmovie/blob/master/findmovie
###


#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# This script is used to fetch movies' details from the terminal using IMDB


# First taking the movie as an argument
## check number of arguments
if [[ $# -ne 1 ]]; then
  echo "Too many argumnets: Please only pass one movie or use \"NAME OF MOVIE\" for spaces." >&2
  exit 1
fi
## Get the IMDB id
movie_s=$(echo $1 | sed 's/ //g')
movie_id=$(curl -s https://www.imdb.com/find?q="$movie_s"\&s=tt | grep -o '/title/tt[0-9]*/?ref_=fn_tt_tt_1' | head -1)
## Check if found
if [[ -z $movie_id ]]; then
    echo -e "Sorry: couldn't find the movie.\nIn case of a typo check:\n"
    echo "$1" | aspell -a
    exit 1
fi


# Parsing
## Init file
curl -s https://www.imdb.com/"$movie_id" > findMovie.tmp
## Check if file exists
if ! [[ -s findMovie.tmp ]]; then
    echo "Error: couldn't get the movie's page." >&2
    exit 1
fi
## Get title
movie_title=$(grep '<title>' findMovie.tmp | sed 's/<\/*title>//g' | sed 's/ - IMDb//' | sed 's/  //g' | rev | cut -d' ' -f2- | rev)
## Get year
movie_year=$(grep '<title>' findMovie.tmp | sed 's/<\/*title>//g' | sed 's/ - IMDb//' | sed 's/  //g' | rev | cut -d' ' -f1 | rev)
## Get Rating
movie_rating=$(grep -o 'title="[0-9]*.[0-9]* based' findMovie.tmp | sed 's/title="//g' | cut -d' ' -f1)
## Get RatingCount
movie_rating_count=$(grep -o 'based on [0-9]*,*[0-9]*,*[0-9]* user' findMovie.tmp | cut -d' ' -f3)
## Get Length
movie_length=$(grep -o '[0-9]** min</time' findMovie.tmp | cut -d'<' -f1)
## Get Genre
movie_genre=$(grep 'itemprop" itemprop="genre"' findMovie.tmp | grep -o '[A-Za-z\-]*</s' | cut -d'<' -f1 | tr '\n' ',' | sed 's/,$/\n/')
## Get Summary
movie_sum=$(grep -A1 'summary_text' findMovie.tmp | tail -n 1 | sed -e 's/^[ \t]*//')
## Get release Date
movie_date=$(grep 'See more rel' findMovie.tmp | cut -d'>' -f2)
## Get ContentRating
movie_content=$(grep 'contentRating">' findMovie.tmp | cut -d'>' -f2 | cut -d'<' -f1)
## Get Director
movie_director=$(grep -o 'Directed by [A-Za-z \-]*\.' findMovie.tmp | tail -n 1 | sed 's/Directed by //')
## Get Actors
movie_actors=$(grep -o 'Directed by [A-Za-z \-]*\.  With [A-Za-z \.]*, [A-Za-z \.]*, [A-Za-z \.]*' findMovie.tmp | tail -n 1 | sed 's/Directed by [A-Za-z \-]*\.  With //')
## Remove Page
rm findMovie.tmp


# Printing
## Colors
red='\033[0;31m'
nc='\033[0m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
## Details
titlestr="${blue}Title:${nc} $movie_title"
titlestr="${titlestr/
TryIMDbProFree/}"
###################echo -e "$titlestr"
#echo -e "${red}Title:${green} $movie_title"
yearstr="${blue}Year:${nc} $movie_year"
yearstr="${yearstr/
TryIMDbProFree/}"
###############echo -e "$yearstr"


titleshort="$movie_title"
titleshort="|    ${titleshort/
TryIMDbProFree/}"
yearshort="$movie_year"
yearshort="${yearshort/
TryIMDbProFree/}"
yearshort="${yearshort:1:4}"
titleyearstr="
${titleshort} [${yearshort}]    |
"
#echo -e "${titleyearstr}"
#echo -e "
#------------------------${titleyearstr}------------------------
#"
strlen=${#titleyearstr}
strlenpad=$((strlen-2))
#echo "${strlenpad}"
#echo "${strlen}"
#printf '\-%.0s' {1..$strlen}
echo -e " "
padstr=""
i=0
while [ $i -lt $strlenpad ]; do
    padstr="${padstr}-"
    let i=i+1
done
echo -e "${padstr}${titleyearstr}${padstr}"
echo -e " "

## Check if rating exists
#if [[ -z $movie_rating ]]; then
#    echo -e "${red}IMDB Rating:${yellow} No Rating."
#    echo -e "${red}Number of Voters:${yellow} Needs more votes"
#else
#    echo -e "${red}IMDB Rating:${yellow} ${movie_rating} / 10"
#    echo -e "${red}Number of Voters:${yellow} $movie_rating_count"
#fi
if [[ -z $movie_rating ]]; then
    echo -e "${blue}  Rating:${nc}      No Rating.
"
else
    echo -e "${blue}  Rating:${nc}      ${movie_rating} / 10  [ $movie_rating_count reviews ]
"
fi
#echo -e "${red}Genre:${purple} ${movie_genre}."
#echo -e "${blue}  Summary:${nc}   $movie_sum
#"
summarystr="$movie_sum"
summarystr=$(echo "${summarystr}"|sed -r 's/ / \n               /16')
summarystr=$(echo "${summarystr}"|sed -r 's/ / \n               /32')
summarystr=$(echo "${summarystr}"|sed -r 's/ / \n               /48')
summarystr=$(echo "${summarystr}"|sed -r 's/ / \n               /64')
echo -e "${blue}  Summary:${nc}     $summarystr
"
#echo -e "${red}Release Date:${green} $movie_date"
## Check if content rating exists
#if [[ -z $movie_content ]]; then
#    echo -e "${red}Content Rating:${purple} Unrated."
#else
#    echo -e "${red}Content Rating:${purple} ${movie_content}."
#fi
if [[ ! -z ${movie_director} ]]; then
    echo -e "${blue}  Director:${nc}    $movie_director
"
fi
if [[ ! -z ${movie_actors} ]]; then
    echo -e "${blue}  Actors:${nc}      ${movie_actors}.
"
fi

# Catch multi-line movie lengths
lengthstr="$movie_length"
lengthstr="${lengthstr/
/ - }"
#echo -e "${red}  Length:${nc} $movie_length
echo -e "${blue}  Length:${nc}      $lengthstr
"
