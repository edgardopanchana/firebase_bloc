// Importa el paquete 'equatable', que ayuda a comparar objetos de manera sencilla.
// Esto es útil cuando se trabaja con patrones como el bloc/cubit en Flutter.
import 'package:equatable/equatable.dart';

// Define una clase abstracta llamada 'ItemEvent', que extiende de 'Equatable'.
// Esto significa que cualquier clase que herede de 'ItemEvent' podrá beneficiarse
// de la comparación basada en las propiedades definidas en 'props'.
abstract class ItemEvent extends Equatable {
  // Sobrescribe el getter 'props' de 'Equatable' para especificar las propiedades
  // que se deben comparar al evaluar la igualdad de objetos. 
  // En este caso, es una lista vacía, lo que significa que no hay propiedades 
  // específicas para comparar en esta clase base.
  @override
  List<Object?> get props => [];
}

// Define una subclase de 'ItemEvent' llamada 'LoadItems'.
// Esta clase representa un evento para cargar elementos. 
// No tiene propiedades adicionales porque no necesita datos extra para su propósito.
class LoadItems extends ItemEvent {}

// Define otra subclase de 'ItemEvent' llamada 'AddItem'.
// Representa un evento para agregar un nuevo elemento.
class AddItem extends ItemEvent {
  // Declara una propiedad 'name', que es el nombre del elemento que se desea agregar.
  final String name;

  // Constructor que inicializa la propiedad 'name'.
  AddItem(this.name);

  // Sobrescribe el getter 'props' para incluir la propiedad 'name'.
  // Esto asegura que dos instancias de 'AddItem' serán consideradas iguales 
  // si tienen el mismo valor de 'name'.
  @override
  List<Object?> get props => [name];
}
