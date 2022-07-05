import wollok.game.*
import consola.*
import personajes.*
import visual.*

class Juego {	
	var property color = null
	var property position = null
		
	method spaveInvader() {
		// creacion de aliens que no nos gusta del todo.
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
		
		var aliens = [alien1, alien2, alien3, alien4, alien5, alien6, alien7, alien8, alien9, alien10,
			alien11, alien12, alien13, alien14, alien15, alien16, alien17, alien18, alien19, alien20, alien21]
		
		game.clear()
		game.addVisual(inicioDelJuego)
		
		// agregando todos los personajes
		game.addVisual(nave)
		aliens.forEach({ a => game.addVisual(a) })
		
		// cerrar el juego
		keyboard.q().onPressDo ({
			game.clear()
			consola.iniciar()
		})
		
		//movimiento de los aliens
		aliens.forEach({ a => a.movimientoAliens() })
		
		//movimiento de la nave, frenando en los limites de la pantalla
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
		game.onTick(500, 'disparar', { nave.disparar() })
		
		/*keyboard.x().onPressDo ({ 
			nave.disparar()
		})*/
		
		keyboard.p().onPressDo ({ 
			aliens.clear()
			aliens.add(alien1) 		
		})

		
		// Revisamos condiciones para finalizar la partida	
		game.onTick(0.1, 'condicionVictoria', {
			if (aliens.size()*100 == nave.puntaje()){
				game.clear()
				game.addVisual(winner)
				self.terminar()
			}
			
			if (nave.hp() == 0){
				game.clear()
				game.addVisual(gameOver)
				self.terminar()
				/*aliens.anyOne().victoria()*/
			}
		})
		
		// Agregamos el puntaje en pantalla
		game.addVisual(object{method position()= game.at(1,game.height()-1) method text() = 
		"SCORE:" + nave.puntaje()})
		
		// Agregamos la vida de la nave en pantalla
		game.addVisual(object{method position()= game.at(game.width()-1,game.height()-1) method text() = 
		"HP:" + nave.hp() })
			
		//Disparos de los aliens
		/*game.onTick(1000, 'disparoAlien', {
			aliens.anyOne().disparar()
		})*/
		

	}
	
	method iniciar() {
		game.addVisual(object{method position()= game.center() method text() = "Juego "+color + " - <q> para salir"})
	}
	
	method image() = "juego" + color + ".png"
	
	method terminar() {
		keyboard.q().onPressDo ({
			/*consola.iniciar()*/
			consola.hacerTerminar(self)
			nave.puntaje(0)
			})
	}
}

object spaveInvader inherits Juego {
	
	override method iniciar() {
		// Sonido INTRO
		const intro = game.sound("sounds/introSound.mp3")
		game.addVisual(fondoDelJuego)
		if(!intro.played())
			intro.play()
		game.addVisual(object{method position()= game.at(8,4) method text() = 
		"SPAVE INVADERS\n
		INSTRUCCIONES: Utilice las flechas para mover su nave, 
		\nasegurese de disparar a todos los aliens\n
		\n
		<Enter> para empezar - <q> para salir"})
		
		keyboard.enter().onPressDo ({self.spaveInvader()})
		keyboard.q().onPressDo ({
			consola.iniciar()
			game.removeVisual(fondoDelJuego)
			intro.pause()
		})
	}
	
	override method image() = "logo.png"
}