# SLM_temperatureShaping
Matlab package
https://github.com/baffou/SLM_temperatureShaping
© GNU General Public License (GPL)

####################################################
Invertion, and Gerchberg Saxton algorithms
to create the leaser beam profile
suited to generate a predifined temperature profile.
####################################################

Developed by
Guillaume Baffou and Ljiljana Durdevic (2018)
CNRS, Institut Fresnel (France)

in the context of these two articles:

[1] Deterministic Temperature Shaping using Plasmonic Nanoparticle Assemblies
    G. Baffou, E. Bermúdez Ureña, P. Berto, S. Monneret, R. Quidant and H. Rigneault
    Nanoscale 6, 8984-8989 (2014)

[2] Microscale Temperature Shaping Using Spatial Light Modulation on Gold Nanoparticles
    L. Durdevic, H. M. L. Robert, B. Wattellier, S. Monneret, G. Baffou
    Scientific Report 9, 4644 (2019)

Tested on Matlab 2016, 2021, and 2022.

Expected run time for demo on a "normal" desktop computer: 4 seconds

Working procedure:
    No installation is required. Just run the main.m file using Matlab.
    The image 'S.bmp' in the 'ExampleData' folder is automatically used, as an example.
    Using an inversion algorithm [1], the code computes the laser beam profile required to create a temperature field that mimics the content of the bmp image, with the following convention: non-1 value are were the temperature needs to be set, with 0 the maximum temperature. And pixels with a value of 1 is were the temperature is not set. In the example image 'S.bmp', a uniform temperature is to be set over the S area, and let diffuse outside.
    From the laser beam profile, the code computes [2] then the phase pattern to be set in the back focal plane of the objective to produce the desired, calucated laser beam profile at the image plane. This phase pattern has to be sent to the SLM, conjugated with the back focal plane of the objective.

    To define a desired temperature profile, the user can follow one of these two approaches:
    1. Instead of the S.bmp image, the user can import any jpg or bmp monocolor image.
    2. The user can use the function 'uniformSquare.m' or 'uniformDisc.m' to generate temperature profile that are uniform respectively over a square or a disc.