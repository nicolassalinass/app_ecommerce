import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/ui/detail_product_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product producto;
  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailProductScreen()),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  producto.imagen,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/laptop.png');
                  },
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    'Gs.${producto.precio}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


    // return GridView.builder(
    //       padding: const EdgeInsets.only(left: 5, right: 5),
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2,
    //         childAspectRatio: 3/3.6,
    //       ),
    //       itemCount: 50,
    //       itemBuilder: (context, index) {
    //         return InkWell(
    //           onTap: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductScreen(),));
    //           },
    //           child: Card(
    //             // shape: RoundedRectangleBorder(
    //             //   borderRadius: BorderRadius.circular(15),
                  
    //             // ),
    //             //elevation: 0,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 Expanded(
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    //                     child: Image.asset(
    //                       producto.imagen,
    //                       fit: BoxFit.fill,
    //                       height: 150,
    //                       width: double.infinity,
    //                     ),
    //                   ),
    //                 ),    
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(producto.nombre, 
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 18
    //                         ),
    //                         overflow: TextOverflow.ellipsis,
    //                         maxLines: 2,
    //                       ),
    //                       Text('Gs.${producto.precio}',
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.w700,
    //                           color: Theme.of(context).colorScheme.primary,
    //                         ),
    //                         textAlign: TextAlign.end,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                     ],
    //                   ),
    //                 ),        
    //               ],
    //             ),
    //           ),
    //         );
    //   },
    // );
  }
}