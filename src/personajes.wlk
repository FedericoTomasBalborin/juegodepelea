import wollok.game.*
import proyectiles.*

object poolYui
{
	var property direccion = "der" //La orientacion a donde el personaje esta apuntando. Puede ser izquierda (izq) o derecha (der)
	var property position = game.origin()
	const armamento=armamentoYui
	method image() = "yui_"+ direccion +".png"

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
	
	method disparo1()
	{
		armamento.dispararProyectil1(self)
	}
	method disparo2()
	{
		armamento.dispararProyectil2(self)
	}
}

object jugador
{
	const listaDePersonajes = [poolYui]
	var personaje
	method escogerPersonaje()
	{
		personaje = listaDePersonajes.get(0)
		game.addVisual(personaje)
	}
	method movimiento()
	{
		keyboard.a().onPressDo({personaje.retroceder()})
		keyboard.d().onPressDo({personaje.avanzar()})
		keyboard.w().onPressDo({personaje.volar()})
		game.onTick(500,"caida",{=> personaje.caer()})
	}
	method disparar()
	{
		keyboard.j().onPressDo({personaje.disparo1()})
		keyboard.k().onPressDo({personaje.disparo2()})
	}
}