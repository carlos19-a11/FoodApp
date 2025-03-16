import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/dailyorderspage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class DeliveryProgressPage extends StatefulWidget {
  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  final MyReceipt _receipt = MyReceipt(); // Instancia de recibo

  /// Captura toda la factura correctamente
  Future<Uint8List?> _captureFullReceipt() async {
    return await _receipt.captureReceipt();
  }

  /// Convierte la imagen capturada en PDF
  Future<File?> _generatePdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(child: pw.Image(image)),
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final pdfPath = "${tempDir.path}/factura.pdf";
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }

  /// Captura la factura y la comparte como PDF sin cortes
  Future<void> _captureAndSharePdf() async {
    final imageBytes = await _captureFullReceipt();
    if (imageBytes == null) return;

    final pdfFile = await _generatePdf(imageBytes);
    if (pdfFile == null) return;

    await Share.shareXFiles([XFile(pdfFile.path)], text: 'Factura de compra');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: SingleChildScrollView(
        child: _receipt, // Muestra la factura
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? "Usuario no autenticado";

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Ícono de usuario con imagen
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
              iconSize: 40.w,
            ),
          ),
          const SizedBox(width: 10),

          // Correo del usuario autenticado
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userEmail,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Mesera",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),

          // Botón de "Finalizar Pedido"
          ElevatedButton(
            onPressed: () async {
              final restaurant = context
                  .read<Restaurant>(); // Guarda referencia antes de async
              final selectedTable = 'Mesa 1';

              await _captureAndSharePdf(); // Captura sin cortes y comparte

              restaurant.addOrder(userEmail,
                  selectedTable); // Agregar pedido con email correcto
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                const SizedBox(width: 5),
                const Text(
                  'Finalizar Pedido',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
