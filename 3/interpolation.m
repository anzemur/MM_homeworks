function interpolation(V,len)
%interpolation(V, len) je funkcija, ki sprejme dolzino delitve kvadratov len
%ter matriko V v kateri je predstavljena neka funkcija, ki jo bomo interopolirali.
%Funkcija najprej izrise vhodne podatke nato pa izrise se interpolirano matriko
%vhodne matrike V.

%izris matrike V
figure(1);
surf(V);
title("Vhodna matrika V");

%matrika za shranjevanje interpoliranih vrednosti
out = zeros(length(V)*len - 1 - len);
data = [];

%funkcije za racunanje parcialnih odvodov x in y
df_x = @(x,y) (x-y)/2;
df_y = @(x,y) (x-y)/2;


idRow = 1;
idCol = 1;

iter = 1/len;

for j = 1:length(V) - 1
  idCol = 1;
  
  for i = 1:length(V) - 1

    %v data shranimo a, b, c, d
    data = [V(i,j),V(i+1,j),V(i,j+1),V(i+1,j+1)];
    
              
    %d_x = [d_ax, d_bx, d_cx, d_dx]
    d_x = [0 0 0 0];
    %d_y = [d_ay, d_by, d_cy, d_dy]
    d_y = [0 0 0 0];
    
    
    
    %zgornji levi kot
    if(i == 1 && j == 1) 
        
        d_x = [V(i+1,j) - V(i,j), df_x(V(i,j),V(i+2,j)), V(i+1,j+1) - V(i,j+1), df_x(V(i,j+1),V(i+2,j+1))];
        d_y = [V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];
         
    %spodnji levi kot     
    elseif((i == 1 && j == length(V) - 1)) 
    
        d_x = [V(i+1,j) - V(i,j), df_x(V(i,j),V(i+2,j)), V(i+1,j+1) - V(i,j+1), df_x(V(i,j+1),V(i+2,j+1)) ];    
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j) ];
      
    %zgornji desni kot
    elseif((i == length(V) - 1 && j == 1)) 
    
        d_x = [df_x(V(i-1,j),V(i+1,j)), V(i+1,j) - V(i,j) , df_x(V(i-1,j+1),V(i+1,j+1)), V(i+1,j+1)-V(i,j+1)];
        d_y = [V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];
    
    %spodnji desni kot
    elseif((i == length(V) - 1 && j == length(V) - 1)) 
    
        d_x = [df_x(V(i-1,j),V(i+1,j)), V(i+1,j) - V(i,j), df_x(V(i-1,j+1),V(i+1,j+1)), V(i+1,j+1)-V(i,j+1)];
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j)];
         
    %levi rob     
    elseif(i == 1) 
        
        d_x = [V(i+1,j)-V(i,j), df_x(V(i,j),V(i+2,j)), V(i+1,j+1)-V(i,j+1), df_x(V(i,j+1),V(i+2,j+1))];
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];
   
    %desni rob
    elseif(i == length(V) - 1) 
        
        d_x = [df_x(V(i-1,j),V(i+1,j)), V(i+1,j)-V(i,j), df_x(V(i-1,j+1),V(i+1,j+1)), V(i+1,j+1)-V(i,j+1)];
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];    
        
    %zgornji rob
    elseif(j == 1) 
    
        d_x = [df_x(V(i-1,j),V(i+1,j)), df_x(V(i,j),V(i+2,j)), df_x(V(i-1,j+1),V(i+1,j+1)), df_x(V(i,j+1),V(i+2,j+1))];
        d_y = [V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];
        
    %spodnji rob
    elseif(j == length(V) - 1) 
    
        d_x = [df_x(V(i-1,j),V(i+1,j)), df_x(V(i,j),V(i+2,j)), df_x(V(i-1,j+1),V(i+1,j+1)), df_x(V(i,j+1),V(i+2,j+1))];
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), V(i,j+1)-V(i,j), V(i+1,j+1)-V(i+1,j)];
           
    else
       
        d_x = [df_x(V(i-1,j),V(i+1,j)), df_x(V(i,j),V(i+2,j)), df_x(V(i-1,j+1),V(i+1,j+1)), df_x(V(i,j+1),V(i+2,j+1))];
        d_y = [df_y(V(i,j-1),V(i,j+1)), df_y(V(i+1,j-1),V(i+1,j+1)), df_y(V(i,j),V(i,j+2)), df_y(V(i+1,j),V(i+1,j+2))];
                   
    endif
    
    %v data shranimo vrednosti parcialnih odvodov
    data = [data, d_x, d_y];
    %interpoliramo trenutni enotski kvadrat
    out(idRow:idRow+len-1,idCol:idCol+len-1) = interpolationFunction(data,len);
      
    idCol += len-1;
    
  endfor 
  idRow += len-1;
  
endfor


figure(2);
surf(out);
title(["Interpolirana matrika V s parametrom len=" num2str(len)]);

%!demo 
%! len = 20;
%! V = [1 1 1 1 1 1 1 1 1; 
%!      1 6 3 2 5 2 3 6 1;
%!      1 8 2 1 7 1 2 8 1; 
%!      1 4 1 2 9 2 1 4 1;
%!      1 7 3 6 12 6 3 7 1;
%!      1 4 1 2 9 2 1 4 1;
%!      1 8 2 1 7 1 2 8 1;
%!      1 6 3 2 5 2 3 6 1;
%!      1 1 1 1 1 1 1 1 1];
%! interpolation(V, len);


endfunction