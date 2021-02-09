
################################################################################

# WHAT IS THIS SCRIPT FOR?

# OH GOD WHAT IS ANYTHING FOR?

################################################################################

## Packages

packages <- c("gtools", "readr", "tibble", "dplyr")

lapply(packages, library, character.only = TRUE)

## Seed

set.seed(666)

## Study set up

nr_mcs    <- 3    #Number of mock crimes
nr_stages <- 6    #Number of stages per mock crime
sample    <- 300  #Sample size
group     <- sample / nr_mcs

style     <- c("direct", "standard", "reinforcement") #interview style
stages    <- c("A","B","C","D","E","F")               #stages

## Generate permutations for stages

permutations <- permutations(n = nr_stages, r = nr_stages, v = stages)

colnames(permutations) <- c("stage_1","stage_2","stage_3","stage_4","stage_5","stage_6")

permutations <- data.frame(permutations)

## Adding column for sequence of stages

permutations$sequence <-
  paste(
    permutations$stage_1,
    permutations$stage_2,
    permutations$stage_3,
    permutations$stage_4,
    permutations$stage_5,
    permutations$stage_6
  )

## Calculating number of possible permutations

poss_permutations <- length(permutations$sequence)

## Multipling possible permutations with number of mock crimes

mc_x_poss_permutations <- poss_permutations*nr_mcs

## Creating data frame with all possible permutations * number of mock crimes

MCpermutations <- do.call("rbind", replicate(nr_mcs, permutations, simplify = FALSE))

## Assigning mock crime to permitations

MCpermutations$mock_crime <- NA

MCpermutations$mock_crime <- c("MC_2")
MCpermutations$mock_crime[1:poss_permutations]<- c("MC_1")
MCpermutations$mock_crime[(mc_x_poss_permutations - (poss_permutations - 1)):mc_x_poss_permutations]<- c("MC_3")

## Save data for permutations with assigned mock crimes

write.csv(MCpermutations,"MCpermutations.csv", row.names = FALSE)

## Random selection of permutations to be used in the experiment

selection_permutation <- MCpermutations %>% slice_sample(n = sample)
MC_count <- count(selection_permutation, mock_crime)

## Assign style of interview for selection. Assignment is pseudo-random resulting in even groups for each interview style.

selection_permutation$style[sample(1:nrow(selection_permutation), nrow(selection_permutation), FALSE)] <- rep(style,group)

style_count <- count(selection_permutation, style)

