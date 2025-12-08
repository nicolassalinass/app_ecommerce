import 'dart:io';

import 'package:app_ecomerce/core/utils/guarani_input_formatter.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProductScreen extends ConsumerStatefulWidget {
  final Product product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  ConsumerState<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends ConsumerState<UpdateProductScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  String? _selectedCategory;
  XFile? _selectedImage;
  bool _imageChanged = false;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores con los datos del producto
    nameController = TextEditingController(text: widget.product.nombre);
    descriptionController = TextEditingController(text: widget.product.descripcion);

    // Formatear el precio con separadores de miles
    final priceFormatted = widget.product.precio.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    priceController = TextEditingController(text: priceFormatted);

    stockController = TextEditingController(text: widget.product.stock.toString());
    _isActive = widget.product.isActive;
    // Inicializar con la categoría del producto
    _selectedCategory = widget.product.category.isNotEmpty ? widget.product.category : null;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Producto"),
        scrolledUnderElevation: 0,
        bottomOpacity: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
        child: Column(
          spacing: 12,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Informacion del producto",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Nombre del producto",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Ej: Laptop Asus Rog Strix",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Descripcion",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: TextField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: "Introduce una descripcion detallada del producto",
                          contentPadding: EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Imagen del producto",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _selectedImage == null
                        ? Stack(
                            children: [
                              // Mostrar imagen actual del producto
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  widget.product.imagen,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                      if (image != null) {
                                        setState(() {
                                          _selectedImage = image;
                                          _imageChanged = true;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.edit),
                                    color: Colors.black87,
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedImage = null;
                                        _imageChanged = false;
                                      });
                                    },
                                    icon: Icon(Icons.close),
                                    color: Colors.black87,
                                    iconSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Detalle y Organizacion",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Text("Precio", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                              TextField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  GuaraniInputFormatter()
                                ],
                                decoration: InputDecoration(
                                  prefix: Text("Gs. "),
                                  hintText: "50.000",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Text("Stock", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                              TextField(
                                controller: stockController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Categoria",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: Text("Selecciona una categoria"),
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: const [
                          DropdownMenuItem(value: "Celulares y Tablets", child: Text("Celulares y Tablets")),
                          DropdownMenuItem(value: "SmartWatch", child: Text("SmartWatch")),
                          DropdownMenuItem(value: "Laptops", child: Text("Laptops")),
                          DropdownMenuItem(value: "Computadoras", child: Text("Computadoras")),
                          DropdownMenuItem(value: "Audio", child: Text("Audio")),
                          DropdownMenuItem(value: "Perifericos", child: Text("Perifericos")),
                          DropdownMenuItem(value: "Redes", child: Text("Redes")),
                          DropdownMenuItem(value: "Cables y Accesorios", child: Text("Cables y Accesorios"))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text("Estado: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                          Switch(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value;
                              });
                            },
                          ),
                          Text(_isActive ? "Activo" : "Inactivo"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameController.text;
                  final description = descriptionController.text;
                  final price = priceController.text.replaceAll('.', '');
                  final stock = stockController.text;
                  final image = _selectedImage;
                  final category = _selectedCategory;

                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString('access_token');

                  if (name.isEmpty || description.isEmpty || price.isEmpty || stock.isEmpty || category == null || (_imageChanged && image == null)) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Complete todos los campos"),
                        content: Text("Rellena todos los campos obligatorios!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Aceptar", style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  if (token == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error de autenticación"),
                        content: Text("Token inválido, inicia sesión nuevamente"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Aceptar"),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  // OBTENER USECASES
                  final updateProductRepository = ref.read(updateProductUseCaseProvider).repository;
                  final updateProductImageRepository = ref.read(updateProductImageUseCaseProvider).repository;
                  String newImageUrl = "";
                  try {
                    // Si se cambió la imagen, actualizarla primero
                    if (_imageChanged) {
                      newImageUrl = await updateProductImageRepository.updateProductImage(
                        widget.product.id!, 
                        image!, 
                        token
                      );
                    }

                    // Actualizar información del producto
                    final updatedProduct = Product(
                      id: widget.product.id,
                      nombre: name,
                      descripcion: description,
                      precio: double.parse(price),
                      stock: int.parse(stock),
                      isActive: _isActive,
                      imagen: newImageUrl.isNotEmpty ? newImageUrl : widget.product.imagen, // Se mantiene la imagen actual o la actualizada
                      category: category,
                    );

                    await updateProductRepository.updateProduct(
                      widget.product.id!,
                      updatedProduct,
                      token,
                    );


                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 64,
                            ),
                        title: Text("¡Éxito!"),
                        content: Text("Producto actualizado exitosamente"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Cerrar diálogo
                              Navigator.of(context).pop(); // Volver a la pantalla anterior

                              // Refrescar lista de productos
                              ref.read(productNotifierProvider.notifier).refresh();
                            },
                            child: Text("Aceptar"),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error al actualizar producto"),
                        content: Text("$e"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Aceptar"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text("Actualizar Producto", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

