import wollok.game.*
import cultivos.*

object hector {
	var property position 				= game.center()
	const property image 				= "player.png"
	const property plantasCultivadas 	= []
	const property plantasSembradas 	= []
	var property oro 					= 0

//---------------------------------SIEMBRA---------------------------------------

	method sembrar(planta){
		self.validarSiPuedeSembrar()
		planta.position(position)
		game.addVisual(planta)
		plantasSembradas.add(planta)
	} 

	method validarSiPuedeSembrar(){
		if(self.hayPlantaAca()){
			self.error("No puedo plantar ahi")
		}
	}

	//method hayPlantaAca(pos){
	//	return (game.getObjectsIn(pos).size() != 1)
	//}

	method hayPlantaAca(){
		return (game.colliders(self).size() == 1)
	}

//---------------------------------RIEGO---------------------------------------

	method regar(){
		self.validarSiPuedeRegar()
		const cultivo = game.uniqueCollider(self)
		cultivo.riego()
	}

	method validarSiPuedeRegar(){
		if(not self.hayPlantaAca()){
			self.error("No puedo regar aca")
		}
	}

//---------------------------------COSECHA---------------------------------------

	method cosechar(){
		self.validarSiPuedeCosechar(self.position())
		const planta = game.uniqueCollider(self)
		self.agregarCultivo(planta)
		planta.cosechar()
	}

	method validarSiPuedeCosechar(posicion){
		if((not self.hayCultivosParaCosechar(posicion))){
			self.error("No puedo cosecharla todavia")
		}
	}

	method hayCultivosParaCosechar(pos){
		return self.hayPlantaAca() and 
				plantasSembradas.find({planta => planta.position() == self.position()}).listoParaCosecha()
	}

	method agregarCultivo(planta){
		plantasCultivadas.add(planta)
	}

//---------------------------------VENTA---------------------------------------

method vender(){

}


}