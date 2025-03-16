import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class MyReceipt extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // 🔥 Captura el contenido sin cortes
      key: _globalKey,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/animaciones/dufffy.png', height: 70),
              const SizedBox(height: 10),
              Text("Restaurante Delicias Express",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(),
              Text("FACTURA DE COMPRA",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                  "Fecha: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now())}"),
              const Divider(),
              Text(
                  "Mesa: ${context.watch<Restaurant>().selectedTable ?? 'Ninguna'}"),
              const SizedBox(height: 10),
              Text(context.watch<Restaurant>().displayCartReceipt(),
                  style:
                      const TextStyle(fontSize: 14, fontFamily: 'monospace')),
              const SizedBox(height: 10),
              const Divider(),
              Text(
                  "Total: ${NumberFormat.currency(
                    locale: 'es_CO',
                    symbol: '\$',
                    decimalDigits: 0,
                    customPattern: '¤ #,###',
                  ).format(context.watch<Restaurant>().getTotalPrice())}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Divider(),
              Text("¡Gracias por tu compra!",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Permite capturar la factura completa sin cortes
  Future<Uint8List?> captureReceipt() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}
