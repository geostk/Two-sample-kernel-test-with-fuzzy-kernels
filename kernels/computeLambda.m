function [lambda firstQuantile lastQuantile]=computeLambda(X,Y)
% Heuristic to find the RBF kernel parameter

[m,~] = size(X);
[p,~] = size(Y);


if (m+p)>2000
    indX=randsample(m,1000);
    indY=randsample(p,1000);
else
    indX=1:m;
    indY=1:p;
end
M=sqdistALL(X(indX,:),Y(indY,:));
lambda=median(M(:));
firstQuantile=quantile(M(:),0.1);
lastQuantile=quantile(M(:),0.9);

if lambda==0
    lambda=eps;
end
if firstQuantile ==0
    firstQuantile=0.25;
end
if lastQuantile ==0
    lastQuantile==0.25;
    
end