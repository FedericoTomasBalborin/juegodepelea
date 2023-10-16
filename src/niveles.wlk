import wollok.game.*
import personajes.*
import plataformas.*
import extras.*

class Fondo{
	const property position = game.origin()
	var property image 
}

class Marco{
	var property position
	var property image
	var property movimiento = true
	var x1
	var x2
	
	method bloquearMovimiento(){
		movimiento = false
	}
	
	method irAderecha(nuevaPosicion){
		if (self.validarRango(nuevaPosicion)){
			position = nuevaPosicion
		}
	}
	
	method irAizquierda(nuevaPosicion){
		if (self.validarRango(nuevaPosicion)){
			position = nuevaPosicion
		}
	}
	
	method validarRango(nuevaPosicion){
		return nuevaPosicion.x().between(x1,x2)
	}
	
}

class Escenario{
	var property position
	var property image
}

object portada{
	method iniciar(){
		game.addVisual(new Fondo(image="portada.png"))
		keyboard.enter().onPressDo{instrucciones.iniciar()}
	}
}

object instrucciones{
	method iniciar(){
		game.clear()
		game.addVisual(new Fondo(image="instrucciones.png"))
		keyboard.enter().onPressDo{seleccionEscenarios.iniciar()}
		
		
	}
}

object seleccionEscenarios{
	const property bosque 	= new Escenario(position = game.at(2,3), image = "bosqueSmall.png" )
	const property desierto = new Escenario(position = game.at(6,3), image = "desiertoSmall.png")
	const property castillo = new Escenario(position = game.at(10,3), image = "castilloSmall.png")
	const property futuro 	= new Escenario(position = game.at(14,3), image = "futureSmall.png")
	const property marco3   = new Marco(position = game.at(2,3), image = "marco3.png", x1 = 2, x2 = 16)
	
	var property cualFondo
	
	method iniciar(){
		game.clear()
		game.addVisual(new Fondo(image="negro.png"))
		self.agregarEscenarios()
		self.agregarTeclas()
	}
	
	method agregarEscenarios(){
		game.addVisual(bosque)
		game.addVisual(desierto)
		game.addVisual(castillo)
		game.addVisual(futuro)
		game.addVisual(marco3)//y agregamos marco ya que estamos
		game.hideAttributes(bosque)
		game.hideAttributes(desierto)
		game.hideAttributes(castillo)
		game.hideAttributes(futuro)
		game.hideAttributes(marco3)
	}
	
	method agregarTeclas(){
		keyboard.enter().onPressDo{if (marco3.movimiento()){
									marco3.bloquearMovimiento()
									cualFondo = game.uniqueCollider(marco3)
									seleccionPersonajes.iniciar()
									}}
		keyboard.left().onPressDo{if (marco3.movimiento()) {marco3.irAizquierda(marco3.position().left(4))}}
		keyboard.right().onPressDo{if (marco3.movimiento()) {marco3.irAderecha(marco3.position().right(4))}}
	}
	
}

object seleccionPersonajes{
	var property p1 = new PoolYui(position=game.at(5,4), armamento = null)
	var property p2 = new Zipmata(position=game.at(7,4), armamento = null)
//	var property asta = new Personaje(position=game.at(9,4), armamento = null)
	
	var property marco1 = new Marco(position = game.at(5,4), image = "marco1.png", x1 = 5, x2 = 10)
	var property marco2 = new Marco(position = game.at(7,4), image = "marco2.png", x1 = 5, x2 = 10)
	
	var property jugador1Ok = false
	var property jugador2Ok = false
	
	var property quienJugador1 
	var property quienJugador2
	
	method iniciar(){
		game.clear()
		game.addVisual(new Fondo(image="instrucciones.png"))
		self.agregarPersonajes()
		self.agregarTeclas()
		
	}
	
	method agregarPersonajes(){
		game.addVisual(new Fondo(image="seleccion.png"))
		game.addVisual(p1)
		game.addVisual(p2)
//		game.addVisual(asta)
		game.addVisual(marco1)//y agregamos marcos ya que estamos
		game.addVisual(marco2)
	}
	
	method agregarTeclas(){
		keyboard.enter().onPressDo{self.iniciar()}
		keyboard.a().onPressDo{if (marco1.movimiento()){marco1.irAizquierda(marco1.position().left(2))}	}
		keyboard.d().onPressDo{if (marco1.movimiento()) {marco1.irAderecha(marco1.position().right(2))}}
		keyboard.e().onPressDo{if (marco1.movimiento()){
			//Meter esto en un metodo
								if (not (marco1.position()==marco2.position())) {
									marco1.bloquearMovimiento()
									quienJugador1 = game.uniqueCollider(marco1)
									jugador1Ok = true
									if (self.seleccionPersonajesOk()){nivel1.iniciar()}
									}}
			
		}
		
		keyboard.left().onPressDo{if (marco2.movimiento()) {marco2.irAizquierda(marco2.position().left(2))}}
		keyboard.right().onPressDo{if (marco2.movimiento()) {marco2.irAderecha(marco2.position().right(2))}}
		keyboard.l().onPressDo{if (marco2.movimiento()){
								if (not (marco1.position()==marco2.position())) {
								marco2.bloquearMovimiento()
								quienJugador2 = game.uniqueCollider(marco2)
								jugador2Ok = true
								if (self.seleccionPersonajesOk()){nivel1.iniciar()}
								}}
			
		}
	}
	
	method seleccionPersonajesOk(){
		return (jugador1Ok and jugador2Ok)
	}	
}


object colisiones
{
	method validar()
	{
		game.onCollideDo(jugador1.personaje(),{piso => piso.subir(jugador1.personaje())})
		game.onCollideDo(jugador2.personaje(),{piso => piso.subir(jugador2.personaje())})
		//agregar collides de los poderes
	}
}


object visualesGeneral
{
	method agregar()
	{
		game.addVisualIn(vida, game.at(1, 9))
		game.addVisualIn(vida2, game.at(17, 9))
	}
}

object nivel1
{
	method iniciar()
	{
		game.clear()
		
		self.asignarPersonajes()
		game.addVisual(new Fondo(image=seleccionEscenarios.cualFondo().image().toString().replace("Small", "")))
		
		escenarioUno.creoPlataformas()
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		
		jugador1.controles()
		jugador2.controles()
		visualesGeneral.agregar()
		colisiones.validar()
	}
	
	method asignarPersonajes(){
		jugador1.asignarPersonaje()
		jugador2.asignarPersonaje()
	}
}