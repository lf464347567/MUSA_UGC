x2 = zeros(7,5);
for i = 1 : length(x)
    if ~isempty(x{i})
        x2 = x2 + x{i};
    end
end
x2  = x2/635;
a_adi = (sum(ADI)/635)';
a_aii = (sum(AII)/635)';
a_asi = (sum(ASI)/635)';

x3 = zeros(7,5);
for i = 1 : 2500
    for j = 1 : 5832
        for k = 1 : 7
            x3(k,x1{i}(j,k)) = x3(k,x1{i}(j,k))+1;
        end
    end
end

for i = 1 : 7
    t = sum(x3');
    x3(i,:) = x3(i,:)/t(i);
end