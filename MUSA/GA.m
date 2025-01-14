%% 遗传算法
clear; clc;
% load data
% load business
% load couples
% load solo
% load friends
load family
tic
%初始化
iiter = 1000;
error = [];
x = cell(1,iiter);
x1 = cell(1,iiter);
% mpl = cell(1,iiter);
ASI = zeros(iiter,7);
ADI = zeros(iiter,7);
AII = zeros(iiter,6);
obj = zeros(1,iiter);
for ii = 1 : iiter
    x1{ii} = run_hit(lb,ub);
    result = guro(x1{ii});
    try 
        mpl(ii) = result;
        for i = 1 : 7
            x{ii}(i,:)   = mpl(ii).x((i-1)*5+1:(i-1)*5+5);
        end
        obj(ii) = mpl(ii).objval;
        [ASI(ii,:),ADI(ii,:),AII(ii,:)] = MUSA_index(x1{ii},x{ii});
    catch exception 
        error = [error,ii];
    end
    if ii == 20
        if sum(obj)==0
            c = 0;
        end
    end
end
toc
    
num = sum(obj~=0);
aver = zeros(3,7);
aver(1,1:6) = sum(AII)/num;
aver(2,:) = sum(ADI)/num;
aver(3,:) = sum(ASI)/num;
x_aver = zeros(7,5);
for i = 1: 1000
    if ~isempty(x{i})
        x_aver = x_aver+x{i};
    end
end
x_aver=x_aver/num;
aver_obj = sum(obj)/num;
%     for i = 1 : 40
%         x(i) = ini(data,num_alter,num_cri);
%     end

%     [value, index] = min([x.fit]);
%     bestx = x(index);
%     %循环
%     iter = 100;
%     bestvalue = zeros(1,iter);
%     for i = 1 : iter
%         x1 = swap(x,c,U,L,num_alter,num_cri);
%         x2 = crossover(x,num_alter,num_cri);
%         x3 = mut(x,num_alter,num_cri); %变异
%         x1 = [];
%         x = selection(data,x,x1,x2,x3,num_alter,num_cri);
%         [value, index] = min([x.fit]);
%         if value < bestx.fit
%             bestx = x(index);
%         end
%         bestvalue(i) = bestx.fit;
%     end
% MUSA_index(data,x(1))
