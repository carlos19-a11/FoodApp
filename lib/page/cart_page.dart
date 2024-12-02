import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_cart_title.dart';
// ignore: unused_import
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // Cart
      final userCart = restaurant.cart;

      // Scaffold UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Center(child: Text("Carro")),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // Clear cart button
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                        "¿Estás seguro de que quieres limpiar el carrito?"),
                    actions: [
                      // Cancel button
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      // Yes button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          restaurant.clearCart();
                        },
                        child: const Text("Sí"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_forever_rounded),
            )
          ],
        ),
        body: Column(
          children: [
            // List of cart items
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty
                      ? const Expanded(
                          child: Center(
                            child: Text("El carrito está vacío.."),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // Get individual cart item
                                final cartItem = userCart[index];

                                // Return cart title UI
                                return MyCartTitle(cartItem: cartItem);
                              }),
                        )
                ],
              ),
            ),
            // Button to go to payment page
            MyButton(
              onTap: () {
                // Check if the cart is empty before proceeding
                if (userCart.isEmpty) {
                  // Show an alert if the cart is empty
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Tu carrito está vacío."),
                      content: const Text(
                          "Por favor, agrega productos antes de proceder al pago."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cerrar"),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Navigate to payment page if cart is not empty
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()),
                  );
                }
              },
              text: "Ir a pagar",
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );
    });
  }
}
