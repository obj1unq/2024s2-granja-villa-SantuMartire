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
//Error, no suma el oro por alguna razon
	method vender(){ 
		self.validarSiPuedeVender()
		oro += plantasCultivadas.sum({planta => planta.valor()})
		plantasCultivadas.clear()
	}

	method validarSiPuedeVender(){
		if (plantasCultivadas.isEmpty()){
			self.error("No hay nada para vender")
		}
}

method verEstadisticas(){
	game.say(self, "Tengo "+ oro +" monedas de oro y todavia puedo vender " + plantasCultivadas.size() + " plantas")
}

//---------------------------------ASPERSOR---------------------------------------
//Error, riega a los costados por alguna razon
	method ponerAspersor(){
		self.validarSiPuedePonerAspersor()
		const aspersor = new Aspersor(position = self.position())
		game.addVisual(aspersor)
		game.schedule(1000,	aspersor.regarCostados(position))
} 

	method validarSiPuedePonerAspersor(){
		if(self.hayPlantaAca()){
			self.error("No puedo poner un aspersor aca")
		}
	}

}