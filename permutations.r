
################################################################################

# WHAT IS THIS SCRIPT FOR?

# OH GOD WHAT IS ANYTHING FOR?

################################################################################

packages <- c("gtools", "readr", "tibble", "dplyr")

lapply(packages, library, character.only = TRUE)



x <- c("A","B","C","D","E","F")

df <- permutations(n = 6, r = 6, v = x)

write.csv(df, "permutations.csv", row.names = FALSE)

permutations <- read_csv("permutations.csv")

colnames(permutations) <- c("Stage_1","Stage_2","Stage_3","Stage_4","Stage_5","Stage_6")

permutations$Sequence <-
  paste(
    permutations$Stage_1,
    permutations$Stage_2,
    permutations$Stage_3,
    permutations$Stage_4,
    permutations$Stage_5,
    permutations$Stage_6
  )

write.csv(permutations, "permutations.csv", row.names = FALSE)

n <- 3

MCpermutations <- do.call("rbind", replicate(n, permutations, simplify = FALSE))

MCpermutations$Mock_Crime <- NA

MCpermutations$Mock_Crime <- c("MC_1")
MCpermutations$Mock_Crime[721:1440]<- c("MC_2")
MCpermutations$Mock_Crime[1441:2160]<- c("MC_3")

write.csv(MCpermutations,"MCpermutations.csv", row.names = FALSE)

