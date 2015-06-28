#data preparation
library(dplyr)
data(mtcars)
names <- as.data.frame(row.names(mtcars))
colnames(names) <- c("name")
mtcars <- bind_cols(names, mtcars)
mtcars <- mutate(mtcars, am = factor(am, labels =c("AUTO","MANUAL")))
mtcars <- mutate(mtcars, vs = factor(vs, labels =c("VEE","STRAIGHT")))

library(ggplot2)
plothpvsmpg <- ggplot(mtcars, aes(x = hp, y = mpg, colour=am)) + geom_point()

print(plothpvsmpg)

#cyl
fitam <- lm(mpg ~ am, data=mtcars)
fitam_hp <- lm(mpg ~ am + hp, data=mtcars)
fitam_hp_wt <- lm(mpg ~ am + hp + wt, data=mtcars)
fitam_hp_carb <- lm(mpg ~ am + hp + carb, data=mtcars)

fitam_disp <- lm(mpg ~ am + disp, data=mtcars)
fitam_wt <- lm(mpg ~ am + wt, data=mtcars)
fitam_carb <- lm(mpg ~ am + carb, data=mtcars)
fitam_carb_gear <- lm(mpg ~ am + carb + gear, data=mtcars)
fitam_carb_hp <- lm(mpg ~ am + carb + hp, data=mtcars)
fitam_carb_wt <- lm(mpg ~ am + carb + wt, data=mtcars)
fitam_carb_disp <- lm(mpg ~ am + carb + disp, data=mtcars)
fitam_carb_disp_hp <- lm(mpg ~ am + carb + disp + hp, data=mtcars)
fitam_carb_disp_wt <- lm(mpg ~ am + carb + disp + wt, data=mtcars)
fitam_carb_qsec <- lm(mpg ~ am + carb + qsec, data=mtcars)
fitam_carb_qsec_wt <- lm(mpg ~ am + carb + qsec + wt, data=mtcars)
fitam_cyl <- lm(mpg ~ am + cyl, data=mtcars)

fitam_cyl_wt <- lm(mpg ~ am + cyl + wt, data=mtcars)
fitWCarb <- lm(mpg ~ am + cyl + wt + carb, data=mtcars)
fitWQsec <- lm(mpg ~ am + cyl + wt + qsec, data=mtcars)
fitWvs <- lm(mpg ~ am + cyl + wt + vs, data=mtcars)
fitWgear <- lm(mpg ~ am + cyl + wt + gear, data=mtcars)
fitWhp <- lm(mpg ~ am + cyl + wt + hp, data=mtcars)
fitWdisp <- lm(mpg ~ am + cyl + wt + disp, data=mtcars)

# fit3 <- lm(mpg ~ am + wt + qsec, data=mtcars)
# fit4 <- lm(mpg ~ am + wt + hp, data=mtcars)
# fit5 <- lm(mpg ~ am + wt + qsec + hp, data=mtcars)
# fit6 <- lm(mpg ~ am + wt + cyl, data=mtcars)
# fit7 <- lm(mpg ~ am + wt + qsec + cyl, data=mtcars)
# fit3 <- lm(mpg ~ am + cyl + disp, data=mtcars)
# fit4 <- lm(mpg ~ am + cyl + disp + hp, data=mtcars)
# fit5 <- lm(mpg ~ am + cyl + disp + hp + wt, data=mtcars)
# fit6 <- lm(mpg ~ am + cyl + disp + hp + wt + qsec, data=mtcars)
# fit7 <- lm(mpg ~ am + cyl + disp + hp + wt + qsec + vs, data=mtcars)
# fit8 <- lm(mpg ~ am + cyl + disp + hp + wt + qsec + vs + gear, data=mtcars)
# fit9 <- lm(mpg ~ am + cyl + disp + hp + wt + qsec + vs + gear + carb, data=mtcars)

fitam_hp <- lm(mpg ~ am + hp, data=mtcars)
fitam_hp_wt <- lm(mpg ~ am + hp + wt, data=mtcars)
mtcars_clean <- mtcars[-31,]
library(lmtest)
fitam_hp_wt_clean <- lm(mpg ~ am + hp + wt, data=mtcars_clean)
fitam_carb_qsec_wt_clean <- lm(mpg ~ am + carb + qsec + wt, data=mtcars_clean)
fitam_wt_carb_qsec_clean <- lm(mpg ~ am + wt + carb + qsec, data=mtcars_clean)
fitam_carb_qsec_wt_clean_hp <- lm(mpg ~ am + carb + qsec + wt + hp, data=mtcars_clean)
fitam_carb_qsec_wt_clean_disp <- lm(mpg ~ am + carb + qsec + wt + disp, data=mtcars_clean)
fitam_carb_qsec_wt_clean_drat <- lm(mpg ~ am + carb + qsec + wt + drat, data=mtcars_clean)
fitam_carb_qsec_wt_clean_vs <- lm(mpg ~ am + carb + qsec + wt + vs, data=mtcars_clean)
fitam_wt_qsec_clean <- lm(mpg ~ am + wt + qsec, data=mtcars_clean)
#plot(mtcars$mpg ~ factor(mtcars$am))
#abline(lm(mpg ~ factor(am), data=mtcars))
#fit <- lm(mpg ~ factor(am), data=mtcars)

#plot <- qplot(wt, mpg, data = mtcars, color = factor(am))
#plot
coeff <- summary(fitam_hp_wt_clean)$coefficients
delta <- coeff[2,1] + c(-1,1) * qt(.975,df = fitam_hp_wt_clean$df) * coeff[2,2]
coeff2 <- summary(fitam_carb_qsec_wt_clean)$coefficients
delta2 <- coeff2[2,1] + c(-1,1) * qt(.975,df = fitam_carb_qsec_wt_clean$df) * coeff2[2,2]

c