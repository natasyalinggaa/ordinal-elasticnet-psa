# Regularized Ordinal Regression with The Elastic-Net Approach: Analyzing Public Speaking Anxiety on Social and Natural Science Students
This project applies regularized ordinal regression with the Elastic-Net approach to identify factors influencing public speaking anxiety (PSA) among Social Sciences and Natural Sciences students at Universitas Negeri Padang.

## Dataset
The dataset consists of survey data collected from Universitas Negeri Padang students during the **2019-2022** academic years. It includes 570 respondents, with 10 students from each of the 57 undergraduate programs at Universitas Negeri Padang. Of these programs, 25 belong to the Natural Science cluster and 32 to the Social Science cluster. The data includes PSA levels (Y) categorized into **low**, **medium**, and **high** along with **nine predictor factors** (X) measured using Likert scales. The nine factors influencing public speaking anxiety are:
1. **Humiliation (X1):** Fear of being humiliated or embarrassed while speaking.
2. **Preparation (X2):** Level of preparedness before delivering a speech.
3. **Physical Appearance (X3):** Concern about physical appearance affecting confidence.
4. **Rigid Rules (X4):** Anxiety due to strict speaking guidelines or rules.
5. **Personality Traits (X5):** Personal characteristics such as introversion or shyness.
6. **Audience Interest (X6):** Perception of the audience's engagement or interest.
7. **Unfamiliar Role (X7):** Nervousness from taking on an unfamiliar speaking role.
8. **Mistakes (X8):** Fear of making mistakes during the presentation.
9. **Negative Result (X9):** Worry about receiving negative feedback or outcomes.

## Methods
- **Ordinal Logistic Regression with the Partial Proportional Odds Assumption**, this method was used because the Brant test showed that some predictor variables violated the proportional odds assumption. The partial proportional odds model allows certain variables to have different effects across PSA levels, providing a more flexible and accurate analysis.
- **Elastic-Net Regularization**, was applied for feature selection and to handle potential multicollinearity. Even without multicollinearity, Elastic-Net effectively identifies significant factors by combining LASSO and Ridge penalties.

## Key Findings
Based on the regularized ordinal regression analysis with the Elastic-Net approach, the study identified the following factors as significantly influencing PSA:
1. **For Social Science Students**
- Logit 1 (Low vs Medium/High Anxiety), significant factors are humiliation, preparation, physical appearance, rigid rules, personality traits, audience interest, unfamiliar role, mistakes, and negative result.
- Logit 2 (Low/Medium vs High Anxiety), significant factors are humiliation, preparation, physical appearance, personality traits, audience interest, unfamiliar role, mistakes, and negative result.

**>> The factors causing PSA among Social Science students at the low anxiety level include all predictor variables. However, as their anxiety increase to a higher level, only eight dominant factors contribute to PSA - *all predictor variables except Rigid Rules (X4)*.**
  
2. **For Natural Science Students**
- Logit 1 (Low vs Medium/High Anxiety), significant factors are humiliation, preparation, rigid rules, personality traits, unfamiliar role, mistakes, and negative result.
- Logit 2 (Low/Medium vs High Anxiety), significant factors are humiliation, rigid rules, personality traits, unfamiliar role, mistakes, and negative result.

**>> The factors causing PSA among Natural Science students at the low anxiety level (Logit 1) include humiliation, preparation, rigid rules, personality traits, unfamiliar role, mistakes, and negative result. However, as their anxiety increases to a higher level (Logit 2), only six dominant factors contribute to PSA - *all Logit 1 factors except Preparation (X2)*.**

## Model Evaluation
The performance of the Elastic-Net ordinal regression model was evaluated using several metrics:
1. **For Social Science Students**
- Accuracy: 61.25%
The model correctly classified 61.25% of the overall data.
- Sensitivity: 74.32%
Effectively identified students with high public speaking anxiety.
- Specificity: 76.21%
Correctly identified students with low public speaking anxiety.
- Balanced Accuracy: 75.27%
Balanced performance across both anxiety levels.

**>> The model performs well in detecting both high and low anxiety levels, as reflected in the relatively high sensitivity and specificity. However, the overall accuracy suggests that further model improvements could enhance prediction performance.**

2. **For Natural Science Students**
- Accuracy: 80.95%
The model correctly classified 80.95% of the overall data.
- Sensitivity: 57.30%
Moderate performance in identifying students with high public speaking anxiety.
- Specificity: 87.06%
Strong ability to identify students with low public speaking anxiety.
- Balanced Accuracy: 72.18%
Balanced performance but could be improved for high-anxiety detection.

**>> The model shows high overall accuracy and effectively identifies students with low anxiety levels. However, the lower sensitivity indicates that the model struggles to detect students with high public speaking anxiety. Further improvements, such as threshold adjustments or data balancing, are recommended to enhance sensitivity and achieve more balanced predictions.**

## Recommendation 
The Elastic-Net regularization method is highly effective in addressing multicollinearity issues and selecting significant variables, resulting in a more interpretable model. However, applying ordinal logistic regression with Elastic-Net to identify factors contributing to PSA in Social Science and Natural Science students hasn't optimally classified the minor classes, potentially increasing the risk of misclassification of high PSA levels, particularly in the Natural Science group. This highlights the need for model improvement to better classify minor classes. Future researchers are advised to consider alternative methods, such as increasing the minor class sample size, applying data balancing techniques (e.g., oversampling or undersampling), or exploring other models that address class imbalance, ultimately improving the model's performance.

## References
- Zou, H., & Hastie, T. (2005). Regularization and Variable Selection via the Elastic-Net. *Journal of the Royal Statistical Society*, 67(2), 301-320.
- Wurm, M. J., Rathouz, P. J., & Hanlon, B. M. (2021). Regularized Ordinal Regression and the ordinalNet R Package. *Journal of Statistical Softwre*. 99(6), 1-42.
- McCroskey, J. C. (1970). Measures of Communication-Bound Anxiety. *Speech Monographs*, 37, 269-277.
- Bippus, A. M., & Daly, J. A. (1999). What Do People Think Causes Stage Fright?: Naive Attributions About the Reasons for Public Speaking Anxiety. *Communication Education*, 48(1), 63-72.
- Fitri, F., Almuhayar, M., Mukhti, T. O., & Agustina, D. (2024). Application of Logistic Regression with Elastic Net in Modeling University Students' Public Speaking Anxiety: A Case Study. *AIP Conference Proceedings** (p.3123). AIP Publishing.
