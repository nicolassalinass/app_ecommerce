import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  // AlojarImagenes1! Clouddinary

  @override
  Widget build(BuildContext context) {
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
                Image.asset('assets/laptop.png', fit: BoxFit.cover),
                Image.asset('assets/laptop.png', fit: BoxFit.cover),
                Image.asset('assets/laptop.png', fit: BoxFit.cover),
                // Image.network('https://res.cloudinary.com/do1prceso/image/upload/v1759741817/samples/ecommerce/car-interior-design.jpg',
                //   fit: BoxFit.cover,
                // ),
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
              "Titulo del Producto",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              """Descripcion del Producto, 
              Este es un texto de ejemplo para la descripcion del producto. Este es un texto de ejemplo para la descripcion del producto.
              Este es un texto de ejemplo para la descripcion del producto.
              Este es un texto de ejemplo para la descripcion del producto.""",
              style: TextStyle(fontSize: 20),
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
                onPressed: null,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
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