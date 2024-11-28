// Importa los paquetes necesarios para inicializar Firebase, manejar el BLoC y crear la interfaz de usuario.
import 'package:bloc_app/firebase_options.dart';
import 'package:bloc_app/bloc/item_bloc.dart';
import 'package:bloc_app/bloc/item_event.dart';
import 'package:bloc_app/pages/item_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Función principal para iniciar la aplicación.
void main() async {
  // Asegura que los widgets estén correctamente inicializados antes de realizar otras acciones.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con las configuraciones para la plataforma actual (iOS, Android, etc.).
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación y configura el proveedor de BLoC en el árbol de widgets.
  // Se crea una instancia de 'ItemBloc' y se emite el evento 'LoadItems' para cargar los datos de inmediato.
  runApp(
    BlocProvider(
      create: (context) => ItemBloc()..add(LoadItems()),  // Inicializa 'ItemBloc' y carga los elementos.
      child: const MyApp(),  // El widget principal de la aplicación.
    ),
  );
}

// Define la clase 'MyApp', que es el widget principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye el árbol de widgets de la aplicación.
    return MaterialApp(
      title: 'Flutter Demo',  // Título de la aplicación.
      theme: ThemeData(
        // Configura el tema con un esquema de colores basado en un color semilla (deepPurple).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,  // Habilita el uso de Material 3 (el diseño más moderno de Flutter).
      ),
      home: const ItemPage(),  // Establece la página inicial como 'ItemPage', donde se mostrarán los elementos.
    );
  }
}
