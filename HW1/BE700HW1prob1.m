%% BE700 HW1 Prob 1

clear all
close all
warning('off', 'all') %warnings got annoying
tic
%% Part 1
[x1,x2,y] = textread('Problem1_BesselData.txt', '%f%f%f', 'headerlines',1);

R = (x1.^2 + x2.^2).^0.5;

% scatter(R,y)

for P=1:14
    A= ones(length(R),P+1);
    for n1 = 1:P
        A(:,n1+1) = R.^n1;
    end
    B_hat.temp = (A' * A) \ (A' * y);
    B_hat.i{P} = fliplr(B_hat.temp');
end


yfit = ones(1,5000);
R2 = R';

for P=1:14
    yfit(P,:) = polyval(cell2mat(B_hat.i(P)), R2);
end

%resids

for P=1:14
    r(:,P) = y - yfit(P,:)';
    r2_sum(:,P) = sum(r(:,P).^2);
end

tfields = {'Polynomial order (p)'
                   '||r||^2 for a regular least-squares fit'
                   };
               
po = 1:1:14;
r2sumt = r2_sum';
  
po_table = table(po',r2sumt, 'VariableNames', tfields)

%plots
  
figure
%3 2x2, 1x1
z = 1;
for pID = 1:4
    
    subplot(2,2,pID);
    scatter(R,y)
    hold on
    scatter(R',yfit(z,:))
    title(['Polynomial: ', num2str(z)])
    z = z+1;
end

figure
for pID = 1:4
    
    subplot(2,2,pID);
    scatter(R,y)
    hold on
    scatter(R',yfit(z,:))
    title(['Polynomial: ', num2str(z)])
    z = z+1;
end

figure
for pID = 1:4
    
    subplot(2,2,pID);
    scatter(R,y)
    hold on
    scatter(R',yfit(z,:))
    title(['Polynomial: ', num2str(z)])
    z = z+1;
end

figure
for pID = 1:2
    
    subplot(2,1,pID);
    scatter(R,y)
    hold on
    scatter(R',yfit(z,:))
    title(['Polynomial: ', num2str(z)])
    z = z+1;
end

%% Part 2

for numPEcurves = 1:1:20
    bins = randsample(5000,5000);
    tot = reshape(bins,1000,5);
    
    for p = 1:1:14
        
        for mse_val = 1:1:5
          tot2 = tot;
          tot2(:,mse_val) = [];
          rn.train{mse_val} = r(tot2);
          rn.test{mse_val} = r(tot(:,mse_val));
          yn.train{mse_val} = y(tot2);
          yn.test{mse_val} = y(tot(:,mse_val));

          x = rn.train{mse_val}(:);
          ynew = yn.train{mse_val}(:);
          
          %now do LSQ
          AA = ones(length(x),p+1);
          for n2 = 1:p
              AA(:,n2+1) = x.^n2;
             
          end
          B_hat2.t = (AA' * AA) \ (AA' * ynew);
          B_hat2.i{numPEcurves}{p} = fliplr(B_hat2.t'); 
          
          %now that we have coeffs
          %use polyval to fit on top of test data
          %obtain mse, average,save final 
          %ultimately 20x14 mat
          
          yfit2.t = polyval(B_hat2.i{numPEcurves}{p}, rn.test{mse_val}'); 
          yfit2.i{numPEcurves}{p} = yfit2.t;
          
          diff12.t{mse_val} = (yfit2.t - yn.test{mse_val}');
          mse(mse_val) = 1/1000 * sum(diff12.t{mse_val}.^2);         
        end
        MSE.t = 1/5 * sum(mse);
        mse_tot(numPEcurves,p) = MSE.t;
%         pause(10)
    end
end

tfields = {'p = 1' 'p = 2' 'p = 3' 'p = 4' 'p = 5' 'p = 6' 'p = 7' 'p = 8' 'p = 9' 'p = 10' 'p = 11' 'p = 12' 'p = 13' 'p = 14'};
               

pe_table = table(mse_tot(:,1), mse_tot(:,2), mse_tot(:,3) ,mse_tot(:,4), mse_tot(:,5), ...
 mse_tot(:,6), mse_tot(:,7), mse_tot(:,8), mse_tot(:,9), mse_tot(:,10), mse_tot(:,11), mse_tot(:,12), ...
 mse_tot(:,13), mse_tot(:,14),'VariableNames', tfields)


figure
for pp = 1:1:14
    plot(1:1:14, mse_tot(pp,:), '-o')
    hold on
end
legend(tfields)
ylabel('PE Values')
xlabel('polynomial degree for fitting')
%% Part 3

disp(' Polynomial model p=11 gives the optimum fit, visually it is the second model to describe the data, (second lowest ||r||^2) and has agreement on the PE plot.') 
disp(' Initially visually I assumed 10 would be best since it was the first, however looking at the PE plot, there seems to be some disagreement, thus I chose p = 11')

%% Part 4
%p = 11


figure
plot3(x1, x2, y, '.')
hold on
x1_mesh = -10: 0.1 : 10;
x2_mesh = -10: 0.1 : 10;
[X1, X2] = meshgrid(x1_mesh, x2_mesh);
Rmesh = sqrt(X1.^2   +  X2.^2);

beta = B_hat.i{1,11};
Z = polyval( B_hat.i{1,11}, Rmesh);
a = surf(Z);
a.EdgeColor = 'none';

title('optimum p=11')
xlabel('X1 axis')
ylabel('X2 axis')
zlabel('membrane displacement')
disp('I am confused as to why the surf plot is centered around 100 rather than 0, the overall shape matches the ripples in the original data.')


%% Echoing final values
diary vjprob1.txt
echo on
disp('Part 1')
po_table
disp('Part 2')
pe_table

disp('Part 3')
disp(' Polynomial model p=11 gives the optimum fit, visually it is the second model to describe the data, (second lowest ||r||^2) and has agreement on the PE plot.') 
disp(' Initially visually I assumed 10 would be best since it was the first, however looking at the PE plot, there seems to be some disagreement, thus I chose p = 11')

echo off
