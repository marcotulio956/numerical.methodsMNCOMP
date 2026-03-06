w = [1 1.1 1.25 1.5 2 2.2 3.5 5 6 6.5 7 8 8.75 9.5 10];
z = [10 9 8.9 7 6 5.5 4 2 1.5 1.1 1.05 1 1 1.1 0.95];
plot2d(w,z,-4)
/*
w = lndex(w);   //vetor com ln de todos os elemntos de x
z = lndex(z);   //vetor com ln de todos os elemntos de y
*/
somatorioX = 0;
somatorioDoQuadradoX = 0;
somatorioY = 0;
somatorioXY = 0;
n=15

for  i=1:1:n
    somatorioX = somatorioX + w(i);
    somatorioDoQuadradoX = somatorioDoQuadradoX + w(i)^2;
    somatorioY = somatorioY + z(i);
    somatorioXY = somatorioXY + z(i)*w(i);
end

somatorioX
somatorioDoQuadradoX
somatorioY
somatorioXY

//no caso de uma função potencial: ln(y) = aln(x) + ln(b),
//que vamos traduzir para y(x) = ax + b:
//Nas operações: y = ln(y), x = nl(x) e b = ln(b)

A = (n*somatorioXY - somatorioX*somatorioY)..
/(n*somatorioDoQuadradoX - somatorioX^2)
B = ((somatorioX*somatorioXY) - (somatorioY*somatorioDoQuadradoX))..
/(somatorioX^2 - n*somatorioDoQuadradoX)
//B = %e^B
curva  = A*w + B
plot2d(x,curva)

/*
for i=1:1:15
    
end
*/
