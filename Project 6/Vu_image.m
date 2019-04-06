clear; close all; clc;
%Vu_image loads, processes, and display images. The programw will also
%display patient and image information from the DICOM file.

%   Date        Programmer        Description of change
%   ===================================================
%   5/20/16     Khang M. Vu       Coded Original Version

%The program will load file 'i97273.CTDC.78' from the workspace and display
%a image that has been rescaled and processed and another image that has
%gone through another filter. It will also display patient age, study
%description, hospital name, imaging device manufacturer, the rescaling
%slope and intercept as well as the width and height of the image in pixels
%Finally, the program will export the relevant information into an excel
%file

%Program Reads the Image and Header data from the DICOM file.
CTimg=dicomread('i97273.CTDC.78');
header=dicominfo('i97273.CTDC.78');

%Image is rescaled using information provided in the DICOM header.
CTimg=header.RescaleIntercept+header.RescaleSlope*CTimg;

%Displays image rescaling slope and intercepts
fprintf(['The image was rescaled with a slope of %0.0f and'...
  ' an intercept of %0.0f\n'],header.RescaleSlope,header.RescaleIntercept);

colormap(gray); %Sets grayscale
CTimg=winwidth(CTimg); %Proccesses image using winwidth
%Displays image
figure(1);
subplot(2,1,1);
imagesc(CTimg);
title('No Sobel Edge Filter');

CTimg=Vu_Sobel(CTimg); %Sobel Edge Filter used
subplot(2,1,2);
imagesc(CTimg);
title('Sobel Edge Filter Applied');

%Patient and Image data displayed
disp('CT Image');

disp(['Patient Age: ',header.PatientAge]);
disp(['Study Description: ',header.StudyDescription]);
disp(['Hospital Name: ',header.InstitutionName]);
disp(['Imaging device manufacturer: ',header.Manufacturer]);
disp(['Width in Pixels: ',num2str(header.Width)]);
disp(['Height in Pixels: ',num2str(header.Height)]);

%Patient and Image data is organized into a cell then exported to an excel
%file
outcell{1,1}='Patient Age';
outcell{2,1}='Study Description';
outcell{3,1}='Hospital Name';
outcell{4,1}='Imaging Device Manufacturer';
outcell{5,1}='Width in Pixels';
outcell{6,1}='Height in Pixels';

outcell{1,2}=header.PatientAge;
outcell{2,2}=header.StudyDescription;
outcell{3,2}=header.InstitutionName;
outcell{4,2}=header.Manufacturer;
outcell{5,2}=header.Width;
outcell{6,2}=header.Height;

xlswrite('Vu_Patient_Out',outcell);