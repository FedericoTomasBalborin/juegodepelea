import wollok.game.*
import personajes.*
class Disparo
{
	const shooter=personaje
	const property image = "shoot.png"
	var property position
	
	method moverIzq()
	{
		position = self.position().left(1)
	}
	method moverDer()
	{
		position = self.position().right(1)
	}
	method detenerMovimiento()
	{
		game.schedule(500,{game.removeTickEvent("moverse")})
	}
	
	method evaluarComportamiento()
	{
		if(shooter.direccion() == "der")
		{
			self.comportamientoDerecha()
		}
		else
		{
			self.comportamientoIzquierda()
		}
	}
	
	
	method comportamientoIzquierda()
	{
		game.onTick(100,"moverse",{=> self.moverIzq()})
		self.detenerMovimiento()
	}
	method comportamientoDerecha()
	{
		game.onTick(100,"moverse",{=> self.moverDer()})
		self.detenerMovimiento()
	}
}