% ----------------------------
%  Pseudo radial k-space trajectory
%  For MR Solutions custom 3D k-space
%
%  Gustav Strijkers
%  Feb 2020
%  
% ----------------------------

%% clear all

clc;
clearvars;
close all force;


%% Initialization

outputdir = pwd;

dimy = 64;
dimz = 64;


tiny_golden_angles = [111.24611, 68.75388, 49.75077, 38.97762, 32.03967, 23.62814, 20.88643, 18.71484, 16.95229];
angle_nr = 1;

%% fill the list

ry = round(dimy/2)-0.5;
rz = round(dimz/2)-0.5;
step = 1/max([dimy, dimz]);
radius = max([dimy, dimz]);
number_of_spokes = max([dimz,dimy])*2;
angle = 0;
kspacelist=[];

for ns = 1:number_of_spokes
    
    nr=1;
    clear c;
    for i=-1:step:1-step
        
        c(nr,:) = [floor(ry * i * cos(angle*pi/180)),floor(rz * i * sin(angle*pi/180))];
        nr = nr + 1;
        
    end
    
    c = unique(c,'Rows','Stable');
    
    kspacelist = [kspacelist;c];
    
    angle = angle + tiny_golden_angles(angle_nr);
end



%% export matrix

kspacelist = kspacelist(1:dimy*dimz,:);
disp(length(kspacelist))

filename = strcat(outputdir,filesep,'Radial_trajectory_dimy=',num2str(dimy),'_dimz=',num2str(dimz),'_angle=',num2str(tiny_golden_angles(angle_nr)),'.txt');
fileID = fopen(filename,'w');

for i = 1:length(kspacelist)
   
    fprintf(fileID,num2str(kspacelist(i,1)));
    fprintf(fileID,',');
    fprintf(fileID,num2str(kspacelist(i,2)));
    fprintf(fileID,',\n');
    
end

fclose(fileID);



%% Display the trajectory

figure;
plot1 = scatter(kspacelist(1,1),kspacelist(1,2),'s');

for i=1:length(kspacelist)
    plot1.XData = kspacelist(1:i,1); 
    plot1.YData = kspacelist(1:i,2); 
    pause(0.000001);
    
end


