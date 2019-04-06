function [wwwldata]=winwidth(data)
% WINWIDTH adujusts the window widthlevel of a CT dataset to view lung.
%
% Function: winwidth.m
%
% Purpose:
%
% This function adjusts the intensity of the CT values in a given data
% array to enhance the visualization of the lung anatomy.  The window width
% and window level values for the Lung Window are hard coded in the
% function.
%
%   Date        Programmer        Description of change
%   ===================================================
%   10/20/09    Olga A. Imas      Original code
%   11/01/10    Olga A. Imas      Converted to stand alone function
%
% Input variables
%
%  data          ----- MxN image dataset
%  
% Output variables
%
%  wwwldata      ----- MxN image dataset with rescaled intensity values
%   
%
%
% Define preset window width and window level values (set intensity range)
wl=-498; %window level to enhance lung anatomy
ww=1465; %window width to enhance lung anatomy
L=wl-ww/2; %calculating lower limit for intensity
U=wl+ww/2; %calculating upper limit for intensity

idata=double(data); %raw data conversion to double from INT16
%clip intensities outside window
idata(idata<L)=0;
idata(idata>U)=255;
minL=-min(idata(:));
%add intercept for linear rescaling
idata=idata+minL;
mxL=max(idata(:));
%calculate slope for linear rescaling
slope=255/mxL;
%convert to new scale for visualization
wwwldata=uint8(slope*idata);
end
