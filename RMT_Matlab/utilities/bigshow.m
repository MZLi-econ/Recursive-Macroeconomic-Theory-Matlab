function z = bigshow(varargin)
%  function z = bigshow2 (num,den,tsim,timpulse,tcov,tspec)
% program to compute impulse response, spectrum, covariogram
% and realization of scalar process
% den(L) y_t = num(L) w_t 
%  tspec is  number of ordinates in spectrum
%  timpulse is number of points in impulse response function 
%  2*tcov is number of points plotted in covariogram
%  tsim is size of sample path plotted
%  red1.m uses this program to generate graphs for chapter 1 of RMT
if nargin < 2 || nargin >6
   error ('Error.  Wrong number of input arguments.')
else
   if nargin == 6
      tspec = varargin{6};
   else
      tspec = 128;
   end
   if nargin >= 5
      tcov = varargin{5};
   else
      tcov = 15;
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

sys = tf(num,den,1);
yi = impulse(sys,M);

subplot(2,2,1)
stem(0:M,yi),title('impulse response')
NN = N/2;   % Make N a parameter, the number of ordinates in spectrum
tt = 0:N-1;  
w = 2*pi.*tt/N;
h4 = freqresp(sys,w);
hh4 = squeeze(h4);
spect = hh4.*conj(hh4);

subplot(2,2,2);
semilogy(w(1:NN+1)',spect(1:NN+1)),title('spectrum')
axis([0 pi -inf inf])
cov=ifft(spect);  % This wraps around.  Must unwrap it as follows
%MM=15;  %  Set MM << NN. MM determines how many covariances are plotted
jj = -MM:1:MM;
ccov = [cov(N-MM+1:1:N)' cov(1:MM+1)'];
ccov = real(ccov);

subplot(2,2,3)
stem(jj',ccov')
axis([-MM MM min(ccov) inf]),title('covariogram')
u = randn(5*TT,1);
y = lsim(sys,u);

subplot(2,2,4)
plot(y(4*TT+1:5*TT)), title('sample path')
axis([1 TT -inf inf])
z=y;