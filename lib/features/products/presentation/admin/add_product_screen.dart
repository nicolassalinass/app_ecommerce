import 'dart:io';

import 'package:app_ecomerce/core/utils/guarani_input_formatter.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/image_upload_box.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();
  String? _selectedCategory;
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar nuevo Producto"),
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                        "Nombre del producto",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Ej: Laptop Asus Rog Strix",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.5,
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.3,
                            // ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                        "Descripcion",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),
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
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.1,
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.1,
                            // ),
                          ),
                        ),

                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Imagen del producto",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    _selectedImage == null
                        ? ImageUploadBox(
                            onImageSelected: (file) {
                              if (file != null) {
                                setState(() {
                                  _selectedImage = file;
                                });
                              }
                            },
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
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
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
                                      // borderSide: BorderSide(
                                      //   color: Colors.grey.shade300,
                                      //   width: 0.1,
                                      // ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // borderSide: BorderSide(
                                      //   color: Colors.grey.shade300,
                                      //   width: 0.1,
                                      // ),
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
                                    // borderSide: BorderSide(
                                    //   color: Colors.grey.shade300,
                                    //   width: 0.1,
                                    // ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // borderSide: BorderSide(
                                    //   color: Colors.grey.shade300,
                                    //   width: 0.1,
                                    // ),
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
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        hint: Text("Selecciona una categoria"),
                        initialValue: _selectedCategory,

                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.1,
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            // borderSide: BorderSide(
                            //   color: Colors.grey.shade300,
                            //   width: 0.1,
                            // ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: [
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{

                  final name = nameController.text;
                  final description = descriptionController.text;
                  final image = _selectedImage;
                  final price = priceController.text.replaceAll('.', '');
                  final stock = stockController.text;
                  final category = _selectedCategory;

                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString('access_token');

                  if(name.isEmpty || description.isEmpty || image == null || price.isEmpty || stock.isEmpty || category == null){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Complete todos los campos"),
                        content: Text("Relleno toos lo campos!!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Aceptar", style: TextStyle(fontSize: 16),),
                          ),
                        ],
                      ),
                    );
                    return; // Salir si hay campos vacíos
                  }

                  if (token == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Token inválido, inicia sesión nuevamente"))
                    );
                    return;
                  }


                  // OBTENER USECASES
                  final uploadImageRepository = ref.read(uploadImageUseCaseProvider).repository;
                  final createProductRepository = ref.read(createProductUseCaseProvider).repository;

                  // Subir imagen
                  String imageUrl = "";

                  try {
                    imageUrl = await uploadImageRepository.uploadImage(image, token);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error al subir imagen: $e"))
                    );
                    return;
                  }

                  // Agregar producto
                  // CREAR PRODUCTO
                  final product = Product(
                      nombre: name,
                      descripcion: description,
                      precio: double.parse(price),
                      stock: int.parse(stock),
                      isActive: true,
                      imagen: imageUrl,
                      category: category
                  );

                  try {
                    final newProduct = await createProductRepository.createProduct(product, token);
                    print(newProduct);

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 64,
                            ),
                        title: Text("¡Éxito!"),
                        content: Text("Producto creado exitosamente"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Limpiar todos los campos
                              nameController.clear();
                              descriptionController.clear();
                              priceController.clear();
                              stockController.clear();
                              ref.read(productNotifierProvider.notifier).refresh();
                              setState(() {
                                _selectedCategory = null;
                                _selectedImage = null;
                              });
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
                        title: Text("Error al crear producto"),
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
                  foregroundColor: Theme.of(context).colorScheme.onPrimary
                ),
                child: Text("Guardar Producto", style: TextStyle(fontSize: 16),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
