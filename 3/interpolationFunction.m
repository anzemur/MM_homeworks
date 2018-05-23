function Z = interpolationFunction(data, len)
%Z = interploatioinFunction(data, len) je funkcija, ki na enakomerno razporejeni
%mrezi tock dimenzije len x len izracuna vrednosti interpolacijske funkcije f.
%Vhodni parametri:
%data -> vsebuje 12 potrebnih podatkov za izracun interpolacijske funkcije f.
%data = [a, b, c, d, a_x, b_x, c_x, d_x, a_y, b_y, c_y, d_y]
%len -> stevilo, ki pove na koliko manjsih kvadratov razdelimo enotski kvadrat
%       ter kako natancna/zglajena naj bo interpolacija
  
%funkcija za izracun polinoma ki ustreza pogojem:
% p(0) = 1
% p'(0) = 0
% p(1) = 1
% p'(1) = 0
p = @(x) 2*x^3 - 3*x^2 + 1;
  
%preberemo podatke iz data
a = data(1);
b = data(2);
c = data(3);
d = data(4);
  
a_x = data(5);
b_x = data(6);
c_x = data(7);
d_x = data(8);
  
a_y = data(9);
b_y = data(10);
c_y = data(11);
d_y = data(12);
  
%funckije za izracun utezi
W_A = @(x, y) p(x)*p(y);
W_B = @(x, y) (1 - p(x))*p(y);
W_C = @(x, y) p(x)*(1 - p(y));
W_D = @(x, y) (1 - p(x))*(1-p(y));
  
%funckije za izracun pomoznih funckij
f_A = @(x, y) a + a_x*x + a_y*y;
f_B = @(x, y) b + b_x*(x - 1) + b_y*y;
f_C = @(x, y) c + c_x*x + c_y*(y - 1);
f_D = @(x, y) d + d_x*(x - 1) + d_y*(y - 1);
  
%interpolacijska funkcija f
f = @(x, y) f_A(x, y)*W_A(x, y) + f_B(x, y)*W_B(x, y) + f_C(x, y)*W_C(x, y) + f_D(x, y)*W_D(x, y);
   
x = 0;
y = 0;  
  
iter = 1/(len-1);

for idV = 1 : len
  x = 0;
    
  for idS = 1 : len 
    Z(idV, idS) = f(x, y);
      
    x = x + iter;
  endfor
    
  y = y + iter;
    
endfor

%!demo
%! data = [1, 5, 5, 1, 0.4, 0.2, 0.4, 0.2, 0.2 ,0.4 ,0.2, 0.4]; 
%! len = 20;

%! figure(1)
%! surf([1, 5; 5, 1,])

%! Z = interpolationFunction(data, len);
%! figure(2)
%! surf(Z);

endfunction



      
    
  