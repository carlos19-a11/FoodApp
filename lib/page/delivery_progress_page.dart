import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  @override
  Widget build(BuildContext context) {
    // Obtener el correo del usuario desde el UserModel
    final userEmail = context.watch<UserModel>().email;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        // title: const Text('Progreso de la entrega'),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context, userEmail),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text('Bienvenido a la página de progreso de entrega'),
            MyReceipt(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, String userEmail) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          // Reemplazar el ícono por una imagen
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/animaciones/mujer-de-negocios.png',
                fit: BoxFit.cover, // Ajusta la imagen
              ),
              iconSize: 40, // Ajusta el tamaño de la imagen
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userEmail, // Mostrar el correo del usuario
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Text(
                "Mesera",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf),
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.print),
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
