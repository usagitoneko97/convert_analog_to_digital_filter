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

// s transfer function
wn = 2*%pi*500
dampratio = 1
s = poly(0, "s");
Hs = s^2 / (s^2 + 2*dampratio*wn*s + wn^2)
disp(Hs)
h = syslin('c', Hs)
clf();bode(h, 0.01, 30000)
//--------------
// pole-zero mapping
// 2 roots for den
s_den_root1 = -3141.593- %i*0.147
s_den_root2 = -3141.593+ %i*0.147
z_den_1 = exp(s_den_root1 * (1/80000))
z_den_2 = exp(s_den_root2 * (1/80000))
number = 0:0.001:1
z = exp(%i*%pi*number)
ztf = ((z-1).*(z-1))./((z-z_den_1) .* (z-z_den_2))
k = 1 / max(abs(ztf))
ztfk = ztf * k
clf();plot(number, 20 * log(abs(ztfk)))
z = poly(0, 'z')
ztf = ((z-1)*(z-1))/((z-z_den_1) * (z-z_den_2)) * k
ld = ldiv(ztf.num, ztf.den, 250);
//clf();plot(1:length(ld), (ld))
convd = conv(ld, xyzl);
clf();subplot(2,1,1), plot(1:length(convd), convd)
subplot(2,1,2), plot(t2, xyzl), title('xyz(t)'), xlabel('t2(s)'); 
