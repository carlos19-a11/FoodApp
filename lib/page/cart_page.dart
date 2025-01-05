import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_cart_title.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/page/delivery_progress_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage(
      {super.key, required Null Function(dynamic removedItem) onItemRemoved});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // Obtener el carrito del usuario
      final userCart = restaurant.cart;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Carro"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // Indicador del número de elementos en el carrito
            // Stack(
            //   children: [
            //     IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.shopping_cart),
            //     ),
            //     if (userCart.isNotEmpty)
            //       Positioned(
            //         right: 8,
            //         top: 8,
            //         child: Container(
            //           padding: const EdgeInsets.all(2),
            //           decoration: BoxDecoration(
            //             color: Colors.red,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           constraints: const BoxConstraints(
            //             minWidth: 18,
            //             minHeight: 18,
            //           ),
            //           child: Text(
            //             '${userCart.length}',
            //             style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 12,
            //               fontWeight: FontWeight.bold,
            //             ),
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //       ),
            //   ],
            // ),
            // Botón para limpiar el carrito
            IconButton(
              onPressed: () {
                if (userCart.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "¿Estás seguro de que quieres limpiar el carrito?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("El carrito ha sido vaciado."),
                              ),
                            );
                          },
                          child: const Text("Sí"),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete_forever_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            // Lista de elementos en el carrito
            Expanded(
              child: userCart.isEmpty
                  ? const Center(
                      child: Text(
                        "El carrito está vacío.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        final cartItem = userCart[index];
                        return MyCartTitle(
                          cartItem: cartItem,
                          onRemove: () {
                            restaurant.removeFromCart(cartItem);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${cartItem.food.name} eliminado del carrito'),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            // Botón para proceder al pago
            MyButton(
              onTap: () {
                if (userCart.isEmpty) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryProgressPage(),
                    ),
                  );
                }
              },
              text: "Ir a pagar",
            ),
            const SizedBox(height: 25),
          ],
        ),
      );
    });
  }
}
