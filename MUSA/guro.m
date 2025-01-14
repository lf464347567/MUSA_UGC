% function lp(data)
% Copyright 2022, Gurobi Optimization, LLC
%
% This example formulates and solves the following simple LP model:
% maximize
%       x + 2 y + 3 z
% subject to
%       x +   y        <= 1
%             y +   z  <= 1
%


function result = guro(data)
    A1 = zeros(size(data,1),size(data,1)*2+35);
    for i = 1 : size(data,1)
        A1(i, 35+(i-1)*2+1) = -1;
        A1(i, 35+(i-1)*2+2) = +1;
        for j = 1 : size(data,2)
            if j ~= size(data,2)
                A1(i, (j-1)*5+data(i,j)) = -1;
            else
                A1(i, (j-1)*5+data(i,j)) = 1;
            end
        end
    end

    A2 = zeros(4*size(data,2),size(data,1)*2+35);
    for i = 1 : size(data,2)
        for j = 1 : 4
            A2((i-1)*4+j,(i-1)*5+j+1) = 1;
            A2((i-1)*4+j,(i-1)*5+j) = -1;
        end
    end


    A3 = zeros(size(data,2),size(data,1)*2+35);
    for i = 1 : size(data,2)
        A3(i,(i-1)*5+1) = 1;
    end

    A4 = zeros(1,size(data,1)*2+35);
    for i = 1 : 6
        A4(1,(i-1)*5+5) = 1;
    end

    A5 = zeros(1,size(data,1)*2+35);
    A5(1,35) = 1;

    A6 = zeros(35+size(data,1)*2,size(data,1)*2+35);
    for i = 1 : 35+size(data,1)*2
        A6(i,size(data,1)*2+35) = 1;
    end


    A = [A1;A2;A3;A4;A5;A6];
%     rhs = zeros(1,size(data,1)+5*size(data,2));
    rhs = [zeros(1,size(data,1)),rand(1,4*size(data,2))*0.08,zeros(1,size(data,2))];
    sense = [];
    for i = 1 : size(data,1)
        sense = [sense, '='];
    end
    for i = 1 : 4*size(data,2)
        sense = [sense, '>'];
    end
    for i = 1 : size(data,2)+2
        sense = [sense, '='];
    end
    for i = 1 : 35+size(data,1)*2
        sense = [sense, '>'];
    end

    model.A = sparse(A);
    model.obj = [zeros(1,35),zeros(1,size(data,1)*2)+1];
    model.modelsense = 'Min';
    model.rhs = [rhs,1,1,zeros(1,35+size(data,1)*2)];
    model.sense = sense;

    result = gurobi(model);
end
% 
% disp(result.objval);
% disp(result.x);

% Alterantive representation of A - as sparse triplet matrix
% i = [1; 1; 2; 2];
% j = [1; 2; 2; 3];
% x = [1; 1; 1; 1];
% model.A = sparse(i, j, x, 2, 3);

% Set some parameters
% params.method = 2;
% params.timelimit = 100;

% result = gurobi(model, params);

% disp(result.objval);
% disp(result.x)
% end