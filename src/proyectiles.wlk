import wollok.game.*
import personajes.*
class Disparo
{
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
	
	method evaluarComportamiento(_chara)
	{
		if(_chara.direccion() == "der")
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
		game.onTick(50,"moverse",{=> self.moverIzq()})
		self.detenerMovimiento()
	}
	method comportamientoDerecha()
	{
		game.onTick(50,"moverse",{=> self.moverDer()})
		self.detenerMovimiento()
	}
}

class DisparoHorizontal inherits Disparo
{
	method moverArriba()
	{
		position = self.position().up(1)
	}
	method comportamientoUnico()
	{
		game.onTick(75,"moverse",{=> self.moverArriba()})
		self.detenerMovimiento()
	}
	override method evaluarComportamiento(_chara)
	{
		self.comportamientoUnico()
	}
}

object armamentoYui
{
	method dispararProyectil1(_chara)
	{
		const proyectil = new Disparo(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(500,{=> game.removeVisual(proyectil)})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new DisparoHorizontal(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(500,{=> game.removeVisual(proyectil)})
		
	}
}




