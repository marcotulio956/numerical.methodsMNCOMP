x = [1 1.1 1.25 1.5 2 2.2 3.5 5 6 6.5 7 8 8.75 9.5 10];
y = [10 9 8.9 7 6 5.5 4 2 1.5 1.1 1.05 1 1 1.1 0.95];
plot2d(x,y,-4)

somatorioX = 0;
somatorioDoQuadradoX = 0;
somatorioDoCuboX=0;
somatorioDaQuartaX=0;
somatorioY = 0;
somatorioDoQuadradoY=0;
somatorioXY = 0;
somatorioX²Y = 0;
n=15

for  i=1:1:n
    somatorioX = somatorioX + x(i);
    somatorioDoQuadradoX = somatorioDoQuadradoX + x(i)^2;
    somatorioDoCuboX = somatorioDoCuboX + x(i)^3;
    somatorioDaQuartaX = somatorioDaQuartaX + x(i)^4;
    somatorioDoQuadradoY = somatorioDoQuadradoY + y(i)^2;
    somatorioY = somatorioY + y(i);
    somatorioXY = somatorioXY + y(i)*x(i);
    somatorioX²Y = somatorioX²Y + y(i)*(x(i)^2);
end


somatorioDoCuboX
somatorioDaQuartaX
somatorioDoQuadradoY
somatorioX²Y
/*
A = (n*somatorioXY - somatorioX*somatorioY)..
/(n*somatorioDoQuadradoX - somatorioX^2)
B = ((somatorioX*somatorioXY) - (somatorioY*somatorioDoQuadradoX))..
/(somatorioX^2 - n*somatorioDoQuadradoX)

curva  = A*w + B
plot2d(x,curva)
