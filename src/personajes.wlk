import wollok.game.*
import juego.*
import visual.*
import consola.*

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
		var disparo = new Disparo (position = self.position().up(1), color= 'Verde')
		
		// Sonido disparo
		const shoot = game.sound("Sounds/disparo_laser.mp3")
		const mePego = game.sound("Sounds/cambio_color.mp3")
		if(!shoot.played())
				shoot.play()
		
		game.addVisual(disparo)
		
		game.onTick(100, 'movimientoDisparo', {
			disparo.movementUp()
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
	const property color
	var property image = 'disparo'+color+'.png'
	
	// movimiento para arriba constante del disparo.
	method movementUp() { self.position( position.up(1) ) }
	
	// movimiento para abajo constante del disparo.
	method movementDown() { self.position( position.down(1) ) }
	
	// cuando sale del marco del juego se elimina al elemento (trae un error si se dispara mucho seguido)
	method disparoFuera() { if ([-1, game.height()].contains(position.y())) self.remover() }
	
	method remover() {
		game.removeTickEvent('movimientoDisparo')
		game.removeVisual(self)
	}
}

class Alien {
	var property position
	var property image = 'alienVerde.png'
	var property hp = 3
	var property direccion = 'derecha'

	const mePego = game.sound("Sounds/cambio_color.mp3")
	const mePego2 = game.sound("Sounds/Le_pega.mp3")
	const meMato = game.sound("Sounds/muere_bicho.mp3")
	
	//Cuando ganan los aliens
	method victoria() {		
		game.clear()
        game.addVisual(gameOver)
	}
	
	// el alien pierde uno de hp al recibir un disparo.
	method recibirDisparo() { hp = 0.max(hp - 1) }
	
	// ademas de perder hp, cambia de color.
	method checkHp() {
		if (hp == 2) { 
			image = 'alienNaranja.png'
			mePego2.play()
		}
		else if (hp == 1) { 
			image = 'alienRosa.png'
			mePego.play()
		}
		else { 
			if(!meMato.played())
				meMato.play()
			game.removeVisual(self)
			game.removeTickEvent('movimientoAlien')
		}	
	}
	
	// movimiento de los aliens de esquina izquierda a esquina derecha.
	method movimientoAliens() {
		game.onTick(600, 'movimientoAlien', {
			self.movimientoAlien()
		})
	}
	
	// mueve al alien a la izquierda hasta el limite, despues lo lleva para la derecha. en ves de hacer eso aparece por el otro lado.
	method movimientoAlien() {
		if (direccion == 'derecha'){
			self.position(self.position().right(1))
		}else{
			self.position(self.position().left(1))
		}
		if (self.position().x() == 0 || self.position().x() == game.width()-1){
			self.moverAbajoSiPuede()
			self.cambiarDireccion()
		}
	}
	
	// si pueden bajan una posición, si llegan a la altura de la nave es game over
	method moverAbajoSiPuede() {
        if(self.position().y() > nave.position().y()) {
        	self.position(self.position().down(1))
        }
        else { 
            self.victoria()
         }
    }
    
    method cambiarDireccion() { if (direccion == 'derecha') {direccion = 'izquierda'} else {direccion = 'derecha'} }
    
    method disparar(){
		const disparo = new Disparo (position = self.position().down(1), color= 'Rojo')
		
		game.addVisual(disparo)
		
		game.onTick(100, 'movimientoDisparo', {
			disparo.movementDown()
			disparo.disparoFuera()
		})
	}
}
