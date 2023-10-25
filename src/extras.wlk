import wollok.game.*
import personajes.*

class Vida
{
	const jugador
	method image() = ""+jugador.vidas()+"corazones.png"
	method subir(personaje){}
}
object vida1 inherits Vida(jugador = jugador1) {
	method position()= game.at(1, 9)
}

object vida2 inherits Vida(jugador = jugador2) {
	method position()= game.at(17, 9)
}
object color
{
	const property blanco 	= "FFFFFF"
	const property noBlanco = "000000"
}

class Energia
{
	const jugador
	const life
	method position() = life.position().down(1)
	method textColor() = color.blanco()
	method text() = jugador.energia().toString()
	method subir(personaje){}
}

object energia1 inherits Energia(jugador = jugador1, life = vida1){}
object energia2 inherits Energia(jugador = jugador2, life = vida2){}

object derecha
{
	method nombre() = "der"
	method comportamientoDireccional(disparo){disparo.comportamientoDerecha()}
}
object izquierda
{
	method nombre() = "izq"
	method comportamientoDireccional(disparo){disparo.comportamientoIzquierda()}
}

object reposo
{
	method nombre()=""
}

object ataque
{
	method nombre()="_ataque"
}

class PocionEnergia
{
	var property pocion = 10
	var property posicionEnX = 0.randomUpTo(game.width())
	method image() = "pocion.png"
	method position() = game.at(posicionEnX,1)
	method removerPng(pocima) 
	{
		game.removeVisual(pocima)
	}
	
	
}
object validarEnergia
{
	var property check = 0
	method maxEnergia(jugador)
	{
		check = jugador.energia()
		if(check > 100){
			jugador.energia(100)
		}
	}
	method minEnergia(jugador)
	{
		check = jugador.energia()
		if(check < 0){
			jugador.energia(100)
		}
	}	
}

//limites visuales
//Que funcionen los power-Ups
//sonidos faltantes
//cambiar skins de personajes y disparos
//Poner en la energia otra fuente