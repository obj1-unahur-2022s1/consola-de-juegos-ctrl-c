import wollok.game.*
import consola.*
import personajes.*
import visual.*

class Juego {
	/*
	var property position = null
	var property color 
	
	
	}	
	
	method terminar(){

	}
	method image() = "juego" + color + ".png"
	*/
	
		
	var property color
	var property position = null
	
	
		
	method spaveInvader() {
		//game.stopAllSounds()
		// creacion de aliens que no me gusta del todo.
		var alien1 = new Alien (position = game.at(5,11))
		var alien2 = new Alien (position = game.at(5,10))
		var alien3 = new Alien (position = game.at(5,9))
		var alien4 = new Alien (position = game.at(6,11))
		var alien5 = new Alien (position = game.at(6,10))
		var alien6 = new Alien (position = game.at(6,9))
		var alien7 = new Alien (position = game.at(7,11))
		var alien8 = new Alien (position = game.at(7,10))
		var alien9 = new Alien (position = game.at(7,9))
		var alien10 = new Alien (position = game.at(8,11))
		var alien11 = new Alien (position = game.at(8,10))
		var alien12 = new Alien (position = game.at(8,9))
		var alien13 = new Alien (position = game.at(9,11))
		var alien14 = new Alien (position = game.at(9,10))
		var alien15 = new Alien (position = game.at(9,9))
		var alien16 = new Alien (position = game.at(10,11))
		var alien17 = new Alien (position = game.at(10,10))
		var alien18 = new Alien (position = game.at(10,9))
		var alien19 = new Alien (position = game.at(11,11))
		var alien20 = new Alien (position = game.at(11,10))
		var alien21 = new Alien (position = game.at(11,9))
		
		game.clear()
		game.addVisual(inicioDelJuego)
		
		// agregando todos los personajes
		game.addVisual(nave)
		game.addVisual(alien1)	game.addVisual(alien8)	game.addVisual(alien15)
		game.addVisual(alien2)	game.addVisual(alien9)	game.addVisual(alien16)
		game.addVisual(alien3)	game.addVisual(alien10)	game.addVisual(alien17)
		game.addVisual(alien4)	game.addVisual(alien11)	game.addVisual(alien18)
		game.addVisual(alien5)	game.addVisual(alien12)	game.addVisual(alien19)
		game.addVisual(alien6)	game.addVisual(alien13)	game.addVisual(alien20)
		game.addVisual(alien7)	game.addVisual(alien14)	game.addVisual(alien21)
		
		// movimiento de la nave, frenando en los limites de la pantalla
		keyboard.left().onPressDo ({
			if (nave.position().x() > 0 ) {
				nave.moverIzquierda()
			}
		})	
		
		keyboard.right().onPressDo ({
			if (nave.position().x() < game.width() -1 ) {
				nave.moverDerecha()
			}
		})
		
		// disparo de la nave
		keyboard.x().onPressDo ({ nave.disparar() })
		
	}
	
	method iniciar() {
		// Sonido INTRO
		const intro = game.sound("Sounds/introSound.mp3")
		game.addVisual(fondoDelJuego)
		if(!intro.played())
			intro.play()
		game.addVisual(object{method position()= game.at(8,4) method text() = 
		"SPAVE INVADERS\n
		INSTRUCCIONES: Utilice las flechas para mover su nave, 
		\nasegurese de disparar con la X a todos los aliens\n
		\n
		<Enter> para empezar - <q> para salir"})
		
		keyboard.enter().onPressDo ({self.spaveInvader()})
		keyboard.q().onPressDo ({self.terminar()})
	}
	
	method image() = "logo.png"
	
	method terminar() { game.stop() }
}
