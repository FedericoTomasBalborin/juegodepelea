import wollok.game.*



object fondo
{
	const image = "fondo.jpg"
	method background()
	{
		game.boardGround(image)
	}
}


class Plataforma {
	
	const property image
	const property position
	
	method nuevoSuelo(){
		
		
	}
	
}

class Nivel {
	
	var property plataformas = []
	const property image = ""
	
	method background()
	{
		game.boardGround(image)
	}
	
	method crearPlataforma(inicio,fin,altura){	//agregar un parametro mas en caso de que hayan otros estilos de plataforma
		(inicio..fin).forEach({numero => plataformas.add(new Plataforma(image="assets/plataforma.png",position=game.at(numero,altura)))})
	}
	
	method crearPlataformas(){}
}


object escenarioUno inherits Nivel{
//	override method 

	override method crearPlataformas(){
		self.crearPlataforma(0,15,0)
		self.crearPlataforma(5,10,5)
	}
//	override method crearEscaleras(){ PARA CREAR ESCALERAS MAS ADELANTE
//		self.crearEscalera(1,5,4)
//		self.crearEscalera(1,5,11)
//	}
//	override method time()=512
	
}
