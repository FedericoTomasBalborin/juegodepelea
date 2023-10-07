# Extreme Shooters (Concepto para wollok)
## Overview
Un juego de peleas basado en proyectiles. Los personajes no se pueden golpear entre ellos pero si se
pueden disparar, cada personaje contando con 2 tipos de disparos y 1 habilidad especial, pudiendo
moverse de izquierda a derecha, saltar y también "volar". El juego contaría con un sistema de
gravedad que evita que los personajes estén todo el tiempo en el aire.

## Jugadores
Serán dos jugadores, cada uno contará con una barra de vida y una de energía, un metodo para recibir daño y otro para consumir energía cuando hagan ciertos movimientos (VOLAR y DISPARAR)
### Controles
- Jugador 1
  - A     => moverse para la izquierda
  - D     => moverse para la derecha
  - W     => volar
  - J     => Disparo primario
  - K     => Disparo secundario
- Jugador 2
  - left  => moverse para la izquierda
  - right => moverse para la derecha
  - up    => volar
  - Z     => Disparo primario
  - X     => Disparo secundario


## Personajes
Solo serán 3 o 4 personajes jugables. Habrá un menú de selección. No es necesario tener muchos
sprites. Solo 2 para cuando está quieto (si mira a la derecha o izquierda) y uno cuando haga algun
ataque.

## Plataformas
En el escenario habrá plataformas dónde los personajes se podrán parar. esas plataformas no
colisionan con los disparos.
Las plataformas serán de lo más necesario del juego y es lo único que no tengo una idea de cómo se
implementaría, por favor, pregúntele al profesor en esto.
También habrá gravedad, para que los personajes caigan y no se queden en el aire.
No hay botón para bajar, así que para descender de la plataforma los personajes deberán tirarse por
el borde y dejar que la gravedad haga su trabajo.
