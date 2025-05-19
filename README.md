# TLE_to_COE_and_t0
TLE_to_COE_and_t0 function reads the TLE file involving the TLE data and converts this TLE data to classical orbital elements (COE) and the initial time.

Output of the function is the classical orbital elements (specific angular momentum, inclination, right ascension of the ascending node,
eccentricity, argument of perigee, true anomaly), the year of TLE epoch, the day for the TLE epoch with its day fraction, the mean anomaly and the mean motion.

For the output, all angular quantities are in radians.

The variables are:
  coe0             - Classical orbital elements [h,i,Omega,e,omega,theta]
                     of the TLE data
  year             - Year for the TLE epoch
  day              - Day with its fraction for the TLE epoch
  Me               - Mean anomaly of the TLE epoch
  n                - Mean motion of the TLE data
  Observation_Site - Involves east longitude, latitude and altitude of
                     the observation site
  date             - Date of the instant
  UT               - Universal time of the instant
  EL               - East longitude of the observation site in degrees
  Lat              - Latitude of the observation site in degrees
  lstOS            - Sidereal time of the observation site in degrees
  H                - Altitude of the observation site in km

User M-function required : None
User subfunction required: None
