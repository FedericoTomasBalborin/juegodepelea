import wollok.game.*
import proyectiles.*

//JUGADORES
object jugador
{
	const listaDePersonajes = [poolYui,zipmata]
	var property personaje
	method escogerPersonaje()
	{
		personaje = listaDePersonajes.get(0)
		game.addVisual(personaje)
	}
	method controles()
	{
		keyboard.left().onPressDo({personaje.retroceder()})
		keyboard.right().onPressDo({personaje.avanzar()})
		keyboard.up().onPressDo({personaje.volar()})
		game.onTick(500,"caida",{=> personaje.caer()})
		keyboard.z().onPressDo({personaje.disparo1()})
		keyboard.x().onPressDo({personaje.disparo2()})
	}
}

object jugador2
{
	const listaDePersonajes = [poolYui,zipmata]
	var property personaje
	method escogerPersonaje()
	{
		personaje = listaDePersonajes.get(1)
		game.addVisual(personaje)
	}
	method controles()
	{
		keyboard.left().onPressDo({personaje.retroceder()})
		keyboard.right().onPressDo({personaje.avanzar()})
		keyboard.up().onPressDo({personaje.volar()})
		game.onTick(500,"caida",{=> personaje.caer()})
		keyboard.z().onPressDo({personaje.disparo1()})
		keyboard.x().onPressDo({personaje.disparo2()})
	}
}










//personajes jugables
class Personaje
{
	var property direccion = "der" //La orientacion a donde el personaje esta apuntando. Puede ser izquierda (izq) o derecha (der)
	var property position = game.origin()
	const property armamento
	method avanzar()
	{
		position = self.position().right(1)
		direccion = "der"
	}
	method retroceder()
	{
		position = self.position().left(1)
		direccion = "izq"
	}
	//Metodos para volar y caer	
	method enElSuelo()=self.position().y()==0
	method volar() //Sin restricción
	{
		position = self.position().up(2)
	}
	method caer() //Cuando dejé de volar
	{
		 if(not self.enElSuelo())
		 {
		 	position = self.position().down(1)
		 }
	}
	method subir(personaje){}
	method disparo1()
	{
		armamento.dispararProyectil1(self)
	}
	method disparo2()
	{
		armamento.dispararProyectil2(self)
	}
}


object poolYui inherits Personaje(armamento = armamentoYui)
{
	method image() = "yui_"+ direccion +".png"

}

object zipmata inherits Personaje(armamento = armamentoZipmata)
{
	method image() = "char_"+direccion+".png"
}