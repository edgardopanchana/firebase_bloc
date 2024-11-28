// Importa el paquete 'equatable', que permite comparar objetos de forma sencilla.
// Esto es útil para gestionar el estado en aplicaciones que utilizan el patrón BLoC.
import 'package:equatable/equatable.dart';

// Importa el modelo de 'Item', que representa los elementos con los que se trabajará.
import '../../model/item_model.dart';

// Define una clase abstracta llamada 'ItemState', que extiende de 'Equatable'.
// Esta clase será la base para los diferentes estados que puede tener el "Item" en el flujo de la aplicación.
abstract class ItemState extends Equatable {
  // Sobrescribe el getter 'props' de 'Equatable' para indicar qué propiedades se deben comparar.
  // En este caso, es una lista vacía, lo que significa que no se comparan propiedades en la clase base.
  @override
  List<Object?> get props => [];
}

// Define una subclase llamada 'ItemsInitial', que representa el estado inicial.
// Este estado se utiliza cuando no se ha realizado ninguna acción aún.
class ItemsInitial extends ItemState {}

// Define una subclase llamada 'ItemsLoading', que representa el estado cuando
// se están cargando los elementos. No tiene propiedades adicionales.
class ItemsLoading extends ItemState {}

// Define una subclase llamada 'ItemsLoaded', que representa el estado cuando
// los elementos se han cargado correctamente. Incluye una lista de 'Item' como propiedad.
class ItemsLoaded extends ItemState {
  // Propiedad 'items' que contiene la lista de elementos cargados.
  final List<Item> items;

  // Constructor que inicializa la lista de elementos.
  ItemsLoaded(this.items);

  // Sobrescribe el getter 'props' para incluir la propiedad 'items'.
  // Esto asegura que dos instancias de 'ItemsLoaded' se consideren iguales si tienen la misma lista de elementos.
  @override
  List<Object?> get props => [items];
}

// Define una subclase llamada 'ItemsError', que representa un estado de error
// cuando ocurre un problema al cargar los elementos. Incluye un mensaje de error.
class ItemsError extends ItemState {
  // Propiedad 'message' que contiene el mensaje de error.
  final String message;

  // Constructor que inicializa el mensaje de error.
  ItemsError(this.message);

  // Sobrescribe el getter 'props' para incluir la propiedad 'message'.
  // Esto asegura que dos instancias de 'ItemsError' se consideren iguales si tienen el mismo mensaje.
  @override
  List<Object?> get props => [message];
}
