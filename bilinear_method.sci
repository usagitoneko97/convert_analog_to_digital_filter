clear()
A = [1, 1]; 
f = [20, 200, 2000]; 
angle = [0, 0, 0]; 
p = [2/15, 6/15, 18/15]; 
t1 = 0:0.00001:0.07; //p is number of input for display 
t2 = 0:0.00001:0.07; 
t3 = 0:0.00001:0.07; 
//for display only 
xl = A(1)*cos(2*%pi*f(1)*t1 + angle(1)); 
yl = A(2)*cos(2*%pi*f(2)*t2 + angle(2)); 
z1 = A(2)*cos(2*%pi*f(3)*t3 + angle(3)); 
xyl = (xl+yl)/2; 
xz1 = (xl+z1)/2; 
yzl = (yl+z1)/2; 
xyzl = (xl+yl+z1)/3; 
subplot(4,2,1), plot(t2, xyl), title('xy(t)'), xlabel('t2(s)'); 
subplot(4,2,2), plot(t2, xyzl), title('xyz(t)'), xlabel('t2(s)'); 
subplot(4,2,3), plot(t2, yzl), title('yz(t)'), xlabel('t2(s)'); 
subplot(4,2,4), plot(t2, yl), title('y(t)'), xlabel('t2(s)'); 
subplot(4,2,5), plot(t2, xl), title('x(t)'), xlabel('t2(s)');
subplot(4,2,6), plot(t2, z1), title('z(t)'), xlabel('t2(s)'); 

wn = 2*%pi*1000
dampratio = 1
s = poly(0, "s");
Hs = s^2 / (s^2 + 2*dampratio*wn*s + wn^2)
disp(Hs)
h_lin = syslin('c', Hs)
clf();bode(h_lin, 0.01, 30000)
//bilinear
slss=tf2ss(h_lin);  //Now in state-space form
sl1=cls2dls(slss,1/80000);  //sl1= output of cls2dls
sl1t=ss2tf(sl1) // Converts in transfer form

disp(sl1t)
number = 0:0.001:1
z = exp(%i*%pi*number)
tz = (0.9258557 - 1.8517114*z + 0.9258557*z.^2) ./(0.8545669 - 1.8488558*z + z.^2)
clf();plot(number, 20 * log(abs(tz)))

ld_bil = ldiv(sl1t.num, sl1t.den, 2500)
//clf();plot(1:length(ld_bil), (ld_bil))
convd_bil = conv(ld_bil, xyzl)
//clf();subplot(2,1,1), plot(1:length(convd_bil), convd_bil)
//subplot(2,1,2), plot(t2, xyzl), title('xyz(t)'), xlabel('t2(s)'); 
//--------
