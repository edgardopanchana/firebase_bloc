// Importa los paquetes necesarios para el uso de BLoC y Firebase Realtime Database.
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'item_event.dart';
import 'item_state.dart';
import '../model/item_model.dart';

// Define la clase 'ItemBloc', que extiende de 'Bloc'.
// Este bloque maneja los eventos 'ItemEvent' y emite los estados 'ItemState'.
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  // Instancia de la referencia de la base de datos de Firebase, apuntando a la ubicación 'items'.
  final DatabaseReference database = FirebaseDatabase.instance.ref('items');

  // Constructor del 'ItemBloc', donde se define el estado inicial como 'ItemsInitial'.
  // Además, se asocian los eventos 'LoadItems' y 'AddItem' con sus respectivos manejadores de eventos.
  ItemBloc() : super(ItemsInitial()) {
    // Define qué evento manejar y qué función ejecutará cuando se dispare ese evento.
    on<LoadItems>(_onLoadItems);  // Cuando se dispare 'LoadItems', ejecutará '_onLoadItems'.
    on<AddItem>(_onAddItem);      // Cuando se dispare 'AddItem', ejecutará '_onAddItem'.
  }

  // Manejador de eventos para cargar los elementos desde Firebase.
  Future<void> _onLoadItems(LoadItems event, Emitter<ItemState> emit) async {
    // Emite el estado 'ItemsLoading' cuando comienza la carga de datos.
    emit(ItemsLoading());
    try {
      // Realiza una solicitud para obtener los datos de Firebase.
      final snapshot = await database.get();
      if (snapshot.exists) {
        // Si existen datos en Firebase, los convierte en una lista de objetos 'Item'.
        final items = snapshot.children.map((child) {
          return Item.fromJson(child.value as Map<dynamic, dynamic>, child.key!);
        }).toList();
        print('Loaded items: $items');
        // Emite el estado 'ItemsLoaded' con la lista de elementos obtenidos.
        emit(ItemsLoaded(items));
      } else {
        // Si no hay elementos en Firebase, emite un estado 'ItemsLoaded' con una lista vacía.
        print('No items found.');
        emit(ItemsLoaded(const []));
      }
    } catch (e) {
      // Si ocurre un error al obtener los datos, emite el estado 'ItemsError' con el mensaje de error.
      emit(ItemsError('Error loading items: $e'));
    }
  }

  // Manejador de eventos para agregar un nuevo elemento a Firebase.
  Future<void> _onAddItem(AddItem event, Emitter<ItemState> emit) async {
    try {
      // Crea una nueva referencia para un elemento en Firebase.
      final newRef = database.push();
      // Establece el valor del nuevo elemento en Firebase utilizando la clase 'Item' y sus datos.
      await newRef.set(Item(id: newRef.key!, name: event.name).toJson());
      print('Item added: ${event.name}');
      // Después de agregar el nuevo elemento, dispara el evento 'LoadItems' para recargar los elementos.
      add(LoadItems());
    } catch (e) {
      // Si ocurre un error al agregar el nuevo elemento, emite el estado 'ItemsError' con el mensaje de error.
      emit(ItemsError('Error adding item: $e'));
    }
  }
}
