import wollok.game.*
import juego.*

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
	
	// el disparo de la nave y el movimiento del disparo.
	method disparar(){
		var disparo = new Disparo (position = self.position().up(1))
		
		game.addVisual(disparo)
		
		game.onTick(100, 'movimientoDisparo', {
			disparo.movement()
			disparo.disparoFuera()
		})
		
		game.whenCollideDo(disparo, { alien1 => 
			alien1.recibirDisparo() 
			alien1.checkHp()
			disparo.remover()
		} )
	}
}

class Disparo {
	var property position
	var property image = 'disparo.png'
	
	// movimiento para arriba constante del disparo.
	method movement() { self.position( position.up(1) ) }
	
	// cuando sale del marco del juego se elimina al elemento (trae un error si se dispara mucho seguido)
	method disparoFuera() { if ([-1, game.height()].contains(position.y())) self.remover() }
	
	method remover() = game.removeVisual(self)
  	
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
	method checkHp() {
		if (hp == 2) { 
			image = 'alienNaranja.png'
		}
		else if (hp == 1) { 
			image = 'alienRosa.png'
		}
		else { 
			game.removeVisual(self)
		}	
	}
}
