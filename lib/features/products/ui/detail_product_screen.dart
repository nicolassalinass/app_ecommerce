import 'package:app_ecomerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
//import 'package:app_ecomerce/features/products/ui/providers/product_providers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailProductScreen extends ConsumerWidget {
  final Product product;
  const DetailProductScreen({super.key, required this.product});

  // AlojarImagenes1! Clouddinary
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: [
                
                Image.network(
                  product.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset("assets/image-not-found.png"),),
                
              ],

              options: CarouselOptions(
                //aspectRatio: 16/9,
                //viewportFraction: 1,
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.nombre.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              product.descripcion.toString(),
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: "add_to_cart",
                onPressed: (){
                  //Agregar al carrito
                  ref.read(cartProvider.notifier).addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Producto agregado al carrito"),
                      duration: Duration(seconds: 1),
                    )
                  );
                },
                foregroundColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary,width: 2),
                ),
                elevation: 0,
                child: Text("Agregar al carrito", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                heroTag: "buy_now",
                onPressed: null,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  //side: BorderSide(color: Colors.blue.shade900,width: 1),
                ),
                elevation: 0,
                child: Text("Comprar Ahora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}