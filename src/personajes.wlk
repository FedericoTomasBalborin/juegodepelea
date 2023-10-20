import wollok.game.*
import proyectiles.*
import plataformas.*
import niveles.*
import extras.*

//JUGADORES
object jugador1
{
	var property personaje
	var property vidas = 100
	var property posicionInicial = game.at(0,1)
	method controles()
	{
		keyboard.a().onPressDo({personaje.retroceder()})
		keyboard.d().onPressDo({personaje.avanzar()})
		keyboard.w().onPressDo({personaje.volar()})
		keyboard.j().onPressDo({personaje.disparo1()})
		keyboard.k().onPressDo({personaje.disparo2()})
		self.eventosArbitrariosAutomaticos()
	}
	
	method eventosArbitrariosAutomaticos()
	{	game.onTick(350,"caida",{=> personaje.caer() personaje.enEl(aire)})
	}
	
	method asignarPersonaje() {
		personaje = seleccionPersonajes.quienJugador1()
		personaje.jugador(self)
		personaje.position(posicionInicial)
		personaje.direccion(derecha)
	}
	
	method recibeDanio(danioDisparo)
	{
		vidas -= danioDisparo
	}
}

object jugador2
{
	const posicionInicial = game.at(game.width()-1,0)
	var property personaje
	var property vidas = 100
	method controles()
	{
		keyboard.left().onPressDo({personaje.retroceder()})
		keyboard.right().onPressDo({personaje.avanzar()})
		keyboard.up().onPressDo({personaje.volar()})
		keyboard.z().onPressDo({personaje.disparo1()})
		keyboard.x().onPressDo({personaje.disparo2()})
		self.eventosArbitrariosAutomaticos()
	}
	
	method eventosArbitrariosAutomaticos()
	{	game.onTick(350,"caida",{=> personaje.caer() personaje.enEl(aire)})
	}
	
	method asignarPersonaje() {
		personaje = seleccionPersonajes.quienJugador2()
		personaje.jugador(self)
		personaje.direccion(izquierda)
		personaje.position(posicionInicial)
	}
	method recibeDanio(danioDisparo)
	{
		vidas -= danioDisparo
	}
}










//personajes jugables
class Personaje
{
	var property direccion = derecha //La orientacion a donde el personaje esta apuntando. Puede ser izquierda (izq) o derecha (der)
	var property estado = reposo
	var property enEl= aire
	var property position = game.origin()
	const property armamento
	var property jugador
	
	method image()= direccion.nombre() + estado.nombre() + ".png"
	
	method avanzar()
	{
		position = self.position().right(1)
		direccion = derecha
	}
	method subir(algo){}
	method retroceder()
	{
		position = self.position().left(1)
		direccion = izquierda
	}	
	//Metodos para volar y caer	
	method volar()
	{
		position = self.position().up(2)
		enEl = aire
	}
	method enElSuelo() = enEl==suelo
	
	method caer() //Cuando dejé de volar
	{
		 if(not self.enElSuelo())
		 {
		 	position = self.position().down(1)
		 }
	}
	
	method disparo1()
	{
		estado = ataque
		armamento.dispararProyectil1(self)
	}
	method disparo2()
	{
		estado = ataque
		armamento.dispararProyectil2(self)
	}
	
}


class PoolYui inherits Personaje(armamento = armamentoYui)
{
	override method image() = "yui_" + super()

}

class Zipmata inherits Personaje(armamento = armamentoZipmata)
{
	override method image() = "char_" + super()
}

class TankFlan inherits Personaje(armamento = armamentoThirdGuy)
{
	override method image() = "eag_" + super()
}