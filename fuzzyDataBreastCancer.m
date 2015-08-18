function [fuzzyData,crispData]=fuzzyDataBreastCancer(sample)
% transform the Breast Cancer Data Set in a fuzzy data set and crisp data
% set, considering the given sample for each fuzzy variable
fid=fopen('breast-cancer.data');
format='%s %s %s %s %s %s %s %s %s %s';
data=textscan(fid, format,'delimiter',',');

%    Attribute Information:
%    data{1}. Class: no-recurrence-events, recurrence-events
%    data{2}. age: 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80-89, 90-99.
%    data{3}. menopause: lt40, ge40, premeno.
%    data{4}. tumor-size: 0-4, 5-9, 10-14, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50-54, 55-59.
%    data{5}. inv-nodes: 0-2, 3-5, 6-8, 9-11, 12-14, 15-17, 18-20, 21-23, 24-26, 27-29, 30-32, 33-35, 36-39.
%    data{6}. node-caps: yes, no.
%    data{7}. deg-malig: 1, 2, 3.
%    data{8}. breast: left, right.
%    data{9}. breast-quad: left-up, left-low, right-up,	right-low, central.
%    data{10}. irradiat:	yes, no.

%Fuzzy data set
N=length(data{1});
X=cell(N,10);
%Crisp data set
XX=zeros(N,10);
for i=1:N
    %data{1}. Class: no-recurrence-events, recurrence-events
    %-------------------------------------------------------
    if strcmp(data{1}(i),'no-recurrence-events')
        X{i,1}=1;
    else
        X{i,1}=-1;
    end
    %Crisp version
    XX(i,1)=X{i,1};
    
    %data{2}. age: 10-19, 20-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80-89, 90-99.
    %age: trapezoidal membership function
    %---------------------------------------------------------------------------
    temp = strread(data{2}{i},'%d-');
    X{i,2}= trapmf(sample,[temp(1)-5 temp(1) temp(2) temp(2)+5]);
    %Crisp version
    XX(i,2)=mean(temp);
    
    %data{3}. menopause: lt40, ge40, premeno.
    % lt40 Z-shaped membership function
    % ge40 S-shaped membership function
    % premeno: usually between 40 and 50, gaussian membership function
    %----------------------------------------------------------------------------
    if strcmp(data{3}(i),'lt40')
        X{i,3}=zmf(sample,[40 45]);
        %Crisp version
        XX(i,3)=-1;
    elseif strcmp(data{3}(i),'ge40')
        X{i,3}=smf(sample,[35 40]);
        %Crisp version
        XX(i,3)=1;
    else
        X{i,3}= gaussmf(sample,[ (50-40)/(2*sqrt(2*log(2))) ,45]); %Full width at half maximum
        %Crisp version
        XX(i,3)=0;
    end
    
    %data{4}. tumor-size: 0-4, 5-9, 10-14, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50-54, 55-59.    temp = strread(data{4}{i},'%d-');
    % Z-saphed and S-shaped MF on the borders, gaussian MF on the rest
    %--------------------------------------------------------------------------
    temp = strread(data{4}{i},'%d-');
    if temp(1)==0
        X{i,4} = zmf(sample,[temp(1) temp(2)+5]); % because  next value
    elseif temp(1)==55
        X{i,4} = smf(sample,[temp(1)-5 temp(2)]);
    else
        X{i,4} = gaussmf(sample,[ (temp(2)-temp(1))/(2*sqrt(2*log(2))) ,mean(temp)]);
    end
    %Crisp version
    XX(i,4)=mean(temp);
    
    %data{5}. inv-nodes: 0-2, 3-5, 6-8, 9-11, 12-14, 15-17, 18-20, 21-23, 24-26, 27-29, 30-32, 33-35, 36-39.
    % Z-saphed and S-shaped MF on the borders, gaussian MF on the rest
    %-----------------------------------------------------------------------
    temp = strread(data{5}{i},'%d-');
    if temp(1)==0
        X{i,5} = zmf(sample,[temp(1) temp(2)+3]); % because  next value
    elseif temp(1)==36
        X{i,5} = smf(sample,[temp(1)-3 temp(2)]);
    else
        X{i,5} = gaussmf(sample,[ (temp(2)-temp(1))/(2*sqrt(2*log(2))) ,mean(temp)]);
    end
    %Crisp version
    XX(i,5)=mean(temp);
    
    % data{6}. node-caps: yes, no.
    %-----------------------------
    if strcmp(data{6}(i),'yes')
        X{i,6}=1;
    else
        X{i,6}=-1;
    end
    %Crisp version
    XX(i,6)=X{i,6};
    
    %data{7}. deg-malig: 1, 2, 3.
    %------------------------------
    X{i,7}=strread(data{7}{i})-2; % to be -1 0 1
    %Crisp version
    XX(i,7)=X{i,7};
    
    %data{8}. breast: left, right.
    %------------------------------
    if strcmp(data{8}(i),'left')
        X{i,8}=1;
    else
        X{i,8}=-1;
    end
    %Crisp version
    XX(i,8)=X{i,8};
    
    %data{9}. breast-quad: left-up, left-low, right-up,	right-low, central.
    %----------------------------------------------------------------------
    if strcmp(data{9}(i),'left-up')
        X{i,9}=-1;
    elseif strcmp(data{9}(i),'left-low')
        X{i,9}=-0,5;
    elseif strcmp(data{9}(i),'right-up')
        X{i,9}=0;
   elseif strcmp(data{9}(i),'right-low')
        X{i,9}=0,5;
    else
        X{i,9}=1;
    end
    %Crisp version
    XX(i,9)=X{i,9};
    
    %data{10}. irradiat:	yes, no.
    %--------------------------
    if strcmp(data{10}(i),'yes')
        X{i,10}=1;
    else
        X{i,10}=-1;
    end
    %Crisp version
    XX(i,10)=X{i,10};
    
end

fuzzyData=X;
crispData=XX;
