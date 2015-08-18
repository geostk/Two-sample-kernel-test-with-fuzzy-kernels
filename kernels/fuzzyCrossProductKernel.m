function k=fuzzyCrossProductKernel(X,Y,kern, param)
%   Positive definite kernel functions on fuzzy sets. Guevara J, et al.
%   input:  X and Y are a Nxp and Mxp matrices, each row is a fuzzy set with p
%   elements, such X(i,j) is the degree membership of element j of the fuzzy set i
%           kern:  1= gaussian 2=dot product 3=polinomial
%
%    output kernel matriz k of size NxN with the similarity measures
%
%    Example:
%    Asumme that X contain 10 fuzzy sets and Y contain 15 fuzzy sets:
%     %X=rand(10,100); Y=rand(15,100);
%      
%     k=fuzzyCrossProductKernel(X,Y,1)

[N,p]=size(X);
[M,~]=size(Y);

if kern==1
    for i=1:N
        for j=1:M
            sum=0;
            for l=1:p
                sum=RBF_kernel(X(i,l),Y(j,l),param)*X(i,l)*Y(i,l);                
            end
            k(i,j)=sum; %think to normalize
        end
    end

end

