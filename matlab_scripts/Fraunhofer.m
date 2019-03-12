% 

lambda = 6.328e-7;
k = (2*pi())/lambda;
z = 3.93;


x = linspace(-0.01,0.01,1000);
i = 1;
figure;
for w = [0.2 0.5 0.91 1.15 4.77 6.01]./1000 %m
    
    E = sqrt(2*z * (pi() * k)^-1) .* x.^-1 .* sin( w .* k .* x .* (2 * z)^-1);
    E_square = E.^2;
    
    subplot(2,3,i)
    plot(x.*100,E_square);
    hold on;
    xlabel('X position on Screen (cm)');
    ylabel('E^2 (proportional to Intensity)');
    title(strcat('Theoretical Fraunhofer Slit Width:',num2str(w)));
    hold off;
    i = i+1;
end