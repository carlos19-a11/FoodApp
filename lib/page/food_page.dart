import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:intl/intl.dart'; // Importa intl para el formato de moneda
import 'package:provider/provider.dart';
import '../models/food.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddon = {};

  FoodPage({super.key, required this.food}) {
    // inicializar complementos seleccionados en falso
    for (Addon addon in food.availableAddons) {
      selectedAddon[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  // Formateador de moneda en pesos colombianos
  final currencyFormatter = NumberFormat.currency(
    locale: 'es_co', // Usa el locale para Colombia
    symbol: 'COP ', // Coloca "COP" antes del valor
    decimalDigits: 0, // Ajusta según lo que necesites
  );

  // Método para añadir al carrito
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context); // Cerrar la página de comida y volver al menú

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddon[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    // Añadir al carrito
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Imagen de comida
                Image.asset(widget.food.imagPhat),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre de la comida
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      // Precio de la comida formateado en pesos colombianos
                      Text(
                        currencyFormatter.format(widget.food.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 10),
                      // Descripción de la comida
                      Text(widget.food.description),
                      const SizedBox(height: 10),
                      Divider(color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(height: 10),

                      // Título de complementos
                      Text(
                        "Complementos",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // Lista de complementos
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            // Obtener complemento individual
                            Addon addon = widget.food.availableAddons[index];
                            // Retornar UI del checkbox
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                currencyFormatter.format(addon.price),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              value: widget.selectedAddon[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddon[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Botón para añadir al carrito
                MyButton(
                  onTap: () => addToCart(widget.food, widget.selectedAddon),
                  text: "Añadir a la cesta",
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),

        // Botón de retroceso
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
          ),
        )
      ],
    );
  }
}
