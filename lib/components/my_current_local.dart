import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocal extends StatefulWidget {
  const MyCurrentLocal({Key? key}) : super(key: key);

  @override
  State<MyCurrentLocal> createState() => _MyCurrentLocalState();
}

class _MyCurrentLocalState extends State<MyCurrentLocal> {
  // Controlador de texto para el campo de dirección
  final TextEditingController textController = TextEditingController();

  // Mostrar cuadro de búsqueda de ubicación
  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Agregar o editar dirección"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: "Escribe una dirección...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar diálogo
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              String newAddress = textController.text.trim();
              if (newAddress.isNotEmpty) {
                // Actualizar dirección en el modelo
                context.read<Restaurant>().updateDeliveryAddress(newAddress);
                textController.clear();
                Navigator.pop(context); // Cerrar diálogo
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text("Por favor, escribe una dirección válida.")),
                );
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  // Mostrar cuadro para seleccionar una mesa
  void openTableSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seleccionar mesa"),
          content: Consumer<Restaurant>(
            builder: (context, restaurant, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: restaurant.availableTables.map((table) {
                  return RadioListTile<String>(
                    title: Text(table),
                    value: table,
                    groupValue:
                        restaurant.selectedTable, // Valor actual del modelo
                    onChanged: (String? value) {
                      if (value != null) {
                        // Actualiza la mesa seleccionada en el modelo
                        context.read<Restaurant>().updateSelectedTable(value);
                        Navigator.pop(context); // Cierra el diálogo
                      }
                    },
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dirección de entrega
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entregar ahora",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: () => openLocationSearchBox(context),
                child: Row(
                  children: [
                    Consumer<Restaurant>(
                      builder: (context, restaurant, child) => Text(
                        restaurant.deliveryAddress.isNotEmpty
                            ? restaurant.deliveryAddress
                            : "Agregar ubicación",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
          // Selección de mesa
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seleccionar mesa",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => openTableSelectionDialog(context),
                child: Row(
                  children: [
                    const Icon(Icons.table_bar),
                    Consumer<Restaurant>(
                      builder: (context, restaurant, child) => Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          restaurant.selectedTable ?? "No seleccionada",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
