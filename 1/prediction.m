function y = prediction(x, h)
%y = prediction(x, h) je funkcija, ki iz vhodnih podatkov x 
%in vektorja koeficientov h napove izhod y na podlagi našega modela
%x in h sta podana kot vrsticna vektorja
n = length(h);
 
for i = 1:length(x)-n+1;
  A(i ,: ) = x(i : i+n-1);
end

y = A*h';


%!test
%! x=[1 2 3 4 5 6 7 8 9 10];
%! y=[6 9 12 15 18 21 24 27];
%! h=[1 1 1];
%! assert(prediction(x,h),y',eps*10)

%!test
%! x=[2 6 8 3];
%! y=[10 20 19];
%! h=[2 1];
%! assert(prediction(x,h),y',eps*10)
