import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Importar intl

import 'my_quantity_selector.dart';

class MyCartTitle extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback? onRemove; // Callback opcional para eliminar un elemento

  const MyCartTitle({
    super.key,
    required this.cartItem,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
      customPattern: '\u00A4 #,###',
    );

    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagPhat,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.food.name),
                      Text(
                        currencyFormatter.format(cartItem.totalPrice),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onDecrement: () {
                          if (cartItem.quantity > 1) {
                            restaurant.removeFromCart(cartItem);
                          } else {
                            restaurant.removeFromCart(cartItem);
                            if (onRemove != null) {
                              onRemove!();
                            }
                          }
                        },
                        onIncrement: () {
                          restaurant.addToCart(
                            cartItem.food,
                            cartItem.selectedAddons,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (cartItem.selectedAddons.isNotEmpty)
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  children: cartItem.selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(
                                    '(${currencyFormatter.format(addon.price)})'),
                              ],
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onSelected: (value) {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            labelStyle: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
