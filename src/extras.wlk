import wollok.game.*
import personajes.*
object vida {

	method image() = ""+jugador1.vidas()+"corazones.png"
	method subir(personaje){}
	
		
}
object vida2 {
	method image() = ""+jugador2.vidas()+"corazones.png"
	method subir(personaje){}
}


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

object suelo
{
	method comportamiento(disparo){disparo.comportamientoArriba()}
}

object aire
{
	method comportamiento(disparo){disparo.comportamientoAbajo()}
}


object reposo
{
	method nombre()=""
}

object ataque
{
	method nombre()="_ataque"
}

//comportamientos del menu
//limites visuales
//energia / powerups
//final del juego
//mover una posicion el disparo
//sonidos faltantes
//cambiar skins de personajes y disparos
//hacer mas escenarios