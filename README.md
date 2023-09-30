# Tiroteo Extremo (Planificación)
## Fase 1
### El Personaje
Referencias:
- var property image
- var property position
- var property direccion ("izq" o "der")

Métodos:
- avanzar() //mueve posición 1 a la derecha, cambia variable dirección por "der"
- retroceder() //mueve posición 1 a la izquierda, cambia variable dirección por "izq"
- volar() //Sin restricción
- caer() //Cuando dejé de volar

Configuración de teclado:
- A => retroceder()
- D => avanzar()
- W => volar()
### Proyectil
Referencias:
- var posición Inicial //Indica desde qué punto va a partir el proyectil. Para prueba, estará seteado en [5,0]
- const property image
- var position //La posición se sobre

Métodos:
- comportamiento Izquierda() //Cambia la posición del objeto 1 valor hacia la izquierda un número N de veces con onTick() o schedule(), después desaparece
- comportamiento Derecha() //Lo mismo pero cambiando la posición hacia la derecha

configuración (temporal)
- J = comportamiento Izquierda()
- K = comportamiento Derecha()
## Fase 2
Al personaje se le agrega una variable que reciba como referencia a un objeto proyectil.

Un método para que el proyectil aparezca en pantalla, su posición inicial será la misma que la del personaje.

El comportamiento del proyectil no será más dictado por el teclado, sino que dependerá de la variable direccion del personaje. Entonces dentro del objeto proyectil debe haber un método para evaluar, algo tipo evaluarDireccion().

configuración
- J = personaje.disparar()
### Plataforma
Sigo sin saber cómo implementarlo, pero a ustedes seguro se les ocurrirá algo.
### Personaje 2
Básicamente, repetir lo mismo que personaje pero con otra configuración de teclado pero para el segundo jugador.
# BETA TERMINADA
## Fase 3
Agregar colisiones así los personajes pueden interactuar con los proyectiles. Agregar una variable de salud, otra de energía y un método para que reciba daño(). Por lo tanto, también un método que haga Fin Del Juego cuando uno de los personajes quede sin salud.
Posiblemente haya que incluir una distinción entre lo que es el objeto jugador y el personaje.

Objeto jugador
- Tiene la configuracion de botones
- Una variable que indique qué personaje está usando
- Tiene las variables Salud y Energía
- Un método que baje la energía cuando vuela o dispara
- Otro método para que no pueda volar ni disparar sin energía
- Un método que recargue la energía bajo X condición.

Clase Personaje
- Tiene la variable proyectil y la imagen
- Los métodos para moverse, volar y caer
- El método para disparar
- La interacción con las plataformas
- Debe ser una clase por si ambos jugadores usan el mismo personaje.


## Fase 4
Acá se divide más el trabajo. Por un lado está el diseño de personajes (es un juego de peleas, mínimo 4 personajes seleccionables) que está unido a la creación de más tipos de disparos. Por otro lado está el diseño visual, usar las plataformas para crear estructuras, buscar un fondo y sprites para los personajes. Y por último alguien debe encargarse de armar el menú principal y el selector de personajes, un menú de pausa también vendría bien.

Si nos sobra al menos una semana, estaría bueno poder implementar lo de darle a cada personaje una habilidad que modifique algo del juego.
