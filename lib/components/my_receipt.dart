import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyReceipt extends StatelessWidget {
  final GlobalKey globalKey;

  const MyReceipt({super.key, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final deliveryTime = currentTime.add(const Duration(minutes: 20));
    final formattedTime = DateFormat('hh:mm a').format(deliveryTime);
    final restaurant = context.watch<Restaurant>();

    final currencyFormatter = NumberFormat.currency(
      locale: 'es_CO', // Locale para Colombia
      symbol: '\$', // Símbolo de pesos colombianos
      decimalDigits: 0, // Sin decimales
      customPattern: '¤ #,###', // Mostrar el símbolo antes
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: RepaintBoundary(
        // 🔥 Se captura solo esto
        key: globalKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/animaciones/dufffy.png', height: 70),
                const SizedBox(height: 10),
                Text("Restaurante Delicias Express",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("NIT: 1234567890", style: TextStyle(fontSize: 12)),
                Text("Dirección: Av. Principal #123",
                    style: TextStyle(fontSize: 12)),
                Text("Teléfono: +57 300 123 4567",
                    style: TextStyle(fontSize: 12)),
                const Divider(),
                Text("FACTURA DE COMPRA",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(
                    "Fecha: ${DateFormat('yyyy-MM-dd hh:mm a').format(currentTime)}",
                    style: TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Text("Mesa: ${restaurant.selectedTable ?? 'Ninguna'}",
                    style: TextStyle(fontSize: 14)),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(restaurant.displayCartReceipt(),
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'monospace')),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Text(
                    "Total: ${currencyFormatter.format(restaurant.getTotalPrice())}",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Tiempo estimado de entrega: $formattedTime",
                    style:
                        TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 10),
                const Divider(),
                Text("¡Gracias por tu compra!",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
