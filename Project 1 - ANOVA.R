### Laura M. Fetz
### Last updated 21. Sep 2026
### Project 1 - ANOVA

### IMPORT MY DATA ###
my_data <-read.table(data)

### LOAD PACKAGES ###
library(psych)
library(emmeans)
library(ggplot2)

### DESCRIPTIVE STATISTICS ###
describe(my_data)
describeBy(my_data,list(my_data$intervention, my_data$employmentStatus))

### Z-SCORES FOR CONTINOUS VARIABLES ### 
my_data$stress1.z <- scale(my_data$stress1)
my_data$stress2.z <- scale(my_data$stress2)

### FITTING MODELS ###
MOD.1 <- lm(stress2 ~ stress1 + intervention * employmentStatus, data = my_data)
MOD.2 <- lm(stress2 ~ stress1 + intervention + employmentStatus, data = my_data)

### INTERPRETING MODEL 1 ###
summary(MOD.1)

### INTERPRETING MODEL 2 ###
summary(MOD.2)
(aov.MOD.12 <-anova(MOD.1, MOD.2))
summary(MOD.2)$r.squared - summary(MOD.1)$r.squared # DELTA R2

### PROBING THE INTERACTION ###
library(emmeans)
em.int.by.emp <- emmeans(MOD.1, specs = ~ intervention | employmentStatus,
                         at = list(intervention = c("yes", "no")))
summary(em.int.by.emp)
rbind(pairs(em.int.by.emp))
confint(rbind(pairs(em.int.by.emp)))

### STANDARDIZED EFFECTS ###
MOD.1.z <- lm(stress2.z ~ stress1.z + intervention * employmentStatus, data = my_data)
em.z.int.by.emp <- emmeans(MOD.3.z, specs = ~ intervention | employmentStatus,
                         at = list(intervention = c("yes", "no")))
rbind(pairs(em.z.int.by.emp))
confint(rbind(pairs(em.z.int.by.emp)))

### PLOTTING THE INTERACTION ###
em <- emmeans(MOD.1,
              specs = ~ intervention | employmentStatus)
emmip(em, employmentStatus ~ intervention, CIs = TRUE)

