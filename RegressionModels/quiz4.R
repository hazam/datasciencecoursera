library(MASS)
data(shuttle)

#Q1
shuttle$useN <- sapply(shuttle$use, function(x) if (x == "auto") 1 else 0)
model <- glm(useN ~ wind - 1, family="binomial", shuttle)
#print(summary(model))
#print(exp(model$coeff[1]) / exp(model$coeff[2]))

#Q2
model2 <- glm(useN ~ wind + magn - 1, family="binomial", shuttle)
#print(exp(model2$coeff[1]) / exp(model2$coeff[2]))

#Q3
shuttle$useM <- sapply(shuttle$use, function(x) if (x == "auto") 0 else 1)
model3 <- glm(useM ~ wind - 1, family="binomial", shuttle)
#print(model$coeff)
#print(model3$coeff)

#Q4
data(InsectSprays)
fit1 <- glm(count ~ spray - 1, family = "poisson", InsectSprays)
#print(exp(fit1$coeff[1]) / exp(fit1$coeff[2]))

#Q5
untranslated <- glm(count ~ spray - 1,family = "poisson", InsectSprays, offset = log(count + 1))
translated <- glm(count ~  spray - 1,family = "poisson", InsectSprays, offset = log(count + 1) + log(10))

#Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
splineTerms <- sapply(c(0), function(k) (x > k) * (x - k))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x,y,frame=FALSE)
lines(x, yhat, col= "red")