import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocal extends StatelessWidget {
  MyCurrentLocal({super.key});

  // Controlador de texto para el campo de dirección
  final TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tu ubicación"),
        content: TextField(
          controller: textController, // Asociar el controlador
          decoration: const InputDecoration(hintText: "Buscar dirección..."),
        ),
        actions: [
          // Botón de cancelar
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: const Text("Cancelar"),
          ),
          // Botón de guardar
          TextButton(
            onPressed: () {
              // Obtén el texto del controlador
              String newAddress = textController.text.trim();

              if (newAddress.isNotEmpty) {
                // Actualiza la dirección en el modelo Restaurant
                context.read<Restaurant>().updateDeliveryAddress(newAddress);

                // Limpia el controlador
                textController.clear();
              }

              // Cierra el modal o pantalla actual
              Navigator.pop(context);
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
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
                    restaurant.deliveryAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Icono desplegable
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
