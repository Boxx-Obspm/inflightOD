%%----------------HEADER---------------------------%%
%Author:           Boris Segret
%Version & Date:
%                  V.1.3, 15-03-2016 (dd/mm/yyyy)
%                  - REMAINING ISSUES: duration of the day must be sideral (86140s) or earthling (86400s)?
%                  - only extracts observational dates according to a "test" strategy
%                  V. 1.2, 03-03-2016, Boris Segret, as "time_step.m"
%                  - for clarifications only
%                  until V1, 11-09-2015, by Tristan Mallet
%CL=1
%
%
% Produces <Nobs> epochs that will be considered for the observations for 1 computation
%
% 1.Inputs:
%    Nobs : Nb.of observation epochs to be output for OD computation
%    et0  : current date on the actual trajectory -in Julian Dates)
%    TS   : Nx2 matrix, Nx(MJD_day, seconds_in_day), dates where the measurement sampling changes
%    dt   : (N-1)x3 matrix, with dt1, dt2, dt3, intervals (in hours) between measurements after "ii"
%
% 2.Outputs:
%    epochs : Nobs-vector in decimal Julian Days (at ii, ii+dt1, ii+dt1+dt2, ii+dt1+dt2+dt3)


function epochs = slctEpochs (Nobs, et0, TS, dt)
epochs = double(zeros(1,Nobs));
MJD_0=2400000.5;
SEC_0=86400.;

% T: conversion of TS (VTS format) into decimal Julian Day
T=TS(:,1)+MJD_0+TS(:,2)/SEC_0;
for k = 1:length(T)-1 % The size of T (number of sampling changes can be edited).
		if (et0 < T(1))
			timeStep=dt(1,:)/SEC_0*3600.;
			break;
		elseif (et0<T(k+1) && et0>=T(k))
			timeStep=dt(k,:)*3600./SEC_0;
			break;
		else
      timeStep=dt(k+1,:)*3600./SEC_0;
    end
end

  epochs(1) = et0;
  epochs(2) = epochs(1) + timeStep(1);
  epochs(3) = epochs(2) + timeStep(2);
  epochs(4) = epochs(3) + timeStep(3);  
end