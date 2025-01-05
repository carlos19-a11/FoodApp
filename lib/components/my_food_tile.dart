import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:intl/intl.dart'; // Importa intl para formatear el precio

class MyFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? ontap;
  const MyFoodTile({super.key, required this.food, this.ontap});

  @override
  Widget build(BuildContext context) {
    // Formateo del precio con separador de miles
    final NumberFormat currencyFormat = NumberFormat("#,##0", "es_ES");
    final formattedPrice = currencyFormat.format(food.price);

    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Asegura que ocupa todo el ancho
          children: [
            // Nombre del alimento encima de la imagen
            Text(
              food.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                overflow: TextOverflow.ellipsis, // Trunca si es muy largo
              ),
              textAlign: TextAlign.center, // Centra el texto horizontalmente
              maxLines: 1, // Limita a una sola línea
            ),
            const SizedBox(height: 7),
            // Imagen del alimento
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                food.imagPhat,
                height: 120,
                fit: BoxFit.cover, // Mantiene proporción de la imagen
              ),
            ),
            const SizedBox(height: 7),
            // Precio debajo de la imagen
            Text(
              '\$$formattedPrice',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center, // Centra el precio horizontalmente
            ),
          ],
        ),
      ),
    );
  }
}
