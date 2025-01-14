function y = gfun(lamda,gama,c,i,j)

y = ((lamda+c(i,j))^gama)/(((lamda+c(i,j))^gama)+((lamda-c(i,j))^gama));