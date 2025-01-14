function x = run_hit(lb,ub)
%% hit and run approach
iter = 1;
num_cri = size(lb,2);
num_alter = size(lb,1);
x = zeros(num_alter,num_cri);
for l = 1 : iter
    for i = 1 : num_alter
        index = [];
        for j = 1 : num_cri
            if lb(i,j) == ub(i,j)
                x(i,j) = lb(i,j);
            else
                x(i,j) = min(lb(i,j),ub(i,j)); 
                index = [index,j];
            end
        end
        
        if ~isempty(index)
            A = 0;
            while A ~= length(index)
                d = zeros(1,length(index));
                for k = 1 : length(index)
                    d(k) = rand.*(-1)^(randperm(2,1)); %随机生成向量
                end
                L2 = (sum(d.^2))^(1/2);
                lb1 = lb(i,index)-x(i,index)./d;
                ub1 = ub(i,index)-x(i,index)./d;
                for b = 1: length(lb1)
                    if lb1(b) == -inf || isnan(lb1(b))
                        lb1(b) = 0;
                    end
                    if ub1(b) == -inf || isnan(ub1(b))
                        ub1(b) = 0;
                    end
                end

                D = min([lb1(lb1>0),ub1(ub1>0)]);
                while isempty(D)
                    for k = 1 : length(index)
                        d(k) = rand.*(-1)^(randperm(2,1));
                    end
                    L2 = (sum(d.^2))^(1/2);
                    lb1 = lb(i,index)-x(i,index)./d;
                    ub1 = ub(i,index)-x(i,index)./d;
                    for b = 1: length(lb1)
                        if lb1(b) == -inf || isnan(lb1(b))
                            lb1(b) = 0;
                        end
                        if ub1(b) == -inf || isnan(ub1(b))
                            ub1(b) = 0;
                        end
                    end
                    D = min([lb1(lb1>0),ub1(ub1>0)]);
                end

                x_1 = ceil(x(i,index) + D*d);
                d12 = (sum((x_1 - x(i,index)).^(2)))^(1/2);
                kesai = rand;
                x_new = ceil(x(i,index) + kesai*D*L2/d12);
                for c = 1: length(x_new)
                    if x_new(c)>=lb(i,index(c)) && x_new(c)<=ub(i,index(c))
                        A = A + 1;
                    else
                        A = 0;
                        break
                    end
                end
            end
            x(i,index) = x_new;
        end
        
    end
end