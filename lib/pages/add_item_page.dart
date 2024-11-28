import 'package:bloc_app/bloc/item_bloc.dart';
import 'package:bloc_app/bloc/item_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  context.read<ItemBloc>().add(AddItem(name));
                  Navigator.pop(context, true); // Indica que se agregó un ítem.
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
