%% BE606 HW3 Problem 1
close all
clear all

%% Part 1

A = readtable('housing.csv');


for i = 1:1:20640
    if strcmp(A.ocean_proximity(i), 'NEAR BAY')
        A.ocean_proximity(i) = strrep(A.ocean_proximity(i), 'NEAR BAY', '4');      
    elseif strcmp(A.ocean_proximity(i), '<1H OCEAN')
        A.ocean_proximity(i) = strrep(A.ocean_proximity(i), '<1H OCEAN', '1');
    elseif strcmp(A.ocean_proximity(i), 'INLAND')
        A.ocean_proximity(i) = strrep(A.ocean_proximity(i), 'INLAND', '2');
    elseif strcmp(A.ocean_proximity(i), 'NEAR OCEAN')
        A.ocean_proximity(i) = strrep(A.ocean_proximity(i), 'NEAR OCEAN', '3');
    else
        A.ocean_proximity(i) = strrep(A.ocean_proximity(i), 'ISLAND', '5');
    end
%     str2double(A.ocean_proximity(i));
end


OPClass = A.ocean_proximity;
abc = cellfun(@str2num,OPClass);
B = table2array(A(:,1:9));

B = [B abc];

figure;
plotmatrix(B)


x1 = B(:,1);
x2 = B(:,2);
y = B(:,10);
figure;


for kk = 1:5
    scatter(x1(y == kk), x2(y == kk))
    hold on   
end


legend('<1H Ocean', 'Inland', 'Near Ocean', 'Near Bay', 'Island')
xlabel('Latitude')
ylabel('Longitude')


%new data

x1new = [-117.59292, -122.99700, -122.47476, -118.10267, -119.85405, -118.32575];
x2new = [34.10626, 37.89909, 37.74269, 34.13808, 34.41536, 33.34261];


scatter(x1new,x2new,30, 'ko', 'filled','HandleVisibility','off')

hold off

%% knnsearch
X = [x1 x2];
Ynew = [x1new' x2new'];

[idx, eD] = knnsearch(X,Ynew,'K', 20);

house1idx = idx(1,:)';
house1x1 = x1(house1idx);
house1x2 = x2(house1idx);
house1y = y(house1idx);

house2idx = idx(2,:)';
house2x1 = x1(house2idx);
house2x2 = x2(house2idx);
house2y = y(house2idx);

house3idx = idx(3,:)';
house3x1 = x1(house3idx);
house3x2 = x2(house3idx);
house3y = y(house3idx);

house4idx = idx(4,:)';
house4x1 = x1(house4idx);
house4x2 = x2(house4idx);
house4y = y(house4idx);

house5idx = idx(5,:)';
house5x1 = x1(house5idx);
house5x2 = x2(house5idx);
house5y = y(house5idx);

house6idx = idx(6,:)';
house6x1 = x1(house6idx);
house6x2 = x2(house6idx);
house6y = y(house6idx);

houseclasstot = [mode(house1y) mode(house2y) mode(house3y) mode(house4y) mode(house5y) mode(house6y)];
%make into table for output
for jj = 1:6
    fprintf('New House #%d ',jj)
    fprintf('Classified as %d\n', houseclasstot(jj))
    disp('')
end


House1table=table(house1x1, house1x2, house1y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
House2table=table(house2x1, house2x2, house2y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
House3table=table(house3x1, house3x2, house3y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
House4table=table(house4x1, house4x2, house4y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
House5table=table(house5x1, house5x2, house5y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
House6table=table(house6x1, house6x2, house6y, 'VariableNames', {'Longitude','Latitude', 'HousingClass'})
%% Webmap


wm = webmap('Open Street Map');
newhouses = geopoint(x2new, x1new);
webmarker_nh = wmmarker(newhouses, 'Color', 'red');

h1 = geopoint(house1x2, house1x1);
h2 = geopoint(house2x2, house2x1);
h3 = geopoint(house3x2, house3x1);
h4 = geopoint(house4x2, house4x1);
h5 = geopoint(house5x2, house5x1);
h6 = geopoint(house6x2, house6x1);

wmmarker(h1, 'Color', 'b');
wmmarker(h2, 'Color', 'k');
wmmarker(h3, 'Color', 'y');
wmmarker(h4, 'Color', 'm');
wmmarker(h5, 'Color', 'c');
wmmarker(h6, 'Color', [0.5 0.5 1]);