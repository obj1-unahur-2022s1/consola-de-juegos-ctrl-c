import wollok.game.*

class Personajes{
	var property position
	var property image
	var property speed
	var property hp
	
	method moverDerecha(){
		self.position(self.position().right(speed))
	}
	
	method moverIzquierda(){
		self.position(self.position().left(speed))
	}
	
	method moverArriba(){
		self.position(self.position().up(speed))
	}
	
	method moverAbajo(){
		self.position(self.position().down(speed))
	}
	
	method recibirDisparo() {hp = 0.max(hp-1)}
	
	method position()
}

class Nave inherits Personajes{ 
	
	method disparar(){
		var disparo = new Disparo (position = self.position().up(1))
		
		game.addVisual(disparo)
	}
}

class Disparo{
	var property position
	var property image = 'disparo.png'

}