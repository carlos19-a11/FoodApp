import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la hora estimada de entrega
    final currentTime = DateTime.now();
    final deliveryTime = currentTime.add(const Duration(minutes: 20));
    final formattedTime = DateFormat('hh:mm a').format(deliveryTime);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
      child: SingleChildScrollView(
        // Hacer el contenido desplazable
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Gracias por tu pedido!"),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(25),
                child: Consumer<Restaurant>(
                  builder: (context, restaurant, child) {
                    return Text(
                      restaurant.displayCartReceipt(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Mostrar la hora estimada de entrega
              Text("El tiempo estimado de entrega es: $formattedTime"),
            ],
          ),
        ),
      ),
    );
  }
}
