%% Typical main program to pilot an SLM and generate arbitrary temperature
%% profiles via a microscope.

% Guillaume Baffou & Ljiljana Durdevic
% CNRS - Institut Fresnel, Marseille (France)
% 26 August 2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1a- Fabrication of the profile of the laser beam meant to create
% a predefined temperature distribution, here a uniform disc.

    %Qmap=uniformSquare(100,100,20,1);



% 1b- an alternative approach consists in using a jpg or bmp B&W image.
% What is black is what is supposed to be hot (see the example file)
    Qmap=importImage('S.jpg',1);


% 2- Computation of the phase profile to be sent to the SLM to create the
% above-calculated light profile at the sample plane.

    hologram=GerchbergSaxton(Qmap);

