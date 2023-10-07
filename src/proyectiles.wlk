import wollok.game.*
class Disparo
{
	var property position
	const property etiquetaTickMovement = "mover"+self.toString()
	method image() = "shoot.png"

	method colocarProyectil(_chara)
	{
		game.schedule(100,
			{=>
				game.addVisual(self)
				self.evaluarComportamiento(_chara)
			})
	}
	
	method moverIzq()
	{
		position = self.position().left(1)
	}
	method moverDer()
	{
		position = self.position().right(1)
	}
	method fueraDeRango() = (not self.position().x().between(1,18) or not self.position().y().between(0,8))
	//elimina los proyectiles fuera de rango
	method automaticSelfDestruction()
	{
		if(self.fueraDeRango())
		{
			self.detenerMovimiento()
		}
	}

	//Ocurre durante las colisiones
	method detenerMovimiento()
	{
		game.removeTickEvent(etiquetaTickMovement)
		game.removeVisual(self)
	}

	method evaluarComportamiento(_chara)
	{
		if(_chara.direccion() == "der")	{self.comportamientoDerecha()}
		else							{self.comportamientoIzquierda()}
	}
	method comportamientoIzquierda()
	{
		game.onTick(100,etiquetaTickMovement,{=> self.moverIzq()})
	}
	method comportamientoDerecha()
	{
		game.onTick(100,etiquetaTickMovement,{=> self.moverDer()})
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
		game.onTick(100,etiquetaTickMovement,{=> self.moverArriba()})
	}
	method comportamientoAbajo()
	{
		game.onTick(100,etiquetaTickMovement,{=> self.moverAbajo()})
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
	override method comportamientoDerecha()
	{
		game.onTick(100,etiquetaTickMovement,{=> self.moverDer()})
	}
	override method comportamientoIzquierda()
	{
		game.onTick(100,etiquetaTickMovement,{=> self.moverIzq()})
	}
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
		proyectil.colocarProyectil(_chara)
		game.schedule(1000,{proyectil.automaticSelfDestruction()})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new DisparoDiagonalWarped(position = _chara.position())
		proyectil.colocarProyectil(_chara)
		game.schedule(1000,{proyectil.automaticSelfDestruction()})
	}
}

object armamentoYui //poolYui dispara de forma horizontal y vertical
{
	method dispararProyectil1(_chara)
	{
		const proyectil = new Disparo(position = _chara.position())
		proyectil.colocarProyectil(_chara)
		game.schedule(1000,{proyectil.automaticSelfDestruction()})
	}
	method dispararProyectil2(_chara)
	{
		const proyectil = new DisparoVertical(position = _chara.position())
		proyectil.colocarProyectil(_chara)
		game.schedule(1000,{proyectil.automaticSelfDestruction()})
	}
}