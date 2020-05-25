%resolution is 1 mm^2
clc
clear
%Provide parameters
FRate = 200;                                    %mm/min (Lamp velocity) (use 200-1000)
Intensity = xlsread('25mm Elevation.xlsx');     %given in mW/cm2 (load intensity profile for desired lamp elevation) 
yMove = 2;                                      %mm (Y-spacing parameter)
bands = 40;                                     %number of X-direction passes

%unit conversion
Velocity = FRate * 0.0166667;                   %mm/s (conversion)
Absorbance = zeros(100,100);                    %mJ/cm2
[xDimension,yDimension] = size(Absorbance);
[xInt,yInt] = size(Intensity);

Absorbance = zeros(100+bands*xInt,100+bands*yInt);

for a = 0:(bands-1)
    for i=1:xDimension
        for j=1:xInt
            for z=1:yInt
                Absorbance(i+j,z+a*yMove)= Absorbance(i+j,z+a*yMove)+ (Intensity(j,z)/Velocity);
            end
        end
    end
end


AbsorbanceGraph = zeros(xDimension,(bands*yMove)+yInt);
for i=1:xDimension
    for j=1:((bands*yMove)+yInt)
        AbsorbanceGraph(i,j) = Absorbance(i,j);
    end
end

surf(AbsorbanceGraph)                         %check graph for uniform illumination absorbance

maxAbsorbance = max(max(AbsorbanceGraph))     %The maximum illumination absorbance
