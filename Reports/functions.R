percentage.table<-function(x,digit=1){
  tab <-table(x)
  pct.tab<-100*tab/sum(tab)
  round.tab<-round(x=pct.tab,digits=digit)
  return (round.tab)
}

round.numerics <- function(x, digits){
  if(is.numeric(x)){
    x <- round(x = x, digits = digits)
  }
  return(x)
}

logistic.regression.summary <- function(glm.mod, digits = 3, alpha = 0.05){
  library(data.table)
  glm.coefs <- as.data.table(summary(glm.mod)$coefficients, keep.rownames = TRUE)
  setnames(x = glm.coefs, old = "rn", new = "Variable")
  z <- qnorm(p = 1-alpha/2, mean = 0, sd = 1)
  glm.coefs[, Odds.Ratio := exp(Estimate)]
  glm.coefs[, OR.Lower.95 := exp(Estimate - z * `Std. Error`)]
  glm.coefs[, OR.Upper.95 := exp(Estimate + z * `Std. Error`)]
  
  return(glm.coefs[])
}


linear.regression.summary <- function(lm.mod, digits = 3, alpha = 0.05){
  library(data.table)
  lm.coefs <- as.data.table(summary(lm.mod)$coefficients, keep.rownames = TRUE)
  setnames(x = lm.coefs, old = "rn", new = "Variable")
  
  z <- qnorm(p = 1-alpha/2, mean = 0, sd = 1)
  lm.coefs[, Coef.Lower.95 := Estimate - z * `Std. Error`]
  lm.coefs[, Coef.Upper.95 := Estimate + z * `Std. Error`]
  return(lm.coefs)

}


engagement.model <- function(dt, outcome.name, input.names, model.type){
  res <- fit.model(dt = dt, outcome.name = outcome.name, input.names = input.names, model.type = model.type)
  return(res)
}

fit.model <- function(dt, outcome.name, input.names, model.type, digits = 3){
  library(formulaic)
  the.formula <- create.formula(outcome.name = outcome.name, input.names = input.names, dat = dt, reduce = T)
  if(model.type == "logistic"){
    mod <- glm(formula = the.formula, family = "binomial", data = dt)
    mod.summary <- logistic.regression.summary(glm.mod = mod, digits = digits)
  }
  if(model.type == "linear"){
    mod <- lm(formula = the.formula, data = dt)
    mod.summary <- linear.regression.summary(lm.mod = mod, digits = digits)
  }
  mod.summary.rounded <- mod.summary[, lapply(X = .SD, FUN = "round.numerics", digits = digits)]
  return(mod.summary.rounded)

}

#q1
show_respondent_pct<-function(dat,variable){
  tab <- percentage.table(x = dat[, .SD[1], by = "id"][, get(variable)])
  barplot(height = tab, space=0.01, las = 1, main =variable , ylab = "Percentage", xlab = variable, ylim = c(0, 1.2*max(tab, na.rm = TRUE)), col = "dodgerblue",font.axis = 1)
  space_val = 0
  text(x = -0.4 + 1:length(tab) * (1+space_val), y = tab, labels = sprintf("%.1f%%", tab), pos = 3)
}
#q2
show_Segmented_Outcomes<-function(rates,var.engagement,rank){
  
  setorderv(x = rates, cols = "Mean", order = -1)
  barplot(height = rates[1:rank,  Mean], names.arg = rates[1:rank, get(product.name)], space=0.01, las = 1, main = var.engagement, ylab = sprintf("Rate of %s", var.engagement), ylim = c(-100, 120), xaxt = "n", axes = F, col = "dodgerblue")
  axis(side = 2, at = 20*(0:5), las = 2)
  
  text(x = -0.5 + 1.02*1:rates[1:rank, .N], y = -15, labels = rates[1:rank, get(product.name)], srt = 45,  pos = 2)
  space_val = 0
  text(x = -0.4 + 1:rates[1:rank, .N] * (1+space_val), y = rates[1:rank, Mean], labels = sprintf("%.1f%%", rates[1:rank, Mean]), pos = 3)
}
#q3
q3_show_bp<-function(dat.clean,rank,bp.traits){
bp.mean <- dat.clean[,lapply(.SD, "mean"), .SDcols=bp.traits,by=product.name]
bp.res<-bp.mean[,.(Mean=rowMeans(.SD)),by=product.name]
setorderv(x = bp.res, cols = "Mean", order = -1)
barplot(height = bp.res[1:rank,  Mean], names.arg = bp.res[1:rank, get(product.name)], space=0.01, las = 1, main = "Brand perception", ylab = sprintf("Overall average perception for the brand"), ylim = c(-10,10), xaxt = "n", axes = F, col = "dodgerblue")
axis(side = 2, at = 2*(0:5), las = 2)

text(x =-0.5 +  1.02*1:bp.res[1:rank, .N], y=-1,labels = bp.res[1:rank, get(product.name)], srt = 45,  pos = 2)
space_val = 0
text(x = -0.4 + 1:bp.res[1:rank, .N] * (1+space_val), y = bp.res[1:rank, Mean], labels = sprintf("%.1f", bp.res[1:rank, Mean]), pos = 3)
}


#Q4
show_gap<-function(dat,var1,var2){
  gap<-dat[, .(Mean = 100*mean(get(var1), na.rm=TRUE)-100*mean(get(var2), na.rm=TRUE)),by=product.name]
  setorderv(x = gap, cols = "Mean", order = -1)
  barplot(height = gap[1:5, Mean], space=0.01, las = 1, main = sprintf("Gap in Outcomes: %s - %s", var1,var2),ylab="Percentage", ylim = c(1.2 * min(gap[, Mean], na.rm = TRUE), 1.2 * max(gap[, Mean], na.rm = TRUE)), col = "dodgerblue")
  text(x =-0.5 +  1.02*1:gap[1:5, .N], y=-1,labels = gap[1:5, get(product.name)], srt = 45,  pos = 2)
  space_val = 0
  text(x = -0.4 + 1:gap[, .N] * (1+space_val), y = gap[, Mean], labels = sprintf("%.1f%%", gap[, Mean]), pos = 3)
  
}
#q5
q5_model<-function(dat,engagement.var,q5_product, q5_age_group,q5_gender,q5_income_group,q5_region,q5_persona,model.type){
  df <- dat[complete.cases(dat[ , get(engagement.var)]),]
  agg<-df[get(product.name)!=q5_product,.(Aggregated.Engagement=mean(get(engagement.var))), by=id.name]
  subdat <- dat[get(product.name) %in% q5_product&get(age.group.name) %in% q5_age_group & get(gender.name) %in%q5_gender & get(income.group.name) %in% q5_income_group & get(region.name) %in% q5_region & get(persona.name) %in% q5_persona,]
  merged<-merge.data.table(agg,subdat, by=id.name)
  res <- fit.model(dt = merged, outcome.name =  "Consideration", input.names = new_vars, model.type = model.type)
  datatable(data = res, fillContainer = FALSE,options = list(pageLength = 8,autoWidth = TRUE))
}