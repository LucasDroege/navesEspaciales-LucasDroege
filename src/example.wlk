/** First Wollok example */
class Nave {
	var property velocidad
	var property direccion
	var property combustible = 0
	var property mensajes = []
	method cargarCombustible(litros){
		combustible = litros
	}
	method descargarCombustible(litros){
		combustible = combustible - litros
	}
	method acelerar(cuanto) {
		velocidad = 100000.min(cuanto)
	}
	method desacelerar(cuanto) {
		velocidad = 0.max(velocidad - cuanto)
	}
	method irHaciaElSol(){
		direccion = 10
	}
	method escaparDelSol(){
		direccion = -10
	}
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	method alejarseUnPocoAlSol(){
		direccion = -10.max(direccion - 1)
	}
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method estaTranquila(){
		return self.combustible() > 4000 and self.velocidad() < 12000
	}
	method emitirMensaje(mensaje){mensajes.add(mensaje)}
	method recibirAmenaza(){
		self.emitirMensaje("se recibio amenaza")
	}
	method estaDeRelajo(){
		return self.estaTranquila()
	}
}
class NaveBaliza inherits Nave {
	var property baliza = colores.anyOne()
	var colores = ["verde","rojo","azul"]
	var contColor = 0
	method cambiarColor(){
		baliza = colores.anyOne()
		contColor += 1
	}
	method cambiarColorDeBaliza(colorNuevo){
		colores.add(colorNuevo)
		baliza = colorNuevo
	}
	override method prepararViaje(){
		baliza = colores.find("verde")
		super()
	}
	override method estaTranquila(){
		return super() and baliza == "rojo"
	}
	override method recibirAmenaza(){
		super()
		self.acercarseUnPocoAlSol()
	}
	override method estaDeRelajo(){
		return super() and contColor == 0
	}
}
class NaveDePasajero inherits Nave{
	var property cantidadDePasajeros
	var property racionesDeComida = []
	var property racionesDeBebida = []
	var property contComidasServidas = 0
	method cargarComida(comida){
		racionesDeComida.add(comida)
	}
	method cargarBebida(bebida){
		racionesDeComida.add(bebida)
	}
	override method prepararViaje(){
		self.cargarComida("Arroz")
		self.cargarComida("Ensalada")
		self.cargarComida("pollo")
		self.cargarComida("Atun")
		self.cargarBebida("coca")
		self.cargarBebida("pesi")
		self.cargarBebida("pepsico")
		self.cargarBebida("coca")
		self.cargarBebida("pesi")
		self.cargarBebida("pepsico")
		super()
	}
	method darComidaA(){
		racionesDeComida.remove(racionesDeComida.get(0))
		contComidasServidas += 1
	}
	method darBebidaA(){
		racionesDeBebida.remove(racionesDeBebida.get(0))
	}
	method darRacionesAnteAmenaza(){
		self.darComidaA()
		self.darBebidaA()
		self.darBebidaA()
	}
	override method recibirAmenaza(){
		super()
		self.acelerar(velocidad * 2)
		self.darRacionesAnteAmenaza()
	}
	override method estaDeRelajo(){
		return super() and contComidasServidas < 50
	}
}
class NaveDeCombate inherits Nave {
	var property estaVisible = true
	var property misilesDesplegados = true
	method ponerseVisible() {
		estaVisible = if(not(estaVisible)) not (estaVisible) else  estaVisible 
	}
	method ponerseInvisible() {
		estaVisible = if(estaVisible) not (estaVisible) else  estaVisible 
	}
	method estaInvisible() {return not(estaVisible)}
	method desplegarMisiles() {misilesDesplegados = if(not(misilesDesplegados)) not misilesDesplegados else misilesDesplegados }
	method replegarMisiles() {misilesDesplegados = if(not(misilesDesplegados)) not misilesDesplegados else misilesDesplegados }
	method mensajesEmitidos(){ return mensajes.size()}
	method primerMensajeEmitido(){return mensajes.get(0)}
	method ultimoMensajeEmitido(){return mensajes.get(mensajes.size() - 1)}
	method esEscueta(){return mensajes.get(0).length() < 30 } 
	method emitioMensaje(mensaje){}
	override method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
		super()
		self.acelerar(15000)
	}
	override method estaTranquila(){
		return super() and not self.misilesDesplegados()
	}
	method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	override method recibirAmenaza(){
		super()
		self.escapar()
	}
	override method estaDeRelajo(){
		return super() and self.esEscueta()
	}
}
class NaveHospital inherits NaveDePasajero {
	var property estaPreparadoElQuirofano = false
	method estaPreparado(){
	 estaPreparadoElQuirofano = not(estaPreparadoElQuirofano )
	}
	override method estaTranquila(){
		return super() and not self.estaPreparadoElQuirofano()
	}
	override method recibirAmenaza(){
		super()
		self.estaPreparado()
	}
}
class NaveSigilosa inherits NaveDeCombate {
	override method estaTranquila(){
		return super() and not self.estaInvisible()
	}
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
