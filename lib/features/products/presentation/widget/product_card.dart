import 'package:app_ecomerce/core/utils/currency_formatter.dart';
import 'package:app_ecomerce/features/cart/presentation/provider/cart_remote_provider.dart';
import 'package:app_ecomerce/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product producto;
  const ProductCard({super.key, required this.producto});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}



class _ProductCardState extends ConsumerState<ProductCard> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailProductScreen(product: widget.producto,)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade600, width: 0.1),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del producto
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: "product-id-${widget.producto.id}",
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        widget.producto.imagen,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/image-not-found.png");
                        },
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteButton(product: widget.producto),                    
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.producto.nombre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CurrencyFormatter.guaraniFormat(widget.producto.precio),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ref.read(cartRemoteNotifierProvider.notifier).addToCart(widget.producto.id!, 1);
                              ref.read(cartRemoteNotifierProvider.notifier).refresh();
                              final snackBar = SnackBar(
                                content: Text('${widget.producto.nombre} agregado al carrito.'),
                                duration: const Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                //color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Theme.of(context).colorScheme.primary,
                                size: 22,
                              ), 
                            ),
                          ),     
                          // IconButton(
                          //   icon: const Icon(Icons.add_shopping_cart),
                          //   color: Theme.of(context).colorScheme.primary,
                          //   onPressed: () {
                          //     ref.read(cartProvider.notifier).addProduct(widget.producto);
                          //     final snackBar = SnackBar(
                          //       content: Text('${widget.producto.nombre} agregado al carrito.'),
                          //       duration: const Duration(seconds: 2),
                          //     );
                          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //   },
                          // ),
                        ],
                      ),
                      
                    ],
                  ),
                  
                
              
            ),
          ],
        ),
      ),
    );

  }
}