function [ASI,ADI,AII] = MUSA_index(data,x)


ASI = zeros(1,7); %The average global and partial satisfaction indices
ADI = zeros(1,7);  %The average global and partial demanding indices
AII = zeros(1,6);  %The average global and partial improvement indices

cri = zeros(7,5);
for i = 1 : size(data,1)
    for j = 1 : size(data,2)
        cri(j,data(i,j)) = cri(j,data(i,j))+1;  
    end
end
p_cri = cri/5832;
for i = 1 : 7
    ASI(i) = sum(p_cri(i,:).*(x(i,:)));
end

for i = 1 : 7
    ADI(i) = sum([0:3]/4-x(i,1:4))/sum(sum(0:3)/4);
end

for i = 1 : 6
    AII(i) = x(i,5)*(1-ASI(i));
end

end

