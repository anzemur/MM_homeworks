function h = movavg(x, y, n)
%h = movavg(x, y, n)je funckija ki za vhodne podatke x = [x0, ..., xN]
%in izhodne podatke y = [y0, ..., yN] poisce koeficiente h = [h1, ..., hn]
%za model drsecega povprecja z n zakasnitvami.
%x,y sta podana kot vrsticna vektorja.

%sestavimo matriko A iz podatkov x, tako da vedno vzamemo okvir velikosti n iz
%vhodnih podatkov x, in ga v vsaki iteraciji premaknemo za eno naprej

for i = 1:length(x)-n+1;
  A(i ,: ) = x(i : i+n-1);
end


%Resimo sistem po metodi najmanjsih kvadratov
%in pri tem zanemarimo prvih n vrednosti y
h = A\(y(n:end))';
%v navodilih je napisano da mora biti h vrsticni vektor
h = h';

%!test
%! x=[2 6 8 3];
%! y=[2 10 20 19];
%! h=[2 1]; 
%! n=2;
%! assert(movavg(x,y,n),h,eps*10)

%!test
%! x=[1 2 3 4 5 6 7 8 9 10];
%! y=[1 3 6 9 12 15 18 21 24 27];
%! h=[1 1 1];
%! n=3;
%! assert(movavg(x,y,n),h,eps*10)

%!demo
%! n=[1 2 3 5 10];
%! train_data = load("io-train.txt");
%! test_data = load("io-test.txt");
%!
%! x_train = train_data(1,: );
%! y_train = train_data(2,: );
%!
%! x_test = test_data(1,: );
%! y_test = test_data(2,: );
%!
%! count = 1;
%! for i = n
%!  
%!  h = movavg(x_train, y_train, i);
%!  y_model = prediction(x_test, h);
%!  tmp = y_test-y_model;
%!  error(i) =  norm(tmp);
%!  err1 = mean(abs(tmp), 1);
%!  abs_error(i) = mean(err1,2);
%!  figure(count)
%!  plot(y_test, 'g'); hold on; plot (y_model, 'r');
%!  title(['n = ' num2str(i) ''])
%!  legend("y_{test}", "y_{model}")
%!  
%!  count = count + 1;
%!
%! end
%!
%! figure(6)
%! plot(n, error(n), 'r');
%! title("Napaka modela v odvisnosti od stevila zakasnitev n")
%!
%! figure(7)
%! plot(n, abs_error(n), '-o');
%! title("Absolutna napaka modela v odvisnosti od stevila zakasnitev n")






