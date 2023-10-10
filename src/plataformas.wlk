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
	
	const property imagep = "assets/plataforma.png"
	const property position
	
}

class Nivel inherits Plataforma{
	
	var property plataformas = []
	var property plataforma
	
	
	
	//method background()
	//{
	//	game.boardGround(image)
	//}
	
	
	
	method crearPlataforma(inicio,fin,altura){	//agregar un parametro mas en caso de que hayan otros estilos de plataforma
		(inicio..fin).forEach({numero => plataformas.add(new Plataforma(imagep="assets/plataforma.png",position=game.at(numero,altura)))})
	}
	
	method crearPlataformas(){}
	
	
		
	method nuevoSuelo(){
		plataformas.forEach({p => game.addVisual(imagep)})
			
	}
	
}


object escenarioUno inherits Nivel{
//	override method 
	


	
	method creoPlataformas(){
		
		self.crearPlataforma(0,15,0)
		self.nuevoSuelo()
		self.crearPlataforma(5,10,5)
		self.nuevoSuelo()
		
	}
//	override method crearEscaleras(){ PARA CREAR ESCALERAS MAS ADELANTE
//		self.crearEscalera(1,5,4)
//		self.crearEscalera(1,5,11)
//	}
//	
	
}



