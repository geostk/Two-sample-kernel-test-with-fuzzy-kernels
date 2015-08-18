function result=experimentParallel(exp,alph,m,shuff,nTest,nroEpoch,X,XX)
result=cell(3,1);
switch exp
    case 1
        for i=1:2
            
            [STAT1, STAT2]=firstExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 2
        for i=1:2
            
            [STAT1, STAT2]=secondExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
        end
    case 3
        for i=1:2
            
            [STAT1, STAT2]=thirdExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 4
        for i=1:2
            
            [STAT1, STAT2]=fourthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 5
        for i=1:2
            
            [STAT1, STAT2]=fifthExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
        end
    case 6
        for i=1:2
            
            [STAT1, STAT2]=sixthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 7
        for i=1:2
            
            [STAT1, STAT2]=seventhExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
        end
    case 8
        for i=1:2
            
            [STAT1, STAT2]=eighthExperiment(alph,m,shuff,nTest,nroEpoch,XX,i)
        end
        
    case 9
        for i=1:2
            
            [STAT1, STAT2]=ninthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 10
        for i=1:2
            
            [STAT1, STAT2]=tenthExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
    case 11
        for i=1:2
            
            [STAT1, STAT2]=eleventhExperiment(alph,m,shuff,nTest,nroEpoch,X,i)
        end
        
end

result{1}=STAT1;
result{2}=STAT1;
result{3}=exp;