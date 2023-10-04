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

class DisparoArriba inherits Disparo
{
	method moverArriba()
	{
		position = self.position().up(1)
	}
	method comportamientoVertical()
	{
		game.onTick(75,"moverse",{=> self.moverArriba()})
	}
	override method evaluarComportamiento(_chara)
	{
		self.comportamientoVertical()
		self.detenerMovimiento()
	}
}

class DisparoAbajo inherits Disparo
{
	method moverAbajo()
	{
		position = self.position().down(1)
	}
	method comportamientoVertical()
	{
		game.onTick(75,"moverse",{=> self.moverAbajo()})
	}
	override method evaluarComportamiento(_chara)
	{
		self.comportamientoVertical()
		self.detenerMovimiento()
	}
}

class DisparoDiagonal inherits Disparo
{
	override method moverIzq()
	{
		position = self.position().up(1)
		super()
	}
	override method moverDer()
	{
		position = self.position().up(1)
		super()
	}
}

class DisparoDiagonalWarped inherits DisparoDiagonal
{
	override method moverIzq()
	{
		position = self.position().up(1)
		super()
	}
	override method moverDer()
	{
		position = self.position().up(1)
		super()
	}
}

//Armamentos
object armamentoYui
{
	method dispararProyectil1(_chara)
	{
		const proyectil = new DisparoDiagonal(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new DisparoDiagonalWarped(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
		
	}
}

object armamentoZipmata
{
	method dispararProyectil1(_chara)
	{
		const proyectil = new DisparoArriba(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new DisparoAbajo(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
		
	}
}
