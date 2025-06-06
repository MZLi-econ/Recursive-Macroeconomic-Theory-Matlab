function t=ptime(start,nobs,freq);
%PTIME   Generation of vector of dates.
%        t=ptime(start,nobs,freq) generates a nobs x 1 vector of dates
%        that can be used, for example, as the time axis in plotting
%        time series.  "Start" is a real number or integer representing
%        the date of the first sample point and "freq" is the frequency
%        of the time series.  Therefore, 
%
%            if freq=                then start =
%            --------                ------------
%             1 (annual)             Y     Y= integer  (i.e. 1948)
%             4 (quarterly)          Y.Q,  Q=1,2,3, or 4
%            12 (monthly)            Y.M,  M=01,02,...,12
%
mult=10^(round(freq/6));
re=round(mult*(start-fix(start)));
t=fix(start) + ( [0:nobs-1]' + (re~=0)*(re-.5) )/freq;
