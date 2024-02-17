# %%
#ARREFECIMENTO

# %%
#IMPORTS

import numpy as np
import matplotlib.pyplot as plt
import math as m
import scipy.optimize as sp

# %%
#1 - PONTO DE PROJETO

P3_1 = 2*(10**6) #Pa
T3_1 = 814 #K
m3_1 = 18.1 #kg/s
T4_1 = 1600 #K
m_comb_1 = 0.427 #kg/s
deltaT_1 = 1600 - T3_1
phi_global_1 = 0.3460

# %%
#2 - MÁXIMA ALTITUDE

P3_2 = 0.7*(10**6) #Pa
T3_2 = 707 #K
m3_2 = 6.8 #kg/s
T4_2 = 1387 #K
m_comb_2 = 0.132 #kg/s
deltaT_2 = 1600 - T3_2
phi_global_2 = 0.2847

# %%
#3 - CRUZEIRO

P3_3 = 1.8*(10**6) #Pa
T3_3 = 1060 #K
m3_3 = 14.2 #kg/s
T4_3 = 1393 #K
m_comb_3 = 0.140 #kg/s
deltaT_3 = 1600 - T3_3
phi_global_3 = 0.1446

# %%
#4 - IDLE

P3_4 = 0.15*(10**6) #Pa
T3_4 = 343 #K
m3_4 = 1.05 #kg/s
T4_4 = 703 #K
m_comb_4 = 0.0091 #kg/s
deltaT_4 = 1600 - T3_4
phi_global_4 = 0.1271

# %%
#Modificações do Projetista
Dint = 0.05

D_ref = 0.23
A_ref = (((D_ref*2)+Dint)**2)*np.pi/4

A_ft = 0.7*A_ref
D_ft = A_ft/(np.pi*(Dint + D_ref))

L_ZR = 0.5*D_ft
L_ZP = 0.75*D_ft
L_ZS = 0.5*D_ft
L_ZD = 1.5*D_ft
L_CC = L_ZP + L_ZS + L_ZD #Comprimento total

# %%
#ARREFECIMENTO POR FILME DE RESFRIAMENTO

Ts = T3_1
Ts_4 = T4_1
m_3 = m3_1
m_ZP = 0.25*m_3
phi_ZP = 1.249
phi_ZS = 0.8
phi_ZD = 0.237
phi_global = phi_global_1

#CÁLCULO DO FLUXO DE MASSA NA ZONA SECUNDÁRIA
m_ZS = (phi_global/phi_ZS)*m_3

#CÁLCULO DA PORCENTAGEM DE AR DESTINADA AO ARREFECIMENTO
m_arref = m_3*((0.1*Ts)-30)

#CÁLCULO DA VAZÃO DE AR NA ZONA DE DILUIÇÃO
m_ZD = m_3*(1 - ((m_ZP + m_ZS)/m_3)) 

#BALANÇO DE MASSA
bal_massa = m_3 - (m_ZS + m_ZP + m_ZD)

T_alvo = 1100 #TEMPERATURA ACEITÁVEL PARA EVITAR O STRESS TÉRMICO PARA LIGAS METÁLICAS

deltaT_combustao = Ts_4 - Ts 
T_g = Ts + deltaT_combustao
A_an = 2*np.pi*(D_ref - D_ft)*L_CC
mu_ar = (0.03863 + 0.00749*Ts - 5.8564*(10**-6)*(Ts**2) + 2.7769*(10**-9)*(Ts**3) - 4.600774*(10**-13)*(Ts**4))*(10**-5)
mu_g = (0.03863 + 0.00749*T_g - 5.8564*(10**-6)*(T_g**2) + 2.7769*(10**-9)*(T_g**3) - 4.600774*(10**-13)*(T_g**4))*(10**-5)


#CÁLCULO DA FENDA DA ZONA PRIMÁRIA
t_ZP = 1*10**-3 #Espessura de fenda
t_w_ZP = 1*10**-2 #Espessura do tubo de chama
s_ZP = 0.4*10**-3 #Altura da fenda
n_fendas_ZP = 35 #DEFINIR NUMERO DE FENDAS

A_total_fendas_ZP = n_fendas_ZP*2*np.pi*s_ZP*(D_ref - D_ft)
m_an_ZP = m_3
m_g_ZP = m_3 - (3/4)*m_ZP 
rho_g_u_g_ZP = m_g_ZP/A_ft

m_fenda_ZP = m_an_ZP*(A_total_fendas_ZP/A_an)
rho_an_u_an_ZP = m_fenda_ZP/A_total_fendas_ZP
m_ZP_2 = (rho_an_u_an_ZP)/(rho_g_u_g_ZP)

#CÁLCULO DA FENDA DA ZONA SECUNDÁRIA
t_ZS = 1*10**-3
s_ZS = 1*10**-3
t_w_ZS = 10*10**-3
n_fendas_ZS = 20

A_total_fendas_ZS = n_fendas_ZS*2*np.pi*s_ZS*(D_ref - D_ft)
m_an_ZS = m_3 - m_ZS - m_fenda_ZP
m_g_ZS = m_3 - m_ZS
rho_g_u_g_ZS = m_g_ZS/A_ft
m_fenda_ZS = m_an_ZS*(A_total_fendas_ZS/A_an)
rho_an_u_an_ZS = m_fenda_ZS/A_total_fendas_ZS
m_ZS_2 = (rho_an_u_an_ZS)/(rho_g_u_g_ZS)

#CÁLCULO DA FENDA DA ZONA DE DILUIÇÃO
t_ZD = 1*10**-3
s_ZD = 3*10**-3
t_w_ZD = 10*10**-3
n_fendas_ZD = 6

A_total_fendas_ZD = n_fendas_ZD*2*np.pi*s_ZD*(D_ref - D_ft)
m_an_ZD = m_3 -m_ZD - m_fenda_ZS
m_g_ZD = m_3 - m_ZD
rho_g_u_g_ZD = m_g_ZD/A_ft
m_fenda_ZD = m_an_ZD*(A_total_fendas_ZD/A_an)
rho_an_u_an_ZD = m_fenda_ZD/A_total_fendas_ZD
m_ZD_2 = (rho_an_u_an_ZD)/(rho_g_u_g_ZD)

x = np.arange(0.1, L_CC, 0.001)
a = range(len(x))
n_r = []
for i in range(len(x)):
  if x[i] < L_ZP:
    if 0.5 < m_ZP_2 <= 1.3:
      g_1 = 1.1*(m_ZP_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_1)
    elif 1.3 < m_ZP_2 < 4:
      g_2 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_2)
  elif x[i] >= L_ZP and x[i] < (L_ZS + L_ZP):
    if 0.5 < m_ZS_2 <= 1.3:
      g_3 = 1.1*(m_ZS_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_3)
    elif 1.3 < m_ZS_2 < 4:
      g_4 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_4)
  elif x[i] >= (L_ZS + L_ZP) and x[i] <= L_CC:
    if 0.5 < m_ZD_2 <= 1.3:
      g_5 = 1.1*(m_ZD_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_5)
    elif 1.3 < m_ZD_2.all() < 4:
      g_6 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_6)

T_g_w = []
h = range(len(n_r))
for i in h:
  temp = T_g - n_r[i]*(T_g - Ts)
  T_g_w.append(temp)

i = 0
tgw_len = range(len(T_g_w))
for i in tgw_len:
  if T_g_w[i].all() > T_alvo:
    print(f'Posição da Fenda Necessária para o Arrefecimento = {x[i]}')
    i = i + 1
result_1 = []

#FLUXO DE MASSA EM CADA ZONA 
comp_m_1 = np.linspace(0, L_ZR)
comp_m_2 = np.linspace(L_ZR, L_ZP)
comp_m_3 = np.linspace(L_ZP, (L_ZP + L_ZS))
comp_m_4 = np.linspace((L_ZP+L_ZS), L_CC)

m_g_ZR = (3/4)*m_ZP
m_g_ZP = 1
m_g_ZS = 1

def vazao_ZR(x):
  return m_g_ZR
  
def vazao_ZP(x):
  global m_g_ZP
  m_g_ZP = m_g_ZR + ((m_ZP - m_g_ZR)*(x - L_ZR))/(L_ZP - L_ZR)
  return m_g_ZP

def vazao_ZS(x):
  global m_g_ZS
  m_g_ZS =  m_g_ZP + ((m_ZS - m_g_ZP)*(x - L_ZP))/L_ZS
  return m_g_ZS

def vazao_ZD(x):
  m_g_ZD = m_g_ZS + abs(((m_ZD - m_g_ZS)*(x - (L_ZP + L_ZS)))/L_ZD)
  return m_g_ZD

mass_1 = []
mass_2 = []
mass_3 = []
mass_4 = []

for i in comp_m_1:
  mass_1.append(vazao_ZR(i)) 

for i in comp_m_2:
  mass_2.append(vazao_ZP(i)) 

for i in comp_m_3:
  mass_3.append(vazao_ZS(i)) 

for i in comp_m_4:
  mass_4.append(vazao_ZD(i)) 

plt.plot(comp_m_1*1000, mass_1, label = 'Zona de Recirc.')
plt.plot(comp_m_2*1000, mass_2, label = 'Zona Primária')
plt.plot(comp_m_3*1000, mass_3, label = 'Zona Secundária')
plt.plot(comp_m_4*1000, mass_4, label = 'Zona de Difusão')
plt.grid(True, which='both')
plt.ylabel('Fluxo de Massa [kg/s]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Fluxo de Massa por Zona')
plt.legend()
plt.show()

m_total = mass_1 + mass_2 + mass_3 + mass_4
comp_total = []
comp_total.extend(comp_m_1)
comp_total.extend(comp_m_2)
comp_total.extend(comp_m_3)
comp_total.extend(comp_m_4)


#BALANÇO DE MASSA
for i in range(len(m_total)):
  A =  m_3 - m_total[i] - m_fenda_ZP - m_fenda_ZS - m_fenda_ZD
  result_1.append(A)


plt.plot(comp_total, result_1)
plt.grid(True, which='both')
plt.ylabel('Massa')
plt.xlabel('Comprimento da Câmara de Combustão [m]')
plt.ylim(bottom=0)
plt.title('Balanço de Massa')
plt.show()

plt.plot(x*1000, n_r, label = 'Eficiência')
plt.grid(True, which='both')
plt.ylabel('Eficiência')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Eficiência ao longo da Câmara de Combustão')
plt.legend()
plt.show()

plt.plot(x*1000, T_g_w, label = 'Temperatura')
plt.grid(True, which='both')
plt.ylabel('Temperatura [K]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Temperatura ao longo da Câmara de Combustão')
plt.legend()
plt.show()


# %%
#ARREFECIMENTO POR FILME DE RESFRIAMENTO

Ts = T3_2
Ts_4 = T4_2
m_3 = m3_2
m_ZP = 0.25*m_3
phi_ZP = 1.249
phi_ZS = 0.8
phi_ZD = 0.237
phi_global = phi_global_2

#CÁLCULO DO FLUXO DE MASSA NA ZONA SECUNDÁRIA
m_ZS = (phi_global/phi_ZS)*m_3

#CÁLCULO DA PORCENTAGEM DE AR DESTINADA AO ARREFECIMENTO
m_arref = m_3*((0.1*Ts)-30)

#CÁLCULO DA VAZÃO DE AR NA ZONA DE DILUIÇÃO
m_ZD = m_3*(1 - ((m_ZP + m_ZS)/m_3)) 

#BALANÇO DE MASSA
bal_massa = m_3 - (m_ZS + m_ZP + m_ZD)

T_alvo = 1100 #TEMPERATURA ACEITÁVEL PARA EVITAR O STRESS TÉRMICO PARA LIGAS METÁLICAS

deltaT_combustao = Ts_4 - Ts 
T_g = Ts + deltaT_combustao
A_an = 2*np.pi*(D_ref - D_ft)*L_CC
mu_ar = (0.03863 + 0.00749*Ts - 5.8564*(10**-6)*(Ts**2) + 2.7769*(10**-9)*(Ts**3) - 4.600774*(10**-13)*(Ts**4))*(10**-5)
mu_g = (0.03863 + 0.00749*T_g - 5.8564*(10**-6)*(T_g**2) + 2.7769*(10**-9)*(T_g**3) - 4.600774*(10**-13)*(T_g**4))*(10**-5)


#CÁLCULO DA FENDA DA ZONA PRIMÁRIA
t_ZP = 1*10**-3 #Espessura de fenda
t_w_ZP = 1*10**-2 #Espessura do tubo de chama
s_ZP = 0.4*10**-3 #Altura da fenda
n_fendas_ZP = 35 #DEFINIR NUMERO DE FENDAS

A_total_fendas_ZP = n_fendas_ZP*2*np.pi*s_ZP*(D_ref - D_ft)
m_an_ZP = m_3
m_g_ZP = m_3 - (3/4)*m_ZP 
rho_g_u_g_ZP = m_g_ZP/A_ft

m_fenda_ZP = m_an_ZP*(A_total_fendas_ZP/A_an)
rho_an_u_an_ZP = m_fenda_ZP/A_total_fendas_ZP
m_ZP_2 = (rho_an_u_an_ZP)/(rho_g_u_g_ZP)

#CÁLCULO DA FENDA DA ZONA SECUNDÁRIA
t_ZS = 1*10**-3
s_ZS = 1*10**-3
t_w_ZS = 10*10**-3
n_fendas_ZS = 20

A_total_fendas_ZS = n_fendas_ZS*2*np.pi*s_ZS*(D_ref - D_ft)
m_an_ZS = m_3 - m_ZS - m_fenda_ZP
m_g_ZS = m_3 - m_ZS
rho_g_u_g_ZS = m_g_ZS/A_ft
m_fenda_ZS = m_an_ZS*(A_total_fendas_ZS/A_an)
rho_an_u_an_ZS = m_fenda_ZS/A_total_fendas_ZS
m_ZS_2 = (rho_an_u_an_ZS)/(rho_g_u_g_ZS)

#CÁLCULO DA FENDA DA ZONA DE DILUIÇÃO
t_ZD = 1*10**-3
s_ZD = 3*10**-3
t_w_ZD = 10*10**-3
n_fendas_ZD = 6

A_total_fendas_ZD = n_fendas_ZD*2*np.pi*s_ZD*(D_ref - D_ft)
m_an_ZD = m_3 -m_ZD - m_fenda_ZS
m_g_ZD = m_3 - m_ZD
rho_g_u_g_ZD = m_g_ZD/A_ft
m_fenda_ZD = m_an_ZD*(A_total_fendas_ZD/A_an)
rho_an_u_an_ZD = m_fenda_ZD/A_total_fendas_ZD
m_ZD_2 = (rho_an_u_an_ZD)/(rho_g_u_g_ZD)

x = np.arange(0.1, L_CC, 0.001)
a = range(len(x))
n_r = []
for i in range(len(x)):
  if x[i] < L_ZP:
    if 0.5 < m_ZP_2 <= 1.3:
      g_1 = 1.1*(m_ZP_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_1)
    elif 1.3 < m_ZP_2 < 4:
      g_2 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_2)
  elif x[i] >= L_ZP and x[i] < (L_ZS + L_ZP):
    if 0.5 < m_ZS_2 <= 1.3:
      g_3 = 1.1*(m_ZS_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_3)
    elif 1.3 < m_ZS_2 < 4:
      g_4 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_4)
  elif x[i] >= (L_ZS + L_ZP) and x[i] <= L_CC:
    if 0.5 < m_ZD_2 <= 1.3:
      g_5 = 1.1*(m_ZD_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_5)
    elif 1.3 < m_ZD_2.all() < 4:
      g_6 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_6)

T_g_w = []
h = range(len(n_r))
for i in h:
  temp = T_g - n_r[i]*(T_g - Ts)
  T_g_w.append(temp)

i = 0
tgw_len = range(len(T_g_w))
for i in tgw_len:
  if T_g_w[i].all() > T_alvo:
    print(f'Posição da Fenda Necessária para o Arrefecimento = {x[i]}')
    i = i + 1
result_1 = []

#FLUXO DE MASSA EM CADA ZONA 
comp_m_1 = np.linspace(0, L_ZR)
comp_m_2 = np.linspace(L_ZR, L_ZP)
comp_m_3 = np.linspace(L_ZP, (L_ZP + L_ZS))
comp_m_4 = np.linspace((L_ZP+L_ZS), L_CC)

m_g_ZR = (3/4)*m_ZP
m_g_ZP = 1
m_g_ZS = 1

def vazao_ZR(x):
  return m_g_ZR
  
def vazao_ZP(x):
  global m_g_ZP
  m_g_ZP = m_g_ZR + ((m_ZP - m_g_ZR)*(x - L_ZR))/(L_ZP - L_ZR)
  return m_g_ZP

def vazao_ZS(x):
  global m_g_ZS
  m_g_ZS =  m_g_ZP + ((m_ZS - m_g_ZP)*(x - L_ZP))/L_ZS
  return m_g_ZS

def vazao_ZD(x):
  m_g_ZD = m_g_ZS + abs(((m_ZD - m_g_ZS)*(x - (L_ZP + L_ZS)))/L_ZD)
  return m_g_ZD

mass_1 = []
mass_2 = []
mass_3 = []
mass_4 = []

for i in comp_m_1:
  mass_1.append(vazao_ZR(i)) 

for i in comp_m_2:
  mass_2.append(vazao_ZP(i)) 

for i in comp_m_3:
  mass_3.append(vazao_ZS(i)) 

for i in comp_m_4:
  mass_4.append(vazao_ZD(i)) 

plt.plot(comp_m_1*1000, mass_1, label = 'Zona de Recirc.')
plt.plot(comp_m_2*1000, mass_2, label = 'Zona Primária')
plt.plot(comp_m_3*1000, mass_3, label = 'Zona Secundária')
plt.plot(comp_m_4*1000, mass_4, label = 'Zona de Difusão')
plt.grid(True, which='both')
plt.ylabel('Fluxo de Massa [kg/s]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Fluxo de Massa por Zona')
plt.legend()
plt.show()

m_total = mass_1 + mass_2 + mass_3 + mass_4
comp_total = []
comp_total.extend(comp_m_1)
comp_total.extend(comp_m_2)
comp_total.extend(comp_m_3)
comp_total.extend(comp_m_4)


#BALANÇO DE MASSA
for i in range(len(m_total)):
  A =  m_3 - m_total[i] - m_fenda_ZP - m_fenda_ZS - m_fenda_ZD
  result_1.append(A)


plt.plot(comp_total, result_1)
plt.grid(True, which='both')
plt.ylabel('Massa')
plt.xlabel('Comprimento da Câmara de Combustão [m]')
plt.ylim(bottom=0)
plt.title('Balanço de Massa')
plt.show()

plt.plot(x*1000, n_r, label = 'Eficiência')
plt.grid(True, which='both')
plt.ylabel('Eficiência')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Eficiência ao longo da Câmara de Combustão')
plt.legend()
plt.show()

plt.plot(x*1000, T_g_w, label = 'Temperatura')
plt.grid(True, which='both')
plt.ylabel('Temperatura [K]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Temperatura ao longo da Câmara de Combustão')
plt.legend()
plt.show()

# %%
#ARREFECIMENTO POR FILME DE RESFRIAMENTO

Ts = T3_3
Ts_4 = T4_3
m_3 = m3_3
m_ZP = 0.25*m_3
phi_ZP = 1.249
phi_ZS = 0.8
phi_ZD = 0.237
phi_global = phi_global_3

#CÁLCULO DO FLUXO DE MASSA NA ZONA SECUNDÁRIA
m_ZS = (phi_global/phi_ZS)*m_3

#CÁLCULO DA PORCENTAGEM DE AR DESTINADA AO ARREFECIMENTO
m_arref = m_3*((0.1*Ts)-30)

#CÁLCULO DA VAZÃO DE AR NA ZONA DE DILUIÇÃO
m_ZD = m_3*(1 - ((m_ZP + m_ZS)/m_3)) 

#BALANÇO DE MASSA
bal_massa = m_3 - (m_ZS + m_ZP + m_ZD)

T_alvo = 1100 #TEMPERATURA ACEITÁVEL PARA EVITAR O STRESS TÉRMICO PARA LIGAS METÁLICAS

deltaT_combustao = Ts_4 - Ts 
T_g = Ts + deltaT_combustao
A_an = 2*np.pi*(D_ref - D_ft)*L_CC
mu_ar = (0.03863 + 0.00749*Ts - 5.8564*(10**-6)*(Ts**2) + 2.7769*(10**-9)*(Ts**3) - 4.600774*(10**-13)*(Ts**4))*(10**-5)
mu_g = (0.03863 + 0.00749*T_g - 5.8564*(10**-6)*(T_g**2) + 2.7769*(10**-9)*(T_g**3) - 4.600774*(10**-13)*(T_g**4))*(10**-5)


#CÁLCULO DA FENDA DA ZONA PRIMÁRIA
t_ZP = 1*10**-3 #Espessura de fenda
t_w_ZP = 1*10**-2 #Espessura do tubo de chama
s_ZP = 0.4*10**-3 #Altura da fenda
n_fendas_ZP = 35 #DEFINIR NUMERO DE FENDAS

A_total_fendas_ZP = n_fendas_ZP*2*np.pi*s_ZP*(D_ref - D_ft)
m_an_ZP = m_3
m_g_ZP = m_3 - (3/4)*m_ZP 
rho_g_u_g_ZP = m_g_ZP/A_ft

m_fenda_ZP = m_an_ZP*(A_total_fendas_ZP/A_an)
rho_an_u_an_ZP = m_fenda_ZP/A_total_fendas_ZP
m_ZP_2 = (rho_an_u_an_ZP)/(rho_g_u_g_ZP)

#CÁLCULO DA FENDA DA ZONA SECUNDÁRIA
t_ZS = 1*10**-3
s_ZS = 1*10**-3
t_w_ZS = 10*10**-3
n_fendas_ZS = 20

A_total_fendas_ZS = n_fendas_ZS*2*np.pi*s_ZS*(D_ref - D_ft)
m_an_ZS = m_3 - m_ZS - m_fenda_ZP
m_g_ZS = m_3 - m_ZS
rho_g_u_g_ZS = m_g_ZS/A_ft
m_fenda_ZS = m_an_ZS*(A_total_fendas_ZS/A_an)
rho_an_u_an_ZS = m_fenda_ZS/A_total_fendas_ZS
m_ZS_2 = (rho_an_u_an_ZS)/(rho_g_u_g_ZS)

#CÁLCULO DA FENDA DA ZONA DE DILUIÇÃO
t_ZD = 1*10**-3
s_ZD = 3*10**-3
t_w_ZD = 10*10**-3
n_fendas_ZD = 6

A_total_fendas_ZD = n_fendas_ZD*2*np.pi*s_ZD*(D_ref - D_ft)
m_an_ZD = m_3 -m_ZD - m_fenda_ZS
m_g_ZD = m_3 - m_ZD
rho_g_u_g_ZD = m_g_ZD/A_ft
m_fenda_ZD = m_an_ZD*(A_total_fendas_ZD/A_an)
rho_an_u_an_ZD = m_fenda_ZD/A_total_fendas_ZD
m_ZD_2 = (rho_an_u_an_ZD)/(rho_g_u_g_ZD)

x = np.arange(0.1, L_CC, 0.001)
a = range(len(x))
n_r = []
for i in range(len(x)):
  if x[i] < L_ZP:
    if 0.5 < m_ZP_2 <= 1.3:
      g_1 = 1.1*(m_ZP_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_1)
    elif 1.3 < m_ZP_2 < 4:
      g_2 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_2)
  elif x[i] >= L_ZP and x[i] < (L_ZS + L_ZP):
    if 0.5 < m_ZS_2 <= 1.3:
      g_3 = 1.1*(m_ZS_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_3)
    elif 1.3 < m_ZS_2 < 4:
      g_4 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_4)
  elif x[i] >= (L_ZS + L_ZP) and x[i] <= L_CC:
    if 0.5 < m_ZD_2 <= 1.3:
      g_5 = 1.1*(m_ZD_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_5)
    elif 1.3 < m_ZD_2.all() < 4:
      g_6 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_6)

T_g_w = []
h = range(len(n_r))
for i in h:
  temp = T_g - n_r[i]*(T_g - Ts)
  T_g_w.append(temp)

i = 0
tgw_len = range(len(T_g_w))
for i in tgw_len:
  if T_g_w[i].all() > T_alvo:
    print(f'Posição da Fenda Necessária para o Arrefecimento = {x[i]}')
    i = i + 1
result_1 = []

#FLUXO DE MASSA EM CADA ZONA 
comp_m_1 = np.linspace(0, L_ZR)
comp_m_2 = np.linspace(L_ZR, L_ZP)
comp_m_3 = np.linspace(L_ZP, (L_ZP + L_ZS))
comp_m_4 = np.linspace((L_ZP+L_ZS), L_CC)

m_g_ZR = (3/4)*m_ZP
m_g_ZP = 1
m_g_ZS = 1

def vazao_ZR(x):
  return m_g_ZR
  
def vazao_ZP(x):
  global m_g_ZP
  m_g_ZP = m_g_ZR + ((m_ZP - m_g_ZR)*(x - L_ZR))/(L_ZP - L_ZR)
  return m_g_ZP

def vazao_ZS(x):
  global m_g_ZS
  m_g_ZS =  m_g_ZP + ((m_ZS - m_g_ZP)*(x - L_ZP))/L_ZS
  return m_g_ZS

def vazao_ZD(x):
  m_g_ZD = m_g_ZS + abs(((m_ZD - m_g_ZS)*(x - (L_ZP + L_ZS)))/L_ZD)
  return m_g_ZD

mass_1 = []
mass_2 = []
mass_3 = []
mass_4 = []

for i in comp_m_1:
  mass_1.append(vazao_ZR(i)) 

for i in comp_m_2:
  mass_2.append(vazao_ZP(i)) 

for i in comp_m_3:
  mass_3.append(vazao_ZS(i)) 

for i in comp_m_4:
  mass_4.append(vazao_ZD(i)) 

plt.plot(comp_m_1*1000, mass_1, label = 'Zona de Recirc.')
plt.plot(comp_m_2*1000, mass_2, label = 'Zona Primária')
plt.plot(comp_m_3*1000, mass_3, label = 'Zona Secundária')
plt.plot(comp_m_4*1000, mass_4, label = 'Zona de Difusão')
plt.grid(True, which='both')
plt.ylabel('Fluxo de Massa [kg/s]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Fluxo de Massa por Zona')
plt.legend()
plt.show()

m_total = mass_1 + mass_2 + mass_3 + mass_4
comp_total = []
comp_total.extend(comp_m_1)
comp_total.extend(comp_m_2)
comp_total.extend(comp_m_3)
comp_total.extend(comp_m_4)


#BALANÇO DE MASSA
for i in range(len(m_total)):
  A =  m_3 - m_total[i] - m_fenda_ZP - m_fenda_ZS - m_fenda_ZD
  result_1.append(A)


plt.plot(comp_total, result_1)
plt.grid(True, which='both')
plt.ylabel('Massa')
plt.xlabel('Comprimento da Câmara de Combustão [m]')
plt.ylim(bottom=0)
plt.title('Balanço de Massa')
plt.show()

plt.plot(x*1000, n_r, label = 'Eficiência')
plt.grid(True, which='both')
plt.ylabel('Eficiência')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Eficiência ao longo da Câmara de Combustão')
plt.legend()
plt.show()

plt.plot(x*1000, T_g_w, label = 'Temperatura')
plt.grid(True, which='both')
plt.ylabel('Temperatura [K]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Temperatura ao longo da Câmara de Combustão')
plt.legend()
plt.show()


# %%
#ARREFECIMENTO POR FILME DE RESFRIAMENTO

Ts = T3_4
Ts_4 = T4_4
m_3 = m3_4
m_ZP = 0.25*m_3
phi_ZP = 1.249
phi_ZS = 0.8
phi_ZD = 0.237
phi_global = phi_global_4

#CÁLCULO DO FLUXO DE MASSA NA ZONA SECUNDÁRIA
m_ZS = (phi_global/phi_ZS)*m_3

#CÁLCULO DA PORCENTAGEM DE AR DESTINADA AO ARREFECIMENTO
m_arref = m_3*((0.1*Ts)-30)

#CÁLCULO DA VAZÃO DE AR NA ZONA DE DILUIÇÃO
m_ZD = m_3*(1 - ((m_ZP + m_ZS)/m_3)) 

#BALANÇO DE MASSA
bal_massa = m_3 - (m_ZS + m_ZP + m_ZD)

T_alvo = 1100 #TEMPERATURA ACEITÁVEL PARA EVITAR O STRESS TÉRMICO PARA LIGAS METÁLICAS

deltaT_combustao = Ts_4 - Ts 
T_g = Ts + deltaT_combustao
A_an = 2*np.pi*(D_ref - D_ft)*L_CC
mu_ar = (0.03863 + 0.00749*Ts - 5.8564*(10**-6)*(Ts**2) + 2.7769*(10**-9)*(Ts**3) - 4.600774*(10**-13)*(Ts**4))*(10**-5)
mu_g = (0.03863 + 0.00749*T_g - 5.8564*(10**-6)*(T_g**2) + 2.7769*(10**-9)*(T_g**3) - 4.600774*(10**-13)*(T_g**4))*(10**-5)


#CÁLCULO DA FENDA DA ZONA PRIMÁRIA
t_ZP = 1*10**-3 #Espessura de fenda
t_w_ZP = 1*10**-2 #Espessura do tubo de chama
s_ZP = 0.4*10**-3 #Altura da fenda
n_fendas_ZP = 35 #DEFINIR NUMERO DE FENDAS

A_total_fendas_ZP = n_fendas_ZP*2*np.pi*s_ZP*(D_ref - D_ft)
m_an_ZP = m_3
m_g_ZP = m_3 - (3/4)*m_ZP 
rho_g_u_g_ZP = m_g_ZP/A_ft

m_fenda_ZP = m_an_ZP*(A_total_fendas_ZP/A_an)
rho_an_u_an_ZP = m_fenda_ZP/A_total_fendas_ZP
m_ZP_2 = (rho_an_u_an_ZP)/(rho_g_u_g_ZP)

#CÁLCULO DA FENDA DA ZONA SECUNDÁRIA
t_ZS = 1*10**-3
s_ZS = 1*10**-3
t_w_ZS = 10*10**-3
n_fendas_ZS = 20

A_total_fendas_ZS = n_fendas_ZS*2*np.pi*s_ZS*(D_ref - D_ft)
m_an_ZS = m_3 - m_ZS - m_fenda_ZP
m_g_ZS = m_3 - m_ZS
rho_g_u_g_ZS = m_g_ZS/A_ft
m_fenda_ZS = m_an_ZS*(A_total_fendas_ZS/A_an)
rho_an_u_an_ZS = m_fenda_ZS/A_total_fendas_ZS
m_ZS_2 = (rho_an_u_an_ZS)/(rho_g_u_g_ZS)

#CÁLCULO DA FENDA DA ZONA DE DILUIÇÃO
t_ZD = 1*10**-3
s_ZD = 3*10**-3
t_w_ZD = 10*10**-3
n_fendas_ZD = 6

A_total_fendas_ZD = n_fendas_ZD*2*np.pi*s_ZD*(D_ref - D_ft)
m_an_ZD = m_3 -m_ZD - m_fenda_ZS
m_g_ZD = m_3 - m_ZD
rho_g_u_g_ZD = m_g_ZD/A_ft
m_fenda_ZD = m_an_ZD*(A_total_fendas_ZD/A_an)
rho_an_u_an_ZD = m_fenda_ZD/A_total_fendas_ZD
m_ZD_2 = (rho_an_u_an_ZD)/(rho_g_u_g_ZD)

x = np.arange(0.1, L_CC, 0.001)
a = range(len(x))
n_r = []
for i in range(len(x)):
  if x[i] < L_ZP:
    if 0.5 < m_ZP_2 <= 1.3:
      g_1 = 1.1*(m_ZP_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_1)
    elif 1.3 < m_ZP_2 < 4:
      g_2 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZP)**-0.2)*((t_ZP/s_ZP)**-0.2)
      n_r.append(g_2)
  elif x[i] >= L_ZP and x[i] < (L_ZS + L_ZP):
    if 0.5 < m_ZS_2 <= 1.3:
      g_3 = 1.1*(m_ZS_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_3)
    elif 1.3 < m_ZS_2 < 4:
      g_4 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZS)**-0.2)*((t_ZS/s_ZS)**-0.2)
      n_r.append(g_4)
  elif x[i] >= (L_ZS + L_ZP) and x[i] <= L_CC:
    if 0.5 < m_ZD_2 <= 1.3:
      g_5 = 1.1*(m_ZD_2**0.65)*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_5)
    elif 1.3 < m_ZD_2.all() < 4:
      g_6 = 1.28*((mu_ar/mu_g)**0.15)*((x[i]/s_ZD)**-0.2)*((t_ZD/s_ZD)**-0.2)
      n_r.append(g_6)

T_g_w = []
h = range(len(n_r))
for i in h:
  temp = T_g - n_r[i]*(T_g - Ts)
  T_g_w.append(temp)

i = 0
tgw_len = range(len(T_g_w))
for i in tgw_len:
  if T_g_w[i].all() > T_alvo:
    print(f'Posição da Fenda Necessária para o Arrefecimento = {x[i]}')
    i = i + 1
result_1 = []

#FLUXO DE MASSA EM CADA ZONA 
comp_m_1 = np.linspace(0, L_ZR)
comp_m_2 = np.linspace(L_ZR, L_ZP)
comp_m_3 = np.linspace(L_ZP, (L_ZP + L_ZS))
comp_m_4 = np.linspace((L_ZP+L_ZS), L_CC)

m_g_ZR = (3/4)*m_ZP
m_g_ZP = 1
m_g_ZS = 1

def vazao_ZR(x):
  return m_g_ZR
  
def vazao_ZP(x):
  global m_g_ZP
  m_g_ZP = m_g_ZR + ((m_ZP - m_g_ZR)*(x - L_ZR))/(L_ZP - L_ZR)
  return m_g_ZP

def vazao_ZS(x):
  global m_g_ZS
  m_g_ZS =  m_g_ZP + ((m_ZS - m_g_ZP)*(x - L_ZP))/L_ZS
  return m_g_ZS

def vazao_ZD(x):
  m_g_ZD = m_g_ZS + abs(((m_ZD - m_g_ZS)*(x - (L_ZP + L_ZS)))/L_ZD)
  return m_g_ZD

mass_1 = []
mass_2 = []
mass_3 = []
mass_4 = []

for i in comp_m_1:
  mass_1.append(vazao_ZR(i)) 

for i in comp_m_2:
  mass_2.append(vazao_ZP(i)) 

for i in comp_m_3:
  mass_3.append(vazao_ZS(i)) 

for i in comp_m_4:
  mass_4.append(vazao_ZD(i)) 

plt.plot(comp_m_1*1000, mass_1, label = 'Zona de Recirc.')
plt.plot(comp_m_2*1000, mass_2, label = 'Zona Primária')
plt.plot(comp_m_3*1000, mass_3, label = 'Zona Secundária')
plt.plot(comp_m_4*1000, mass_4, label = 'Zona de Difusão')
plt.grid(True, which='both')
plt.ylabel('Fluxo de Massa [kg/s]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Fluxo de Massa por Zona')
plt.legend()
plt.show()

m_total = mass_1 + mass_2 + mass_3 + mass_4
comp_total = []
comp_total.extend(comp_m_1)
comp_total.extend(comp_m_2)
comp_total.extend(comp_m_3)
comp_total.extend(comp_m_4)


#BALANÇO DE MASSA
for i in range(len(m_total)):
  A =  m_3 - m_total[i] - m_fenda_ZP - m_fenda_ZS - m_fenda_ZD
  result_1.append(A)


plt.plot(comp_total, result_1)
plt.grid(True, which='both')
plt.ylabel('Massa')
plt.xlabel('Comprimento da Câmara de Combustão [m]')
plt.ylim(bottom=0)
plt.title('Balanço de Massa')
plt.show()

plt.plot(x*1000, n_r, label = 'Eficiência')
plt.grid(True, which='both')
plt.ylabel('Eficiência')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Eficiência ao longo da Câmara de Combustão')
plt.legend()
plt.show()

plt.plot(x*1000, T_g_w, label = 'Temperatura')
plt.grid(True, which='both')
plt.ylabel('Temperatura [K]')
plt.xlabel('Comprimento da Câmara de Combustão [mm]')
plt.title('Temperatura ao longo da Câmara de Combustão')
plt.legend()
plt.show()
