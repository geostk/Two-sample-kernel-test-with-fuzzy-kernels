function testResult=testMMD(K, L, KL,N,alph, testStat)
% find the threshold of a MMD test with boostrap
% input:    L L KL, kernel matrices for XX YY and XY
%           N, number of boostrap shuffkes to estimate the null CDF
%           alph is a level of the test
[m,~]=size(K);
Kz = [K KL; KL' L];


MMDarr = zeros(N,1);
for whichSh=1:N
    
    [~,indShuff] = sort(rand(2*m,1));
    KzShuff = Kz(indShuff,indShuff);
    K = KzShuff(1:m,1:m);
    L = KzShuff(m+1:2*m,m+1:2*m);
    KL = KzShuff(1:m,m+1:2*m);
    
    
    MMDarr(whichSh) = 1/m * sum(sum(K + L - KL - KL'));
    
end

MMDarr = sort(MMDarr);

thresh = MMDarr(round((1-alph)*N));

if testStat<= thresh
    testResult=1; %acepted p=q
else
    testResult=0; %rejected p=q
end