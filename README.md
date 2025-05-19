# Two-line Elements to Classical Orbital Elements and Date
TLE_to_COE_and_t0 function reads the TLE file involving the TLE data and converts this TLE data to classical orbital elements (COE) and the initial time.

Output of the function is the classical orbital elements (specific angular momentum, inclination, right ascension of the ascending node, eccentricity, argument of perigee, true anomaly), the year of TLE epoch, the day for the TLE epoch with its day fraction, the mean anomaly and the mean motion.

The default input for the function is the text file "tle.txt" involving the two-line element data.

For the output, all angular quantities are in radians. 

There is no need for a user defined M-function or subfunction.
