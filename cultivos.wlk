import wollok.game.*
import hector.*

//---------------------------------MAIZ---------------------------------------
class Maiz {
	var property image  	= "corn_baby.png"
	var esAdulto 			= false
	var property position 	= null
	const property valor 	= 150

	method riego(){
		self.image("corn_adult.png")
		esAdulto = true
	} 

	method listoParaCosecha(){
		return esAdulto
	}

	method cosechar(){
		hector.plantasSembradas().remove(self)
		game.removeVisual(self)
	}
}

//---------------------------------TRIGO---------------------------------------

class Trigo {
	var fase 			 	= 0
	var property position 	= null
	method valor(){ (fase - 1) * 100}

	method image() = ("wheat_"+ fase +".png")

	method riego(){
		if(fase == 3) {fase = 0} else {fase +=1}
	}

	method listoParaCosecha(){
		return fase >= 2
	}

	method cosechar(){
		hector.plantasSembradas().remove(self)
		game.removeVisual(self)
	}
}

//---------------------------------TOMACO---------------------------------------

class Tomaco {
	var property position 	= null
	const property valor 	= 150

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco_baby.png"
	}

	method riego(){
		if(self.position().y() < (game.height()-1)){
			self.subir()
		}
	}

	method subir() {
    position = position.up(1)
	}

	method listoParaCosecha(){
		return true
	}

	method cosechar(){
		hector.plantasSembradas().remove(self)
		game.removeVisual(self)
	}
}

//---------------------------------ASPERSOR---------------------------------------

class Aspersor{
	var property position 	= null

	method image() = ("aspersor.png")

	method regarCostados(pos){
		self.regarArriba(pos)
		self.regarAbajo(pos)
		self.regarIzq(pos)
		self.regarDer(pos)
	}

	method regarArriba(pos){
		//position =  pos.up(1)
		const cultivo = game.uniqueCollider(pos.up(1))
		cultivo.riego()
	}

	method regarAbajo(pos){
		// position =  pos.down(1)
		const cultivo = game.uniqueCollider(pos.down(1))
		cultivo.riego()
	}

	method regarIzq(pos){
		// position =  pos.left(1)
		const cultivo = game.uniqueCollider(pos.left(1))
		cultivo.riego()
	}

	method regarDer(pos){
		// position =  pos.right(1)
		const cultivo = game.uniqueCollider(pos.right(1))
		cultivo.riego()
	}

	method riego(){
		
	}
}