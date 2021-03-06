library(jsonlite)
library(tibble)
library(stringr)
library(tidyr)

library("dplyr") 
library("magrittr")

# yelp <- fromJSON("yelp_academic_dataset_business.json")

yelp <- stream_in(file("yelp_academic_dataset_business.json"))   # need file to create connection for disk access

# str(yelp)

# separate values to smallest whole (removes on hierarchy level)
yelp_tibble <- as_data_frame(flatten(yelp) )  # as_df: don't have to call 'head' function separately
# str(yelp_tibble)


# strip individual attributes for 'categories'
# mutate creates new variable from dataset, vector of individual elements
yelp_tibble %>% mutate(categories = as.character(categories)) %>% select(categories) %>% unnest(yelp_tibble)

# delete unnecessary column
# use regex to find how many json objects are restaurants
restaurants_only <- yelp_tibble %>% select(-starts_with("hours"), -starts_with("attribute"), -starts_with("is_open"), -starts_with("review_count") ) %>% 
    filter(str_detect(categories, "(Restaurants)")) 

# table(restaurants_only$state)

restaurants_only %>% select(state) %>% count(unique(state))

# toronto_restaurants <- restaurants_only[ restaurants_only$state=="NY", ]
toronto_restaurants <- restaurants_only[ restaurants_only$city=="Toronto", ]
toronto_restaurants <- head(toronto_restaurants, 200)
toronto_restaurants$image_url <- ""

for (i in 1:nrow(toronto_restaurants)) {   # bad practice but apply functions have not worked
  toronto_restaurants[[i, 11]] <- getImageURL(toronto_restaurants[[i, 1]])
}
# Remove rows with no photo
toronto_restaurants <- toronto_restaurants[!toronto_restaurants$image_url=="",]

business_df <- data.frame(functionA(toronto_restaurants$business_id))
# print(object.size(arizona_restaurants), units="auto", standard = "SI")
# write_json(toronto_restaurants, "toronto_restaurants.json")

# df of restaurants only
restaurant_id <- toronto_restaurants %>% select(business_id)

# list of categories
categories <- toronto_restaurants %>% mutate(categories = as.character(categories)) %>% select(categories) %>%
  mutate(categories1 = stringr::str_split(categories, ",")) %>% unnest(categories1) %>% select(categories1)



# unique list of categories, can use this for regex keywords during search
categories <- categories[!duplicated(categories$categories1),]


# Estimate memory size, note that MongoDB cluster is limited
print(object.size(toronto_restaurants), units="auto", standard = "SI")






