% ---------------------------------------
%     2DFFT for Velocity Ddetection
%
% Author : Lin Junyang @ 2021
% A simulation of CW wave, 
% 2DFFT for velocity detection.
% ---------------------------------------
% Velocity Result of 2DFFT:
% maxima indexs at the 2 Dimensions
% 1st Dimension - coarse velocity
% 2nd Dimension - fine velocity
% ---------------------------------------

clear; clc; %close all

fs = 2.5e6;     % IF sample rate
f0 = 77e9;      % RF wave frequency
lambda = 3e8/f0;   % RF wave length
c = 3e8;    % Light Speed

tc = 1e-3;  % 1ms per chirp.
ts = 0:1/fs:1023/fs;   % smaple time, 1024 points.
chirp_phase_aligned = 1;  % set to 0 or 1, wave start phase of each chirp is aligned or continous.

v = 12;   % target velocity, m/s
f = 2*f0*v/c;   % doppler freq 

s = zeros(1024,32);   % 32 chirps
for k = 1:32
    % 2*v*tc*(k-1)/lambda*2*pi -- extra phase due to chirps start time
    s(:,k) = exp(1j*(f*tc*(k-1)*2*pi*(1-chirp_phase_aligned) + 2*pi*f*ts + 2*v*tc*(k-1)/lambda*2*pi));   
end

ft2 = (fft2(s));   % 2DFFT

figure
imagesc(abs(ft2(1:8,:)))

