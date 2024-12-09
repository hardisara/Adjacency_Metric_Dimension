#!/usr/bin/env python
# coding: utf-8

# ## Adjacency metric dimension - kode
# 
# 

# Adjacency metric dimension iščemo s pomočjo CLP (glej kratki opis projekta). Spodaj je definirana funkcija dim_A(G), ki ravno z uporabo CLP poišče iskano množico S.
# 
# 

# In[4]:

import csv
from sage.all import *

# Funkcija za izračun dimenzije sosednosti (dim_A(G))
def dim_A(G):
    vozlisca = G.vertices()
    p = MixedIntegerLinearProgram(maximization=False)
    x = p.new_variable(binary=True)  # Binarne spremenljivke za vozlišča
    matrika_sosednosti = G.adjacency_matrix()

    # Ciljna funkcija: minimiziramo vsoto x[v] za v v V
    p.set_objective(sum(x[v] for v in vozlisca))

    # Dodajanje omejitev za vsako kombinacijo vozlišč (v, w)
    for v in vozlisca:
        for w in vozlisca:
            if v != w:
                p.add_constraint(
                    sum(abs(matrika_sosednosti[u][v] - matrika_sosednosti[u][w]) * x[u] for u in vozlisca)
                    + x[v] + x[w] >= 1
                )

    # Rešimo linearni program
    p.solve()

    # Določimo velikost množice S na osnovi rešitev
    S = [v for v in vozlisca if p.get_values(x[v]) == 1]

    return len(S), S  # Vrne velikost množice S (dim_A(G)) in samo množico S


# ### Iskanje grafov z $dim_A(G) = 1, 2, 3$
# 
# 

# Spodaj so kode, ki nam pomagajo lažje odgovoriti vprašanje 'Kateri grafi imajo $dim_A(G) = 1, 2, 3$?'
# 
# 

# In[14]:

def analiziraj_grafe(min_vozlisca=3, max_vozlisca=5):
    with open('grafi.csv', 'w') as f:
        wr = csv.writer(f)
        # Generiraj povezane grafe za dano število vozlišč
        for n in range(min_vozlisca, max_vozlisca + 1):
            print(f"\nPovezani grafi na {n} vozliščih")
            for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
                # Izračun dimenzije sosednosti za trenutni graf
                dim, S = dim_A(G)
            
                if dim in (1, 2, 3, n-2, n-1, n):
                    wr.writerow([n, G.graph6_string(), dim, str(S)])

# Funkcija za analizo grafov z dimenzijo 1
def analiziraj_grafe_dim1(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo 1:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == 1:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")
                
                
#___________________________________________________________________________________               

# Funkcija za analizo grafov z dimenzijo 2
def analiziraj_grafe_dim2(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo 2:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == 2:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")
                
                
                
#____________________________________________________________________________________

# Funkcija za analizo grafov z dimenzijo 3
def analiziraj_grafe_dim3(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo 3:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == 3:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")


# ### Iskanje grafov z $dim_A(G) = n, n-1, n-2$ 
# 
# 

# Spodnje kode nam pomagajo analizirati kateri grafi z n vozlišči imajo $dim_A(G) = n, n-1, n-2$.
# 
# 

# In[6]:


# Funkcija za analizo grafov z dimenzijo n
def analiziraj_grafe_dim_n(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo {n}:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == n:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")
                
                
                
#____________________________________________________________________________________

# Funkcija za generacijo in analizo grafov z dimenzijo n-1
def analiziraj_grafe_dim_n1(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo {n-1}:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == n-1:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")
                
                
               
#___________________________________________________________________________________

# Funkcija za generacijo in analizo grafov z dimenzijo n-2
def analiziraj_grafe_dim_n2(min_vozlisca=3, max_vozlisca=5):
    # Generiraj povezane grafe za dano število vozlišč
    for n in range(min_vozlisca, max_vozlisca + 1):
        print(f"\nPovezani grafi na {n} vozliščih z dimenzijo {n-2}:")
        
        for G in graphs.nauty_geng(f"{n} -c"):  # Povezani grafi z 'n' vozlišči
            # Izračun dimenzije sosednosti za trenutni graf
            dim = dim_A(G)
            
            if dim[0] == n-2:

            # Prikaz grafa
                #G.show()

            # Izpis rezultatov
                print(f"Graf {G.name()}:")
                print(f"Dimenzija sosednosti (dim_A(G)): {dim}")


# ### Iskanje spodnje in zgornje meje za 'adjacency metric dimension' dreves z n vozlišči
# 
# 

# S spodnjo kodo analiziramo predpostavko, da je $ \frac{n}{2} \leq dim_A(T)  \leq n-2$, kjer je T drevo z n vozlišči.
# 
# 

# In[9]:


# Funkcija za analizo dreves
def analiziraj_drevesa(min_vozlisca=3, max_vozlisca=5):
    # Ustvari slovar za shranjevanje minimalne in maksimalne dimenzije za vsak graf
    dimenzije = {}

    with open('drevesa.csv', 'w') as f:
        wr = csv.writer(f)
        # Generiraj drevesa za dano število vozlišč
        for n in range(min_vozlisca, max_vozlisca + 1):
            print(f"\nDrevesa na {n} vozliščih")

            min_dim = float('inf')  # Začetna vrednost za minimalno dimenzijo
            max_dim = -float('inf')  # Začetna vrednost za maksimalno dimenzijo
       
            for T in graphs.trees(n):  # Drevesa z 'n' vozlišči
                # Izračun dimenzije sosednosti za trenutno drevo
                dim, S = dim_A(T)  # Pridobimo dimenzijo in množico S
                wr.writerow([n, T.graph6_string(), dim, str(S)])

                # Posodobi minimalno in maksimalno dimenzijo
                min_dim = min(min_dim, dim)
                max_dim = max(max_dim, dim)

            # Po analizi vseh dreves za 'n' vozlišč izpiši minimalno in maksimalno dimenzijo
            print(f"\nZa {n} vozlišč je minimalna dimenzija: {min_dim}")
            print(f"Za {n} vozlišč je maksimalna dimenzija: {max_dim}")
            dimenzije[n] = (min_dim, max_dim)  # Shrani rezultata za poznejšo analizo

    # Vrni dimenzije za vse vrednosti n
    return dimenzije

