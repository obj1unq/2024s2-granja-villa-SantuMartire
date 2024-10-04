import wollok.game.*
import cultivos.*

object hector {
	var property position = game.center()
	const property image = "player.png"

	//Siembra
	method sembrar(planta){
		validarSiPuedeSembrar()
		planta.position(position)
		game.addVisual(planta)
	} 

	method validarSiPuedeSembrar(){
		if(hayPlantaAca()){
			self.error("No puedo plantar aca")
		}
	}

	method hayPlantaAca(){
		return (not(game.colliders(self.position()).isEmpty()))
	}

	//Riego
	method regar(){
		validarSiPuedeRegar()
		const cultivo = game.uniqueCollider(self)
		cultivo.riego()
	}

	method validarSiPuedeRegar(){
		if(not hayPlantaAca()){
			self.error("No puedo regar aca")
		}
	}

}