data(mtcars);

#question1
fit <- lm(mpg ~ factor(cyl) + wt,mtcars)
#lm takes 4 cylinder as reference
#print(coef(fit)[3])

#question2
fitNoAdjust <- lm(mpg ~ factor(cyl),mtcars)

#question3
fitInteract <- lm(mpg ~ factor(cyl) * wt,mtcars)

library(lmtest)
lrtest(fit,fitInteract)

#question4
fitBias <- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)

#question5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fitXY <- lm(y ~ x)

#question6
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

fit2XY <- lm(y ~ x)
