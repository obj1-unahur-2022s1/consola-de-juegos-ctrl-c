import consola.*
import wollok.game.*

class Visual {
	var property image
	var property position = game.origin()
}

object fondoDelJuego inherits Visual(
	image = "inicio.png",
	position = game.at(0,0)
){
	method colisionadoPor(visual){}
}
const inicioDelJuego = new Visual(
	image =  "universo.png",
	position = game.at(0,0)
)
const general = new Visual(
	image =  "GENERAL.png",
	position = game.at(0,0)
)
const gameOver = new Visual(
	image = "gameOver.png", 
	position = game.at(0,0)
)