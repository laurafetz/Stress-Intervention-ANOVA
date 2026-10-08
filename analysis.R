# Baseline-adjusted intervention x employment model.
# Run from repository root: Rscript analysis.R
library(emmeans)
library(ggplot2)
dir.create("results",showWarnings=FALSE)
data <- read.table("data/stress_intervention.txt",header=TRUE)
stopifnot(all(c("stress1","stress2","intervention","employmentStatus") %in% names(data)))
data$intervention <- factor(data$intervention,levels=c("no","yes"))
data$employmentStatus <- factor(data$employmentStatus)
stopifnot(!anyNA(data),nrow(data)==320)
additive <- lm(stress2~stress1+intervention+employmentStatus,data=data)
interaction <- lm(stress2~stress1+intervention*employmentStatus,data=data)
comparison <- anova(additive,interaction)
write.csv(comparison,"results/model_comparison.csv")
means <- emmeans(interaction,~intervention|employmentStatus)
# yes minus no; adjust across all three employment-specific comparisons.
contrasts <- contrast(means,method=list("yes - no"=c(-1,1)))
contrast_results <- as.data.frame(summary(contrasts,infer=c(TRUE,TRUE),by=NULL,adjust="bonferroni"))
write.csv(contrast_results,"results/intervention_contrasts.csv",row.names=FALSE)
data$stress1_z <- as.numeric(scale(data$stress1))
data$stress2_z <- as.numeric(scale(data$stress2))
standardized <- lm(stress2_z~stress1_z+intervention*employmentStatus,data=data)
zmeans <- emmeans(standardized,~intervention|employmentStatus)
write.csv(as.data.frame(summary(contrast(zmeans,method=list("yes - no"=c(-1,1))),infer=c(TRUE,TRUE),by=NULL,adjust="bonferroni")),"results/standardized_contrasts.csv",row.names=FALSE)
figure <- emmip(means,employmentStatus~intervention,CIs=TRUE)+
  labs(x="Intervention participation",y="Adjusted post-intervention stress",colour="Employment")+
  theme_minimal(base_size=12)
ggsave("results/interaction.png",figure,width=7,height=4.5,dpi=180)
capture.output(summary(additive),summary(interaction),comparison,contrast_results,
               file="results/model_output.txt")
capture.output(sessionInfo(),file="results/session_info.txt")
print(comparison);print(contrast_results)
cat("Interaction model R-squared:",summary(interaction)$r.squared,"\n")
cat("Additional explained variance:",summary(interaction)$r.squared-summary(additive)$r.squared,"\n")
