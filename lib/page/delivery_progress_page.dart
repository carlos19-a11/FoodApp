import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/dailyorderspage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DeliveryProgressPage extends StatefulWidget {
  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  final GlobalKey _globalKey = GlobalKey(); // Clave global para capturar

  Future<void> _captureAndShareScreenshot() async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Esperar renderizado

      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        print("Error: No se pudo capturar la factura.");
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final imagePath =
          await File('${tempDir.path}/factura.png').writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(imagePath.path)],
          text: '¡Factura de compra!', subject: 'Detalle del pedido');
    } catch (e) {
      print('Error al compartir captura: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = context.watch<UserModel>().email;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: _buildBottomNavBar(context, userEmail),
      body: Center(
        child: MyReceipt(globalKey: _globalKey), // Pasamos la clave aquí
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
          ElevatedButton(
            onPressed: () async {
              await _captureAndShareScreenshot(); // Captura solo la factura
              final selectedTable = 'Mesa 1';
              context.read<Restaurant>().addOrder(userEmail, selectedTable);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()),
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
