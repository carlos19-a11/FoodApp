import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/models/restaurant.dart';

class TableManagementPage extends StatefulWidget {
  const TableManagementPage({Key? key}) : super(key: key);

  @override
  _TableManagementPageState createState() => _TableManagementPageState();
}

class _TableManagementPageState extends State<TableManagementPage> {
  final TextEditingController tableController = TextEditingController();

  // Función para agregar la mesa
  void addTable() {
    String newTable = tableController.text.trim();
    if (newTable.isNotEmpty) {
      // Agregar la mesa al modelo
      context.read<Restaurant>().addTable(newTable);
      tableController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, escribe un nombre para la mesa")),
      );
    }
  }

  // Función para eliminar la mesa
  void deleteTable(String tableName) {
    context.read<Restaurant>().removeTable(tableName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Mesas")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para ingresar el nombre de la mesa
            TextField(
              controller: tableController,
              decoration: const InputDecoration(
                labelText: "Nombre de la mesa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addTable,
              child: const Text("Agregar Mesa"),
            ),
            const SizedBox(height: 20),
            // Mostrar las mesas existentes con la posibilidad de moverlas
            Consumer<Restaurant>(
              builder: (context, restaurant, child) {
                return Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final item =
                            restaurant.availableTables.removeAt(oldIndex);
                        restaurant.availableTables.insert(newIndex, item);
                      });
                    },
                    children: [
                      for (int index = 0;
                          index < restaurant.availableTables.length;
                          index++)
                        ListTile(
                          key: ValueKey(restaurant.availableTables[
                              index]), // Necesario para que ReorderableListView funcione
                          title: Text(restaurant.availableTables[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                deleteTable(restaurant.availableTables[index]),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
