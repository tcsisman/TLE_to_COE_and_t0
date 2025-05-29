function [coe, year, day, Me, n] = TLE_to_COE_and_t0(file_name)
%{
  TLE_to_COE_and_t0 function reads the TLE file involving the TLE data and
  converts this TLE data to classical orbital elements (COE) and the
  initial time.

  Output of the function is the classical orbital elements (specific
  angular momentum, inclination, right ascension of the ascending node,
  eccentricity, argument of perigee, true anomaly), the year of TLE epoch,
  the day for the TLE epoch with its day fraction, the mean anomaly and the
  mean motion.

  For the output, all angular quantities are in radians.

    coe              - Classical orbital elements [h,i,Omega,e,omega,theta]
                       of the TLE data
    year             - Year for the TLE epoch
    day              - Day with its fraction for the TLE epoch
    Me               - Mean anomaly of the TLE epoch
    n                - Mean motion of the TLE data
    
  User M-function required : None
  User subfunction required: None

%} 

% Reading the TLE file tle.txt. To create a proper tle.txt file, obtain 
% the TLE data from space-track.org, and then simply copy and paste it
% to tle.txt file.
% In the below part, the first line of the TLE data is read as Line 1 cell
% array, and the second line fo the TLE data is read as Line 2 cell array.
if nargin == 1
    fileID = fopen(file_name);
else
    fileID = fopen('tle.txt');
end
Line1 = textscan(fileID,'%d %s %s %f %f %f %f %f %f %f %f',1);
Line2 = textscan(fileID,'%d %d %f %f %f %f %f %f %f',1);
fclose(fileID);


% In the below part, the numerical data that is relevant to define the 
% state of the satellite and to propagate the orbit are extracted from the
% TLE data read. Note that all the angular quantities are converted to
% radians.
degToRad = pi/180.0;

epoch = Line1{4};
ndot = 2.0*Line1{5};
ndoubledot = 6.0*Line1{6}*10.^Line1{7};
Bstar = Line1{8};
i = Line2{3}*degToRad;
Omega = Line2{4}*degToRad;
e = Line2{5}/10.^7;
omega = Line2{6}*degToRad;
Me = Line2{7}*degToRad;
if isempty(Line2{9})
    n = str2double(num2str(Line2{8},10))*2.0*pi/(24.0*3600.0);
else
% Mean motion in rad/s unit    
    n = Line2{8}*2.0*pi/(24.0*3600.0);
end

% Determining the classical orbital elements, that are h, i, Omega, e, 
% omega, theta, out of TLE data. Note that i, Omega, e, and omega are
% readily read by the TLE file. The h and theta values are obtained from
% the n and Me values, respectively.

% The gravitational parameter mu in units of km^3/s^2:
mu = 398600;

% Obtaining h from n:
h = (mu^2/n)^(1/3)*sqrt(1-e^2);

% Obtaining theta from Me by solving Kepler's equation:
KeplerEqn = @(E) E - e*sin(E) - Me;
E = fzero(KeplerEqn,pi);
if tan(E/2.0)<0
    theta = 2.0*atan(sqrt((1+e)/(1-e))*tan(E/2.0)) + 2.0*pi;
else
    theta = 2.0*atan(sqrt((1+e)/(1-e))*tan(E/2.0));
end

% Epoch represents the Universal Time (solar time at Greenwich). Below, the
% epoch is first converted to the year, the day of the year with its day
% fraction. Then, the day is converted to month and day of the month.
% Finally, the day fraction is converted to the time in day as hour, 
% minutes, and seconds.
year    = 2000 + (epoch - mod(epoch,1000))/1000;
day     = mod(epoch,1000);

datetime        = datetime(year, 1, 1) + days(day - 1);
month           = month(datettime);
day_of_month    = day(datetime);

time    = day - mod(day,1);
hour    = time*24;
min     = time*24*60 - time*24;
sec     = time*24*3600 - time*24*60;

% Classical orbital elements. Note that the unit of the mean motion is
% rad/s and all angles are in radians.
coe = [h, i, Omega, e, omega, theta];

end % TLE_to_COE_and_t0