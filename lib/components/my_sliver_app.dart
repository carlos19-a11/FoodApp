// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

import '../page/cart_page.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener el carrito desde el modelo Restaurant
    final userCart = Provider.of<Restaurant>(context).cart;

    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // Botón del carrito
        Stack(
          children: [
            IconButton(
              onPressed: () {
                // Navegar a la página del carrito
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      onItemRemoved: (removedItem) {
                        // Lógica para manejar la eliminación de un elemento
                        print('Item eliminado: $removedItem');
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            if (userCart.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '${userCart.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Center(child: Text("Cena al atardecer")),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
