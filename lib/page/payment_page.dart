// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:food_delivery/components/my_button.dart';

// import 'delivery_progress_page.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;

//   // Función para validar los campos
//   bool isFormValid() {
//     return formKey.currentState?.validate() ?? false;
//   }

//   // Función que se llama cuando el usuario hace clic en "Paga ahora"
//   void userTappedPay() {
//     if (isFormValid()) {
//       // Mostrar el dialogo de confirmación
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Confirmar pago"),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//                 Text("Número de tarjeta: $cardNumber"),
//                 Text("Válida hasta: $expiryDate"),
//                 Text("Nombre del titular: $cardHolderName"),
//                 Text("CVC: $cvvCode"),
//               ],
//             ),
//           ),
//           actions: [
//             // Botón cancelar
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancelar"),
//             ),
//             // Botón confirmar
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Cerrar el dialogo
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const DeliveryProgressPage(),
//                   ),
//                 );
//               },
//               child: const Text("Sí"),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Mostrar un mensaje de error si los datos no son válidos
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Por favor, revisa los campos')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text("Verificar pago"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Widget para mostrar la tarjeta de crédito
//             CreditCardWidget(
//               cardNumber: cardNumber,
//               expiryDate: expiryDate,
//               cardHolderName: cardHolderName,
//               cvvCode: cvvCode,
//               showBackView: isCvvFocused,
//               onCreditCardWidgetChange: (p0) {},
//             ),

//             // Formulario de tarjeta de crédito
//             CreditCardForm(
//               cardNumber: cardNumber,
//               expiryDate: expiryDate,
//               cardHolderName: cardHolderName,
//               cvvCode: cvvCode,
//               onCreditCardModelChange: (data) {
//                 setState(() {
//                   cardNumber = data.cardNumber;
//                   expiryDate = data.expiryDate;
//                   cardHolderName = data.cardHolderName;
//                   cvvCode = data.cvvCode;
//                 });
//               },
//               formKey: formKey,
//             ),
//             const SizedBox(height: 20),

//             // Botón de pagar
//             MyButton(
//               onTap: userTappedPay,
//               text: "Paga ahora",
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
