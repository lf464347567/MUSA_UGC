function x4 = mut(x,num_alter,num_cri)
%% mutation 
% [~, index] = min([x.fit]);
[~, index] = sort([x.fit]);
x4 = x;
level = 5;
for i = 1: length(x)
    x1 = x(i);
    if rand<0.8
        per = rand;
        x1.pu = (1-per)*x(index(randperm(5,1))).pu+per*x1.pu;   %lamda变异(一半最优，一半本身)
        x1.tu = (1-per)*x(index(randperm(5,1))).tu+per*x1.tu;  %gama变异(一半最优，一半本身)
    else
        x1.pu = zeros(num_cri,level); %1,2,3,4,5个等级
        c = rand(num_cri,1);
        x1.pu(:,level) = c/sum(c); %最后一个等级的效用为1
        x1.tu = zeros(1,level);
        x1.tu(level) = 1;
        for k = 1 : num_cri+1
            if k ~= num_cri+1
                for j = 1 : level-2
                    x1.pu(k,level-j) = rand*(x1.pu(k,level-j+1));
                end
            else
                for j = 1 : level-2
                    x1.tu(1,level-j) = rand*(x1.tu(1,level-j+1));
                end
            end
        end
    end
    x1.fit = fun(x1,num_alter);
    
    x2 = x1;
    for j = 1 : size(x2.pu,1) + 1
        if j < size(x2.pu,1) + 1
            for k = 2 : size(x2.pu,2)-1
                if rand < 0.5
                    x2.pu(j,k) = rand*(x2.pu(j,k+1)-x2.pu(j,k-1));
                end
            end
        else
            for k = 2 : size(x1.pu,2)-1
                if rand < 0.5
                    x2.tu(j,k) = rand*(x2.tu(1,k+1)-x2.tu(1,k-1));
                end
            end
        end
    end
    x2.fit = fun(x2,num_alter);
    if x1.fit < x2.fit
        x4(i) = x1;
    else
        x4(i) = x2;
    end
    
end
    