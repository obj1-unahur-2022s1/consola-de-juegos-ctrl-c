import wollok.game.*

// cambie la nave por un objeto ya que es una unica nave en el juego.
object nave {
	var property position = game.at(game.width().div(2),0)
	const property image='nave.png'
	const property speed = 1
	const property hp = 10
	
	// movimiento de derecha a izquierda.
	method moverDerecha(){
		self.position(self.position().right(speed))
	}
	
	method moverIzquierda(){
		self.position(self.position().left(speed))
	}
	
	// el disparo de la nave y el movimeinto del disparo.
	method disparar(){
		var disparo = new Disparo (position = self.position().up(1))
		
		game.addVisual(disparo)
		
		game.onTick(100, 'movimientoDisparo', {
			disparo.movement()
			disparo.disparoFuera()
		})
	}
}

class Disparo {
	var property position
	var property image = 'disparo.png'
	
	// movimiento para arriba constante del disparo.
	method movement() { self.position( position.up(1) ) }
	
	// cuando sale del marco del juego se termina de repetir el movimiento (igual creo q tambien tendria que borrarlo)
	method disparoFuera() { if ([-1, 12].contains(position.y())) game.removeTickEvent('movimientoDisparo') }
  	
  	// una prueba con la colicion del disparo y el alien, pero al ser ambos clases nose me sale.
  	/*method darEnAlien(unAlien) { game.onCollideDo(unAlien, unAlien.degragadarHp()) }*/
}

class Alien {
	var property position
	var property image = 'alienVerde.png'
	var property hp = 3
	
	// el alien pierde uno de hp al recibir un disparo.
	method recibirDisparo() { hp = 0.max(hp - 1) }
	
	// ademas de perder hp, cambia de color.
	method degragadarHp() {
		if (hp == 3) { 
			self.recibirDisparo()
			image = 'alienNaranja.png'
		}
		else if (hp == 2) { 
			self.recibirDisparo()
			image = 'alienRosa.png'
		}
		else { 
			self.recibirDisparo()
			game.removeVisual(self)
		}	
	}
}
