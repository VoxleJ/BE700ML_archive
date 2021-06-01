%% Problem 2 Plots

clear all
close all

x1 = 0:1:12;
x2 = 0:1:12;

[X1, X2] = meshgrid(x1,x2);

tot = sign(1.946*sign(X1-4.5)+1.376*sign(X2-5.5)+0.693*sign(X2-2.5));

scatter(X1(tot==-1), X2(tot==-1), 'rx')

hold on

scatter(X1(tot==+1), X2(tot==+1), 'b.')

title('adaboost classifier plot')
xlabel('x1')
ylabel('x2')

disp('Alpha1 = 1.946, h1 is x1>4.5')
disp('Alpha2 = 1.376, h2 is x2>5.5')
disp('Alpha3 = 0.693, h3 is x2>2.5')
