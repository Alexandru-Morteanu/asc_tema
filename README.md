# Tema - Arhitectura Sistemelor de Calcul

More details [here](https://cs.unibuc.ro/~crusu/asc/Arhitectura%20Sistemelor%20de%20Calcul%20(ASC)%20-%20Tema%20Laborator%202024.pdf)
| **Input** | **Explicatie input** | **Output** | **Explicatie output** |
|----------|-----------------------|------------|------------------------|
| <div align="center">4 <br> 1 <br> 5 <br> 1 <br> 124 <br> 4 <br> 350 <br> 121 <br> 75 <br> 254 <br> 1024 <br> 70 <br> 30</div> | <div align="center">se efectueaza 4 operatii <br> se efectueaza ADD <br> numarul de fisiere <br> descriptorul primului fisier <br> dimensiunea in kB <br> descriptorul celui de-al doilea fisier <br> dimensiunea in kB <br> descriptorul celui de-al treilea fisier <br> dimensiunea in kB <br> descriptorul celui de-al patrulea fisier <br> dimensiunea in kB <br> descriptorul celui de-al cincilea fisier <br> dimensiunea in kB</div> | <div align="center">1: (0, 15) <br> 4: (16, 59) <br> 121: (60, 69) <br> 254: (70, 197) <br> 70: (198, 201)</div> | <div align="center">output prima operatie</div> |
| <div align="center">2 <br> 121 | <div align="center"> se efectueaza GET <br> descriptorul de fisier peste care facem GET | <div align="center"> (60, 69) | output a doua operatie |
| <div align="center">3 <br> 4 | <div align="center"> se efectueaza DELETE <br> descriptorul de fisier peste care facem DELETE | <div align="center"> 1: (0, 15) <br> 121: (60, 69) <br> 254: (70, 197) <br> 70: (198, 201) | output a treia operatie |
| <div align="center">4 | <div align="center">se efectueaza DEFRAGMENTATION | <div align="center"> 1: (0, 15) <br> 121: (16, 25) <br> 254: (26, 153) <br> 70: (154, 157) | output a patra operatie |
