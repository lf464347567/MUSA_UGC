function g = cal_mav(x,num_alter,num_cri,c)
g = zeros(num_alter,num_cri);%边际效用值
for i = 1 : num_alter
    for j = 1 : num_cri 
        g(i,j) = gfun(x.lamda,x.gama,c,i,j); 
    end
end