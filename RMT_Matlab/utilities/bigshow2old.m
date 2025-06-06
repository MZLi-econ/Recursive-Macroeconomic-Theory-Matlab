function z = bigshow2(varargin)
%  function z = bigshow2 (num,den,tsim,timpulse,tcov,tspec)
% program to compute impulse response, spectrum, covariogram
% and realization of scalar process
% den(L) y_t = num(L) e_t 
% where e_t is a white noise.  
%   e.g.,   num=[1 0];den=[1 -.9];
% The order of the denominator must EQUAL the order of
% the numerator.  Pad out with zeros to get this satisfied,
%  e.g., num=[1 .5]; den=[1 0]; for a first order pure m.a. process.
%  tspec is  number of ordinates in spectrum
%  timpulse is number of points in impulse response function 
%  2*tcov is number of points plotted in covariogram
%  tsim is size of sample path plotted
%  If there are only two inputs (num, den), then the remaining parameters
%  are set at default values.  
%  red1.m uses this program to generate graphs for chapter 1 of RMT
if nargin < 2 || nargin >6
   error ('Error.  Wrong number of input arguments.')
else
   if nargin == 6
      tspec = varargin{6};
   else
      timpulse =128;
   end

   if nargin >= 5
      tcov = varargin{5};
   else
      tsim = 15;
   end
   
   if nargin >= 4
      timpulse = varargin{4};
   else
     timpulse = 30;
   end
   
   if nargin >= 3
     tsim = varargin{3};
   else
      tsim = 90;
   end

  num = varargin{1};
   den = varargin{2};
end

MM = tcov; 
TT = tsim;
M = timpulse;
N = tspec;
sys4 = tf(num,den,1)  % define the system
%    get impulse response function
M=30;  % length of impulse response function.  We might want to
      % make this a parameter in a function.
yi=impulse(sys4,M);
subplot(2,2,1)
stem(0:M,yi),title('impulse response')
% now compute spectrum
%  set the ordinates
% must space the w's correctly to get the inversion formula
N=128; NN=N/2;   % Make N a parameter, the number of ordinates in spectrum
tt=0:N-1;  
w=2*pi.*tt/N;
h4=freqresp(sys4,w);
hh4=squeeze(h4);   %  same as hh3=reshape(h3,1,100)
spect=hh4.*conj(hh4);
subplot(2,2,2);
semilogy(w(1:NN+1)',spect(1:NN+1)),title('spectrum')
axis([0 pi -inf inf])
% now compute covariance function
cov=ifft(spect);  % This wraps around.  Must unwrap it as follows
MM=15;  %  Set MM << NN. MM determines how many covariances are plotted
jj=-MM:1:MM
ccov=[cov(N-MM+1:1:N)' cov(1:MM+1)'];
ccov=real(ccov)
subplot(2,2,3)
stem(jj',ccov')
axis([-MM MM min(ccov) inf]),title('covariogram')
TT=90;  %  Size of sample path 
u=randn(5*TT,1);
y=lsim(sys4,u);
subplot(2,2,4)
plot(y(4*TT+1:5*TT)), title('sample path')
axis([1 TT -inf inf])