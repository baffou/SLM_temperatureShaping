
%% Calculation of the HSD map from a predefined T map
% Guillaume Baffou 28/03/2018 -Institut Fresnel, CNRS, Marseille (France)

function Qmap=uniformDisc(Nx,Ny,radius,smooth)

% Nx, Ny: Size of the image, in px.
%         Must be even numbers.
% radius: radius of the uniform-temperature disc, in px.
% smooth: Gaussian smoothing factor. By default, 1.

if nargin~=3
    smooth=1;
end

Tmap=zeros(Ny,Nx);

Nx2=Nx/2;
Ny2=Ny/2;

%% definition of the temperature field over an area of interest
% in this example : uniform temperature = 1 for r < radius.

n=0;
for x=-Nx2+1/2:1:Nx2-1/2
    for y=-Ny2+1/2:1:Ny2-1/2
        if x*x+y*y<radius^2;
            n=n+1;
            ix=x+Nx2+1/2;
            iy=y+Ny2+1/2;
            Tmap(iy,ix)=1;
            Tline(n)=1;
            rx(n)=x;
            ry(n)=y;
        end
    end
end

% determination of the laser beam profile

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

Qmap=zeros(size(Tmap));
for n=1:length(rx)
	Qmap(ry(n)+Ny2+1/2,rx(n)+Nx2+1/2)=Qline(n);
end

Qmap=imgaussfilt(Qmap,smooth);

imagesc(Qmap)
axis image;
dlmwrite('Qmap.txt',Qmap,' ')

%% calculation of the resulting T map
% (optional part, just to have an idea
% of the actual 2D temperature profile)

NxBig=2*Nx;
NyBig=2*Ny;
QmapBig=zeros(NyBig,NxBig);

QmapBig(Ny2+1:Ny2+Ny,Nx2+1:Nx2+Nx)=Qmap;

rBigx=ones(NyBig,1)*(-Nx+1/2:1:Nx-1/2);
rBigy=(-Ny+1/2:1:Ny-1/2)'*ones(1,NxBig);

Green=1./sqrt(rBigx.^2+rBigy.^2);

TmapBig=conv2(Green,QmapBig);

TmapAll=TmapBig(Ny+1:Ny+NyBig,Nx+1:Nx+NxBig);

figure,imagesc(TmapAll)
axis image;
figure,plot(TmapAll(Ny,:))
figure,plot(QmapBig(Ny,:))

dlmwrite('Tmap.txt',TmapAll,' ')
dlmwrite('Tprofile.txt',TmapAll(Ny,:),'\n')
dlmwrite('Qprofile.txt',QmapBig(Ny,:),'\n')
dlmwrite('r.txt',(-Ny+1:Ny-1)')






