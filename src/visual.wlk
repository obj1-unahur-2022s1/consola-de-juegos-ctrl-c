import consola.*
import wollok.game.*

class Visual {
	var property image
	var property position = game.origin()
}

const fondoDelJuego = new Visual(
	image = "inicio.png",
	position = game.at(0,0)
)

const inicioDelJuego = new Visual(
	image =  "spacePixel.png",
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
const winner = new Visual(
	image = "win.jfif", 
	position = game.at(0,0)
)