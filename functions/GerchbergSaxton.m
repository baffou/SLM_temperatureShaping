%% Gerchberg Saxton algorithm
% Guillaume Baffou & Ljiljana Durdevic
% 28 March 2018 - Institut Fresnel, CNRS, Marseille (France)
% Nanoscale 6, 8984 - 8989 (2014)





function hologram=GerchbergSaxton(Target)

[Ny, Nx]=size(Target);

%Source=Target*0+1;    % Profile of the laser impinging on the SLM. 1 for uniform.

Ny2=Ny/2;
Nx2=Nx/2;

r2=(min([Nx/2,Ny/2]))^2;


[xx, yy]=meshgrid(-Nx2+1/2:Nx2-1/2,-Ny2+1/2:Ny2-1/2);
rr2=xx.*xx+yy.*yy;
Source=rr2<r2;

A=fftshift(ifft2(fftshift(Target)));  %Fourier

for i=1:10
    B = abs(Source) .* exp(1i*angle(A));  %Fourier
    C = fftshift(fft2(fftshift(B)));      %Real space
    D = abs(Target) .* exp(1i*angle(C));
    A = fftshift(ifft2(fftshift(D)));
end
hologram=A;

%%

B = abs(Source) .* exp(1i*angle(hologram));  %Fourier
C = fftshift(fft2(fftshift(B)));      %Real space

figure

subplot(1,2,1)
imagesc(angle(hologram))
title('Phase image to be sent to the SLM');
colormap(gca,hsv)
colorbar
axis image;

subplot(1,2,2)
imagesc(abs(C))
title('Intensity profile in the imaging plane');
colormap(gca,parula)
colorbar
axis image;


fprintf('Done\n')


