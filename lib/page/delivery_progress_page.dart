import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/cartmodel.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/dailyorderspage.dart';
import 'package:food_delivery/page/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DeliveryProgressPage extends StatefulWidget {
  DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _captureAndShareScreenshot() async {
    try {
      // Captura la pantalla como un archivo de bytes
      final Uint8List? image = await _screenshotController.capture();
      if (image == null) return;

      // Guarda la imagen temporalmente
      final tempDir = await getTemporaryDirectory();
      final imagePath =
          await File('${tempDir.path}/screenshot.png').writeAsBytes(image);

      // Comparte la imagen con opciones avanzadas
      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: '¡Mira esta captura!',
        subject: 'Detalle del pedido',
      );
    } catch (e) {
      print('Error al compartir captura: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = context.watch<UserModel>().email;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context, userEmail),
      body: Screenshot(
        controller: _screenshotController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyReceipt(),
            ],
          ),
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
                fit: BoxFit.cover,
              ),
              iconSize: 40,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userEmail,
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
          // Botón de "Finalizar Pedido" con captura y compartir
          ElevatedButton(
            onPressed: () async {
              // Primero capturamos y compartimos la captura de pantalla
              await _captureAndShareScreenshot();

              // Luego obtenemos el correo del usuario
              final userEmail = context.read<UserModel>().email;
              final selectedTable =
                  'Mesa 1'; // Reemplazar por la selección real del usuario

              // Agregar el pedido al modelo Restaurant
              context.read<Restaurant>().addOrder(userEmail, selectedTable);

              // Navegar a la pantalla de pedidos
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            child: const Text(
              'Finalizar Pedido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
