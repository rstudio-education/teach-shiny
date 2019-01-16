# Function for prettifying axis labels

library(tools)

prettify_label <- function(x){
  x %>%
    str_replace_all("_", " ") %>%
    toTitleCase() %>%
    str_replace("Imdb", "IMDB") %>%
    str_replace("Mpaa", "MPAA") 
}
