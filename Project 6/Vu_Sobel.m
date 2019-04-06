function [outputImage] = Vu_Sobel(inputImage)
%Vu_Sobel Applies the Sobel Edge Filter to the image.
%
%Function: Vu_Sobel
%
%  Purpose: The Sobel Edge Filterm or Sobel Filter, where the algorithim
%  emphasizes edges.
%Date        Programmer        Description of change
%   ===================================================
%   5/20/16    Khang M. Vu     Original code
%  
%
% Input variables
%
%  inputImage       ----- MxN image dataset
%  
% Output variables
%
%  outputImage      ----- MxN image dataset with Sobel Filter applied
%
K1=[-1 0 1;-2 0 2;-1 0 1;];
K2=K1';
outputImage=sqrt((conv2(double(inputImage),double(K1))).^2+...
    (conv2(double(inputImage),double(K2)).^2));
end

