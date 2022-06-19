import wollok.game.*
import consola.*
import personajes.*

class Juego {
	/*
	var property position = null
	var property color 
	
	method iniciar(){
        game.addVisual(object{method position()= game.center() method text() = "Juego "+color + " - <q> para salir"})		
	}
	
	method terminar(){

	}
	method image() = "juego" + color + ".png"
	*/
	var property color
	var property position = null
	
	method spaveInvader(){
		const nave = new Nave( position = game.at(game.width().div(2),0), image='nave.png', speed = 1 , hp = 10)
		
		game.clear()
		game.boardGround("space.jpg") /*probando cambiar el fondo, y fallando */
		game.ground("dino.png") /*probando cambiar el fondo, y fallando */
		game.addVisual(nave)
			
		keyboard.left().onPressDo ({nave.moverIzquierda()})	
		keyboard.right().onPressDo ({nave.moverDerecha()})
		keyboard.x().onPressDo ({nave.disparar()})
	}
	
	method iniciar(){
		game.addVisual(object{method position()= game.center() method text() = 
		"SPAVE INVADERS\n
		INSTRUCCIONES: Utilice las flechas para mover su nave, asegurese de disparar con la barra espaciadora a todas las naves\n
		\n
		<Enter> para empezar - <q> para salir"})
		game.ground("alienNaranja.png")
		keyboard.enter().onPressDo{self.spaveInvader()}
	}
	method image() = "logo.png"
	
	method terminar(){}
}
