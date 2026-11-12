class PacksTuristicos{

    const property duracionViaje
    const property precioBase
    const property beneficiosEspeciales = []
    var property coordinadorACargo
    
    method precioFinal() = precioBase + self.costoBeneficiosVigentes()

    method costoBeneficiosVigentes() = self.beneficiosVigentes().sum({ b => b.costoBeneficio() })

    method beneficiosVigentes() = beneficiosEspeciales.filter({ b => b.estaVigente() })

    method agregarBeneficio(unBeneficio) {
    beneficiosEspeciales.add(unBeneficio)
    }

    method esPremium()
}


class PackNacional inherits PacksTuristicos{
    const property actividades = [] 
    const property provinciaDestino

    method agregarActividad(unaActividad) {
    actividades.add(unaActividad)
    }
    override method esPremium() = duracionViaje > 10 and coordinadorACargo.estaAltamenteCalificado()
}

class PackProvincial inherits PackNacional{
    var property cantidadDeCiudadesAVisitar

    override method esPremium() = 
    actividades.size() >= 4 and 
    cantidadDeCiudadesAVisitar > 5 and 
    self.beneficiosVigentes().size() >= 3

    override method precioFinal() {
    const subtotal = super()
    return if (self.esPremium()) subtotal * 1.05 else subtotal
  }
}

class PackInternacional inherits PacksTuristicos{
    const property paisDestino
    const property cantidadEscalas
    const property esDeInteres

    override method precioFinal() = super() * 1.2

    override method esPremium() = duracionViaje > 20 and esDeInteres and cantidadEscalas == 0

}

class Coordinador{

    var property cantViajesRealizados
    var property estaMotivado
    var property añosExperiencia
    var property rol

    method rol() = rol

     method cambiarRol(unRol) {
    if (!self.roles().contains(unRol)) {
      self.error("El rol asignado no es válido.")
    }
    rol = unRol
    }

    method roles() = [guia, asistenteLogistico, acompañante]


    method estaAltamenteCalificado(){ 
       return cantViajesRealizados > 20 and rol.cumpleConRol(self)
    }

}

object guia{

    method cumpleConRol(unCoordinador) = unCoordinador.estaMotivado()
}

object asistenteLogistico{

    method cumpleConRol(unCoordinador) = unCoordinador.añosExperiencia() > 3
}

object acompañante{

    method cumpleConRol(unCoordinador) = true
}
class BeneficioEspecial{

    var property tipoBeneficio
    const property costoBeneficio
    var property estaVigente
}