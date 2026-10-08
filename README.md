# ANOVA
# Stress Intervention Analysis in R

This project examines whether participation in an intervention is associated with changes in stress levels and whether the effectiveness of the intervention differs depending on participants' employment status.

The analysis was conducted in **R** using linear models, model comparison, estimated marginal means, standardized effect estimates, and interaction plots.

## Research Question

Does an intervention predict post-intervention stress levels after accounting for baseline stress, and does this relationship vary across employment groups?

## Data

The dataset contains four variables:

| Variable           | Description                                                      |
| ------------------ | ---------------------------------------------------------------- |
| `employmentStatus` | Employment status: full-time, part-time, or unemployed           |
| `intervention`     | Whether the participant received the intervention (`yes` / `no`) |
| `stress1`          | Baseline stress score                                            |
| `stress2`          | Post-intervention stress score                                   |

## Analysis

The analysis consists of several steps:

1. **Descriptive statistics**
   Summary statistics are calculated for the complete sample and separately by intervention and employment status.

2. **Standardisation**
   Baseline and post-intervention stress scores are converted to z-scores to facilitate interpretation of standardized effects.

3. **Model estimation**
   Two linear models are fitted:

   * **Interaction model:** baseline stress + intervention × employment status
   * **Additive model:** baseline stress + intervention + employment status

4. **Model comparison**
   The models are compared using an ANOVA to assess whether including the interaction between intervention and employment status improves model fit.

5. **Interaction analysis**
   Estimated marginal means and pairwise contrasts are calculated to examine the intervention effect separately within each employment group.

6. **Effect estimation**
   Standardized models and confidence intervals are used to quantify the magnitude and uncertainty of the estimated effects.

7. **Visualisation**
   The intervention × employment status interaction is visualised using estimated marginal means and confidence intervals.

## Methods & R Packages

The project demonstrates the use of:

* Linear regression
* Factorial ANOVA / model comparison
* Interaction effects
* Covariate adjustment
* Estimated marginal means
* Pairwise contrasts
* Standardized effect estimates
* Confidence intervals
* Statistical visualisation

### Packages

```r
library(psych)
library(emmeans)
library(ggplot2)
```

## Repository Structure

```text
Project-1---ANOVA/
│
├── Project 1 - ANOVA.R       # R analysis script
├── Poject 1 - Data.txt       # Dataset
├── Project 1 - ANOVA.docx    # Written analysis/report
└── README.md                  # Project documentation
```

## Running the Analysis

Clone the repository and open the project in R or RStudio.

The data can be loaded using:

```r
my_data <- read.table(
  "Poject 1 - Data.txt",
  header = TRUE
)
```

Then run the analysis contained in:

```text
Project 1 - ANOVA.R
```

## Skills Demonstrated

This project demonstrates practical experience with statistical modelling in R, including data exploration, regression-based ANOVA, interaction testing, model comparison, effect interpretation, and statistical visualisation.

## Author

**Laura M. Fetz**
