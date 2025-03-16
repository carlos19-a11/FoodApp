import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/page/food_detail_page.dart';
import 'package:food_delivery/service/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  FoodCategory _selectedCategory = FoodCategory.hamburguesa;
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    PermissionStatus status;

    // Verificar si el dispositivo es Android 13+ y solicitar permisos adecuados
    if (Platform.isAndroid && (await _getAndroidSdkVersion()) >= 33) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Permiso denegado para acceder a la galería')),
      );
    }
  }

// Función para obtener la versión de Android
  Future<int> _getAndroidSdkVersion() async {
    final sdkInt = await Process.run('getprop', ['ro.build.version.sdk']);
    return int.tryParse(sdkInt.stdout.toString().trim()) ?? 30;
  }

  void _saveFood() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      String priceClean =
          _priceController.text.replaceAll(RegExp(r'[^\d]'), '');

      final food = Food(
        id: DateTime.now().toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        imagPhat: _selectedImage!.path,
        price: double.parse(priceClean),
        category: _selectedCategory,
        availableAddons: [],
      );

      Provider.of<FoodService>(context, listen: false).addFood(food);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado con éxito')),
      );

      // Navegar a FoodDetailPage con el producto recién creado
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodDetailPage(food: food)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Selecciona una imagen y completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(File(_selectedImage!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: Colors.grey[300],
                    ),
                    child: _selectedImage == null
                        ? const Icon(Icons.add_a_photo,
                            size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_nameController, 'Nombre', Icons.fastfood),
              _buildTextField(
                  _descriptionController, 'Descripción', Icons.description),
              _buildTextField(_priceController, 'Precio', Icons.attach_money,
                  isNumber: true),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: _selectedCategory,
                decoration: _inputDecoration('Categoría', Icons.category),
                items: FoodCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveFood,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Producto'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _numberFormat = NumberFormat.currency(
    locale: 'es_CO', // Locale para Colombia
    symbol: '\$', // Símbolo de pesos colombianos
    decimalDigits: 0, // Sin decimales
    customPattern: '\u00A4 #,###', // Mostrar el símbolo antes
  );

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters:
            isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: _inputDecoration(label, icon),
        validator: (value) => value!.isEmpty ? 'Ingrese $label' : null,
        onChanged: (value) {
          if (isNumber) {
            String cleanValue =
                value.replaceAll(RegExp(r'\D'), ''); // Elimina no dígitos
            if (cleanValue.isNotEmpty) {
              double parsed = double.parse(cleanValue);
              controller.value = TextEditingValue(
                text: _numberFormat.format(parsed),
                selection: TextSelection.collapsed(
                    offset: _numberFormat.format(parsed).length),
              );
            }
          }
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
