
%% Calculation of the HSD map from an imported B&W image.
%% Meant to create uniform temperature profiles.
% Guillaume Baffou 28/03/2018 -Institut Fresnel, CNRS, Marseille (France)

function Qmap=importImage(fileName,smooth)

% fileName: a string that corresponds to the file Name of the image to be
%     imported. It can be in B&W, rgb, jpg, bmp, png, ...
% smooth  : Gaussian smoothing factor. By default, 1.

if nargin~=3
    smooth=1;
end


%% importation of the image

IM=double(imread(fileName));

dim=length(size(IM));
maxVal=max(IM(:));
if dim==3
    IM=(IM(:,:,1)+IM(:,:,2)+IM(:,:,3))/3;
end

% processing of the image so that the pixel values are 0 or 1.

IM=IM-maxVal;
IM=-IM;
IM=round(IM/maxVal);

figure,imagesc(IM)
title('Target uniform temperature profile')
axis image;

%% processing of the laser beam profile

[Ny, Nx]=size(IM);
n=0;
Nx2=Nx/2;
Ny2=Ny/2;

for x=-Nx2+1/2:1:Nx2-1/2
    for y=-Ny2+1/2:1:Ny2-1/2
        ix=x+Nx2+1/2;
        iy=y+Ny2+1/2;
        if IM(iy,ix)~=0
            n=n+1;
            Tline(n)=IM(iy,ix);
            rx(n)=x;
            ry(n)=y;
        end
    end
end

AA=zeros(n,n);

for n1=1:length(rx)
    for n2=1:length(rx)
        AA(n1,n2)=1/sqrt((rx(n1)-rx(n2))^2+(ry(n1)-ry(n2))^2);
    end
end

for n=1:length(rx)
    AA(n,n)=2;
end

Qline=AA\Tline';

Qmap=zeros(size(IM));
for n=1:length(rx)
	Qmap(ry(n)+Ny2+1/2,rx(n)+Nx2+1/2)=Qline(n);
end

Qmap=imgaussfilt(Qmap,smooth);

figure,imagesc(Qmap)
axis image;
title('Laser beam profile')
dlmwrite('Qmap.txt',Qmap,' ')

%% calculation of the resulting T map
% (optional part, just to have an idea
% of the final 2D temperature profile)

NxBig=2*Nx;
NyBig=2*Ny;
QmapBig=zeros(NyBig,NxBig);

QmapBig(floor(Ny2+1:Ny2+Ny),floor(Nx2+1:Nx2+Nx))=Qmap;

rBigx=ones(NyBig,1)*(-Nx+1/2:1:Nx-1/2);
rBigy=(-Ny+1/2:1:Ny-1/2)'*ones(1,NxBig);

Green=1./sqrt(rBigx.^2+rBigy.^2);

TmapBig=conv2(Green,QmapBig);
TmapAll=TmapBig(Ny+1:Ny+NyBig,Nx+1:Nx+NxBig);

figure,imagesc(TmapAll)
axis image;
title('Temperature profile')

dlmwrite('Tmap.txt',TmapAll,' ')
dlmwrite('Tprofile.txt',TmapAll(Ny,:),'\n')
dlmwrite('Qprofile.txt',QmapBig(Ny,:),'\n')
dlmwrite('r.txt',(-Ny+1:Ny-1)')



