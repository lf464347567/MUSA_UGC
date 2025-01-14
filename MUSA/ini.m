function x = ini(data,num_alter,num_cri)

%生成准则和总体边际效用
level = 5;
x.pu = zeros(num_cri,level); %1,2,3,4,5个等级
c = rand(num_cri,1);
x.pu(:,level) = c/sum(c); %最后一个等级的效用为1
x.tu = zeros(1,level);
x.tu(level) = 1;
for i = 1 : num_cri+1
    if i ~= num_cri+1
        for j = 1 : level-2
            x.pu(i,level-j) = rand*(x.pu(i,level-j+1));
        end
    else
        for j = 1 : level-2
            x.tu(1,level-j) = rand*(x.tu(1,level-j+1));
        end
    end
end
 
x.utility = data;
for i = 1 : size(data,1)
    for j = 1 : size(data,2)
        if j ~= size(data,2)
            x.utility(i,j) = x.pu(j,data(i,j));
        else
            x.utility(i,j) = x.tu(1,data(i,j));
        end
    end
end

x.fit = fun(x,num_alter);

end
