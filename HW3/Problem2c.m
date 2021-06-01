%% BE606 HW3 Problem 2c

clear all
close all

%% Part 1


A = double(imread('default_rgb_reference.tif'));

red = A(:,:,1);
green = A(:,:,2);
blue = A(:,:,3);

figure;
plot3(red,green,blue, 'k.')
grid on
title('Raw Scatter Plot of Intensities')

xlabel('red intensities')
ylabel('green intensities')
zlabel('blue intensities')


X = [red(:), green(:), blue(:)];


[class,cent] = kmeans(X,3,'Replicates',10);

figure;

for i = 1:3    
    cl = i == class; 
    plot3(red(cl),green(cl),blue(cl),'.','MarkerSize',12)    
    hold on
end
grid on
legend('C1','C2','C3')
title('K-means RGB Intensities')
xlabel('red intensities')
ylabel('green intensities')
zlabel('blue intensities')


E = NaN*ones(size(X));
E(1==class,:) = X(1==class,:);
E = uint8(reshape(E,size(A)));
figure;
image(E)
title('filtered image E')


F = NaN*ones(size(X));
F(2==class,:) = X(2==class,:);
F = uint8(reshape(F,size(A)));
figure;
image(F)
title('filtered image F')

G = NaN*ones(size(X));
G(3==class,:) = X(3==class,:);
G = uint8(reshape(G,size(A)));
figure;
image(G)
title('filtered image G')

%% Part 2

A = double(imread('confocal_image01.tif'));

red = A(:,:,1);
green = A(:,:,2);
blue = A(:,:,3);

X = [red(:), green(:), blue(:)];
%Using 4 centroids intuitively makes sense here--we have R,G,B and Black
%colors in the image
[class,cent] = kmeans(X,4,'Replicates',50); 

figure;

for i = 1:4    
    cl = i == class; 
    plot3(red(cl),green(cl),blue(cl),'.','MarkerSize',12)    
    hold on
end
legend('C1','C2','C3','C4')
title('K-means RGB Intensities of confocal w/4 Clusters')
xlabel('red intensities')
ylabel('green intensities')
zlabel('blue intensities')


E = NaN*ones(size(X));
E(1==class,:) = X(1==class,:);
E = uint8(reshape(E,size(A)));
figure;
image(E)
title('Cluster 1')


F = NaN*ones(size(X));
F(2==class,:) = X(2==class,:);
F = uint8(reshape(F,size(A)));
figure;
image(F)
title('Cluster 2')

G = NaN*ones(size(X));
G(3==class,:) = X(3==class,:);
G = uint8(reshape(G,size(A)));
figure;
image(G)
title('Cluster 3')


H = NaN*ones(size(X));
H(4==class,:) = X(4==class,:);
H = uint8(reshape(H,size(A)));
figure;
image(H)
title('Cluster 4')

%% Part 3

A = double(imread('Bacteria_image01.tif'));

red = A(:,:,1);
green = A(:,:,2);
blue = A(:,:,3);

%because we're essentially looking for 3 classes (red, y/g and background)
%k = 3

X = [red(:), green(:), blue(:)];


[class,cent] = kmeans(X,3,'Replicates',50);

figure;

for i = 1:3    
    cl = i == class; 
    plot3(red(cl),green(cl),blue(cl),'.','MarkerSize',12)    
    hold on
end
grid on
legend('C1','C2','C3')
title('K-means RGB Intensities of Bacteria')
xlabel('red intensities')
ylabel('green intensities')
zlabel('blue intensities')

E = NaN*ones(size(X));
E(1==class,:) = X(1==class,:);
E = uint8(reshape(E,size(A)));
figure;
image(E)
title('filtered image C1')


F = NaN*ones(size(X));
F(2==class,:) = X(2==class,:);
F = uint8(reshape(F,size(A)));
figure;
image(F)
title('filtered image C2')

G = NaN*ones(size(X));
G(3==class,:) = X(3==class,:);
G = uint8(reshape(G,size(A)));
figure;
image(G)
title('filtered image C3')