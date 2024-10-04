import wollok.game.*
import hector.*

class Maiz {
	var property image = "corn_baby.png"
	var property position = game.at(1, 1)
	
	method riego(){
		self.image("corn_adult.png")
	} 
}

class Trigo {
	var fase = 0
	method image() = ("wheat_"+ fase +".png")
	var property position = game.at(2, 1)
	
	method riego(){
		if(fase == 4) {fase = 0} else {fase +=1}
	}
}

class Tomaco {
	var property position = game.at(3, 1)

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco_baby.png"
	}

	method riego(){
		if(self.position().y() < game.height()){
			subir()
		}
	}

	method subir() {
    position = position.up(1)
}
}