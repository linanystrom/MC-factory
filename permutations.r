Packages <- c("gtools", "readr", "tibble", "dplyr")

lapply(Packages, library, character.only = TRUE)

x <- c("A","B","C","D","E","F")
df <- permutations(n=6, r=6,v=x)
write.csv(df,"C:\\Users\\xnystl\\Documents\\R projects\\MC-factory\\permutations.csv", row.names = FALSE)
permutations <- read_csv("permutations.csv")

colnames(permutations) <-c("Stage_1","Stage_2","Stage_3","Stage_4","Stage_5","Stage_6")
permutations$Sequence <- paste(permutations$Stage_1, permutations$Stage_2, permutations$Stage_3,permutations$Stage_4, permutations$Stage_5, permutations$Stage_6)
write.csv(permutations,"C:\\Users\\xnystl\\Documents\\R projects\\MC-factory\\permutations.csv", row.names = FALSE)

n = 3
do.call("rbind", replicate(n, permutations, simplify = FALSE))
MCpermutations <- do.call("rbind", replicate(n, permutations, simplify = FALSE))
MCpermutations['Mock_Crime'] <-NA
MCpermutations$Mock_Crime <- c("MC_1")
MCpermutations$Mock_Crime[721:1440]<- c("MC_2")
MCpermutations$Mock_Crime[1441:2160]<- c("MC_3")
write.csv(MCpermutations,"C:\\Users\\xnystl\\Documents\\R projects\\MC-factory\\MCpermutations.csv", row.names = FALSE)

