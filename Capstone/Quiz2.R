## This script tests our model on the sentences in Quiz 2.

source("prediction_model.R")

one <- "The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
next_one <- predict_next_word(one, words, pairs, triplets)
one_pick <- "beer"

two <- "You're the reason why I smile everyday. Can you follow me please? It would mean the"
next_two <- predict_next_word(two, words, pairs, triplets)
two_pick <- "world"

three <- "Hey sunshine, can you follow me and make me the"
next_three <- predict_next_word(three, words, pairs, triplets)
three_pick <- "happiest"

four <- "Very early observations on the Bills game: Offense still struggling but the "
next_four <- predict_next_word(four, words, pairs, triplets)
four_pick <- "defense"


five <- "Go on a romatic data at the "
next_five <- predict_next_word(five, words, pairs, triplets)
five_pick <- "beach"

six <- "Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"
next_six <- predict_next_word(six, words, pairs, triplets)
six_pick <- "way"

seven <- "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"
next_seven <- predict_next_word(seven, words, pairs, triplets)
seven_pick <- "time"

eight <- "After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"
next_eight <- predict_next_word(eight, words, pairs, triplets)
eight_pick <- "fingers"

nine <- "Be grateful for the good times and keep the faith during the"
next_nine <- predict_next_word(nine, words, pairs, triplets)
nine_pick <- "bad"

ten <- "If this isn't the cutest thing you've ever seen, then you must be"
next_ten <- predict_next_word(ten, words, pairs, triplets)
ten_pick <- "insane"