
%% Loading photogrpahs from file
clear all
images(1) = struct('name',[],'og_im',[], 'grey_im', [],'intensity_prof',[]);
show_images = 0;
show_3dplot = 1;
show_1dplot = 1;

for i = 1:8
    name=strcat('snap_',num2str(i),'.jpeg');
    images(i).name = name;
    
    I = imread(name);
    images(i).og_im = I;
    
    I_grey = rgb2gray(I);
    images(i).grey_im = I_grey;

    [x,y] = size(I_grey);
    X = 1:x;
    Y = 1:y;
    
    [xx,yy] = meshgrid(Y,X);
    i1 = I_grey;
    
    figure;mesh(xx,yy,i1);
    view([0 90])
    colorbar
    
    figure;mesh(xx,yy,i2);
    view([0 90])
    colorbar
    
    x = zeros(size(I_grey,2));
    
    j = 1:size(x,1);
    x(j) = sum(I_grey(:,j)) ./ (size(I_grey,1));
    
    t = 1:size(x);
    
    plot(t,x);
    hold on;
    title(name);
    hold off;
    
end