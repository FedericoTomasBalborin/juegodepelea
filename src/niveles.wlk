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
	var property seleccion
	
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
	
	method seleccionar(quien){
		seleccion = quien
		self.bloquearMovimiento()
	}
	
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
		keyboard.enter().onPressDo{seleccionPersonajes.iniciar()}
		
		
	}
}

object seleccionPersonajes{
	var property zela = new PoolYui(position=game.at(5,4), armamento = null)
	var property morh = new Zipmata(position=game.at(7,4), armamento = null)
	var property asta = new Personaje(position=game.at(9,4), armamento = null)
	
	var property marco1 = new Marco(position = game.at(5,4), image = "marco1.png", x1 = 5, x2 = 10, seleccion = null)
	var property marco2 = new Marco(position = game.at(7,4), image = "marco2.png", x1 = 5, x2 = 10, seleccion = null)
	
	var property jugador1Ok = false
	var property jugador2Ok = false
	
	method iniciar(){
		game.clear()
		game.addVisual(new Fondo(image="instrucciones.png"))
		self.agregarPersonajes()
		self.agregarTeclas()
		
	}
	
	method agregarPersonajes(){
		game.addVisual(new Fondo(image="seleccion.png"))
		game.addVisual(zela)
		game.addVisual(morh)
		game.addVisual(asta)
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
									marco1.seleccionar(game.uniqueCollider(marco1))
									//jugador1.asignarPersonaje(marco1.seleccion()) NO ANDA TODAVIA
									jugador1Ok = true
									if (self.seleccionPersonajesOk()){nivel1.iniciar()}
									}}
			
		}
		
		keyboard.left().onPressDo{if (marco2.movimiento()) {marco2.irAizquierda(marco2.position().left(2))}}
		keyboard.right().onPressDo{if (marco2.movimiento()) {marco2.irAderecha(marco2.position().right(2))}}
		keyboard.l().onPressDo{if (marco2.movimiento()){
								if (not (marco1.position()==marco2.position())) {
								marco2.bloquearMovimiento()
								marco2.seleccionar(game.uniqueCollider(marco2))
								//jugador2.asignarPersonaje(marco2.seleccion()) NO ANDA TODAVIA
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
		escenarioUno.creoPlataformas()
		jugador1.controles()
		jugador1.escogerPersonaje()
		jugador2.controles()
		jugador2.escogerPersonaje()
		visualesGeneral.agregar()
		colisiones.validar()
	}
}