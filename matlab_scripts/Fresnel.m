% Generating theoretical Model for Fresnel
clear all;
close all;

lambda = 6.328e-7;
k = (2*pi())/lambda;
z = 3.93;

j = 1;
scales = [3 3 3 1 0.5 0.5];
dvs = [0.18 0.45 0.82 1.03 4.28 5.39];

figure;
for w = [0.2 0.5 0.91 1.15 4.77 6.01]./1000 %m
    %% Processing Images
    
    [x,inten] = intensity_profile(j);
    
    subplot(3,2,j)
    plot(x,inten,'r','linewidth',3);
    hold on;
    xlim([-1 * scales(j),1 * scales(j)]);
    hold on;
    
    %% Generating Theoretical Models
    x = linspace(-0.01 * scales(j),0.01 * scales(j),1000);
    
    integrals = c_int( sqrt(k./(pi().*z)) .* (x + (w/2))) - c_int( sqrt(k./(pi().*z)) .* (x - (w/2))) + i .* s_int( sqrt(k./(pi().*z)) .* (x + (w/2))) - i .* s_int( sqrt(k./(pi().*z)) .* (x - (w/2)));
    
    E_fresn = abs(1 .* sqrt(-i/2) .* exp(i .* k .* z) .* integrals);
    E_fraun = sqrt(2*z * (pi() * k)^-1) .* x.^-1 .* sin( w .* k .* x .* (2 * z)^-1);
    
    Es_fresn = E_fresn .^ 2;
    Es_fraun = E_fraun .^ 2;
    
    
    plot(x.*100,Es_fresn,'g','linewidth',3);
    hold on;
    plot(x.*100,Es_fraun,'b','linewidth',2);
    hold on;
    xlabel('X position on Screen (cm)');
    ylabel('E^2 (proportional to Intensity)');
    title(strcat('Diffraction Intensity Comparison, Slit Width: ',num2str(w.*1000),'mm',' - \Delta v: ',num2str(dvs(j))));
    legend('Experimental Result','Fresnel Model','Fraunhofer Model');
    hold off;
    j = j+1;
end

function [x,inten] = intensity_profile(test_num)
    
    % Fitting Parameters
    vsf = [0.01 0.015 0.03 0.55 1.8 1.8];
    hsf = [0.35 0.25 0.2 0.2 0.15 0.2];
    hshift = [0 0 -0.07 0 0 0];
    
    name=strcat('snap_',num2str(test_num),'.jpeg');
    
    % Reading Image
    I = imread(name);
    
    % Converting to Greyscale
    I_grey = imadjust(rgb2gray(I));
    
    inten = zeros(size(I_grey,2),1);
    j = 1:size(inten,1);
    middle = round(size(I_grey,1)./2,0);
    dE = 5;
    %inten(j) = sum(I_grey(:,j)) ./ (size(I_grey,1));
    inten(j) = sum(I_grey(middle-dE:middle+dE,j)) ./ 11;
    x = linspace(-10.*hsf(test_num),10.*hsf(test_num),size(inten,1));
    x = x + hshift(test_num);
    inten = inten .* vsf(test_num).* 255^-1;
end
    
function c = c_int(x)
    c = zeros(1,size(x,2));
    for i = 1:size(x,2)
        fun = @(t) cos( (pi()*t.^2)./2 );
        c(i) = integral(fun,0,x(i));
    end

end

function s = s_int(x)
    s = zeros(1,size(x,2));
    for i = 1:size(x,2)
        fun = @(t) sin( (pi()*t.^2)./2 );
        s(i) = integral(fun,0,x(i));
    end

end