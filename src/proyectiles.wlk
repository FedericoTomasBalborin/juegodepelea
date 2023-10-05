import wollok.game.*
import personajes.*
class Disparo
{
	var property position
	const property etiquetaTickMovement = "mover"+self.toString()
	
	method image() = "shoot.png"
	
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
		game.schedule(500,{game.removeTickEvent(etiquetaTickMovement)})
	}
	
	method evaluarComportamiento(_chara)
	{
		if(_chara.direccion() == "der")	{self.comportamientoDerecha()}
		else							{self.comportamientoIzquierda()}
	}
	method comportamientoIzquierda()
	{
		game.onTick(75,etiquetaTickMovement,{=> self.moverIzq()})
		self.detenerMovimiento()
	}
	method comportamientoDerecha()
	{
		game.onTick(75,etiquetaTickMovement,{=> self.moverDer()})
		self.detenerMovimiento()
	}
}

class DisparoVertical inherits Disparo
{
	method moverArriba()
	{
		position = self.position().up(1)
	}
	method moverAbajo()
	{
		position = self.position().down(1)
	}
	method comportamientoArriba()
	{
		game.onTick(75,etiquetaTickMovement,{=> self.moverArriba()})
		self.detenerMovimiento()
	}
	method comportamientoAbajo()
	{
		game.onTick(75,etiquetaTickMovement,{=> self.moverAbajo()})
		self.detenerMovimiento()
	}
	method comportamientoVertical(_chara)
	{
		if(_chara.enElSuelo())	{self.comportamientoArriba()}
		else					{self.comportamientoAbajo()}
	}
	override method evaluarComportamiento(_chara)
	{
		self.comportamientoVertical(_chara)
	}
}

class DisparoDiagonal inherits DisparoVertical
{
	override method evaluarComportamiento(_chara)
	{
		if(_chara.direccion() == "der")	{self.comportamientoDerecha()}
		else							{self.comportamientoIzquierda()}
		super(_chara)
	}
}

class DisparoDiagonalWarped inherits DisparoDiagonal
{
	override method moverArriba()
	{
		position = self.position().up(2)
	}
	override method moverAbajo()
	{
		position = self.position().down(2)
	}
}

//Armamentos
object armamentoZipmata //ZIPmata solo dispara en diagonal y en una diagonal más empinada
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

object armamentoYui //poolYui dispara de forma horizontal y vertical
{
	method dispararProyectil1(_chara)
	{
		const proyectil = new DisparoVertical(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new Disparo(position = _chara.position())
		game.addVisual(proyectil)
		proyectil.evaluarComportamiento(_chara)
		game.schedule(750,{=> game.removeVisual(proyectil)})
	}
}
