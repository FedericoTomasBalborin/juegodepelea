import wollok.game.*
import proyectiles.*

object personaje
{
	var property direccion = "der" //La orientacion a donde el personaje esta apuntando. Puede ser izquierda (izq) o derecha (der)
	var property position = game.origin()
	method image() = "char_"+ direccion +".png"
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
	method enElSuelo()=self.position().y()==0
	
	method disparar()
	{
		const proyectil = new Disparo(position = self.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento()
		game.schedule(750,{=> game.removeVisual(proyectil)})
	}
	
}

object jugador
{
	method movimiento()
	{
		keyboard.left().onPressDo({personaje.retroceder()})
		keyboard.right().onPressDo({personaje.avanzar()})
		keyboard.up().onPressDo({personaje.volar()})
		game.onTick(500,"fall",{=> personaje.caer()})
	}
	method disparar()
	{
		keyboard.x().onPressDo({personaje.disparar()})
	}
}