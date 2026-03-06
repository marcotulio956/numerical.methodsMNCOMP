import numpy as np
import matplotlib.pyplot as plt

t_m = 25
k = 0.01

a = 0
b = 500
m = 10
y0 = 500

def funcao_f (t):#EDO
    f = (-1)*k*(t-t_m)
    return f

def funcao_ya(x):#SOLUÇÃO ANALÍTICA
    ya = t_m + (y0-t_m)*np.exp(-k*x)
    return ya

def euler(a,b,m,y0):
    
    y = np.zeros(m+1)
    x = np.zeros(m+1)
    s_analitica = np.zeros(m+1)
    h = (b-a)/m

    y[0] = y0
    x[0] = a
    
    for i in range(m):
        s_analitica[i] = funcao_ya(x[i])
        y[i+1] = y[i] + h*funcao_f(y[i])
        x[i+1] = x[i] + h 

    s_analitica[m] = funcao_ya(x[m])

    plt.scatter(x,y)
    plt.scatter(x,s_analitica, color='red')

def euler_melhorado(a,b,m,y0):
    
    y = np.zeros(m+1)
    x = np.zeros(m+1)
    s_analitica = np.zeros(m+1)
    h = (b-a)/m

    y[0] = y0
    x[0] = a

    for i in range(m):
        f = funcao_f(y[i])
        ff =funcao_f((y[i] + h*funcao_f(y[i])))
        s_analitica[i] = funcao_ya(x[i])
        y[i+1] = y[i] + h/2*(f + ff)
        x[i+1] = x[i] + h 

    s_analitica[m] = funcao_ya(x[m])

    plt.scatter(x,y)
    plt.scatter(x,s_analitica, color='red')
    
def euler_modificado(a, b, m, y0):
    
    y = np.zeros(m+1)
    x = np.zeros(m+1)
    s_analitica = np.zeros(m+1)
    
    h = (b-a)/m
    y[0]=y0
    x[0]=a
    
    for i in range(m):
        
        f = y[i] + h/2*funcao_f(y[i])
        s_analitica[i] = funcao_ya(x[i])
        y[i+1] = y[i] + h*funcao_f(f)
        x[i+1] = x[i] + h
    
    s_analitica[m] = funcao_ya(x[m])
    plt.scatter(x,y)
    plt.scatter(x,s_analitica, color='red')
    
def runge_kutta(a,b,m,y0):
    
    y = np.zeros(m+1)
    x = np.zeros(m+1)
    s_analitica = np.zeros(m+1)
    h = (b-a)/m

    y[0] = y0
    x[0] = a
    
    for i in range(m):
        
        k1=funcao_f(y[i])
        k2=funcao_f(y[i]+(h/2*k1))
        k3=funcao_f(y[i]+(h/2*k2))
        k4=funcao_f(y[i]+(h*k3))
        s_analitica[i] = funcao_ya(x[i])
        y[i+1] = y[i] + h/6*(k1 + 2*k2 + 2*k3 + k4)
        x[i+1] = x[i] + h 
        
    s_analitica[m] = funcao_ya(x[m])
    plt.scatter(x,y)
    plt.scatter(x,s_analitica, color='red')
    
runge_kutta(a,b,m,y0)
