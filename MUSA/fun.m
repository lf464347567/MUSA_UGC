function fit = fun(x,num_alter)


x.sigma1 = zeros(num_alter,1); %正估计
x.sigma2 = zeros(num_alter,1); %负估计
for i = 1 : num_alter
    left = sum(x.utility(i,end-1));
    right = x.utility(i,end);
    if left > right
        x.sigma2(i) = left-right;
    elseif left < right
        x.sigma1(i) = right-left;
    end
end
        
fit = sum(x.sigma1+x.sigma2);