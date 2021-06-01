%% prob2
clear all
close all


%% Part A
opts = detectImportOptions('biopsy_data_missing_values.csv', 'NumHeaderLines', 1');
preview('biopsy_data_missing_values.csv', opts)

A = readtable('biopsy_data_missing_values.csv', 'HeaderLines', 1);

for i = 1:height(A)
    if isempty(A.Var2{i})
        A.Var2{i} = 'Irregular';
    end
end



nanind = find(isnan(A.Var1));
var1tmp = A.Var1;
var1tmp(nanind(1)) = 6;
var1tmp(nanind(2)) = 10;
A.Var1 = var1tmp;

A

%% Part B

ns1 = {'Irregular', 'Large', 'Convex', 'Rough', 'Neutral'};
ns2 = {'Irregular', 'Small', 'Flat', 'Rough', 'Red'};
ns3 = {'Circle', 'Large', 'Concave', 'Smooth', 'Neutral'};
ns4 = {'Cirlce', 'Large', 'Convex', 'Smooth', 'Dark'};
ns5 = {'Triangle', 'Large', 'Concave', 'Smooth', 'Neutral'};

nstot = {ns1 ns2 ns3 ns4 ns5};

%for ns1 ex


A1 = A(1:6,:); %malignant table (pos)
A2 = A(7:12,:); %benign table (neg)
pc1 = 0.5;
pc2 = 0.5;


for i = 1:length(nstot)
    pshape1 = length(find(strcmp(A1.Var2, nstot{i}{1})))/height(A1);
    prad1 = length(find(strcmp(A1.Var3, nstot{i}{2})))/height(A1);
    pconcav1 = length(find(strcmp(A1.Var4, nstot{i}{3})))/height(A1);
    ptext1 = length(find(strcmp(A1.Var5, nstot{i}{4})))/height(A1);
    pcol1 = length(find(strcmp(A1.Var6, nstot{i}{5})))/height(A1);

    posprob(i) = log(pshape1 * prad1 * pconcav1 * ptext1 * pcol1 * pc1);
    
    
    nshape1 = length(find(strcmp(A2.Var2, nstot{i}{1})))/height(A2);
    nrad1 = length(find(strcmp(A2.Var3, nstot{i}{2})))/height(A2);
    nconcav1 = length(find(strcmp(A2.Var4, nstot{i}{3})))/height(A2);
    ntext1 = length(find(strcmp(A2.Var5, nstot{i}{4})))/height(A2);
    ncol1 = length(find(strcmp(A2.Var6, nstot{i}{5})))/height(A2);

    negprob(i) = log(nshape1 * nrad1 * nconcav1 * ntext1 * ncol1 * pc2);
    
end


for ii = 1:5
    if negprob(ii) > posprob(ii)
        class{ii} = 'benign';
    else
        class{ii} = 'malignant';
        %err on this side, to prompt pt to another test
    end
end

        
samplenames = 1:5;
LogNegProb = negprob;
LogPosProb = posprob;
varnames = {'Sample', 'LogNegProb', 'LogPosProb', 'Classification'};
ResultTable = table(samplenames', LogNegProb', LogPosProb', class', 'VariableNames', varnames)


disp('Sample 5 had was one of two triangle shapes, which was not contained in the Malignant group.')
