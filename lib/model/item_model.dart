// Define la clase 'Item', que representa un elemento con un 'id' y un 'name'.
class Item {
  // Propiedades 'id' y 'name' son de tipo String. 'id' es único para cada elemento.
  final String id;
  final String name;

  // Constructor que requiere el 'id' y 'name' para crear una nueva instancia de 'Item'.
  Item({required this.id, required this.name});

  // Método factory que crea una instancia de 'Item' a partir de un JSON y un 'id' dado.
  factory Item.fromJson(Map<dynamic, dynamic> json, String id) {
    return Item(
      // Asigna el 'id' recibido como parámetro.
      id: id,
      // Asigna el valor de 'name' que viene del JSON.
      name: json['name'] as String,
    );
  }

  // Método que convierte la instancia de 'Item' a un mapa de claves y valores (JSON).
  Map<String, dynamic> toJson() {
    // Devuelve un mapa con solo el nombre del item.
    return {'name': name};
  }
}
