import 'package:app_ecomerce/core/utils/currency_formatter.dart';
import 'package:app_ecomerce/features/cart/domain/entities/cart.dart';
import 'package:app_ecomerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:app_ecomerce/features/products/ui/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardProductCart extends ConsumerWidget {
  final Cart cartItem;

  const CardProductCart({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailProductScreen(product: cartItem.product),));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.grey.shade500, width: 0.3),
            borderRadius: BorderRadius.circular(10)
          ),
          height: screenHeight * 0.135,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  cartItem.product.imagen,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/image-not-found.png");
                  }, 
                  height: screenHeight * 0.12, 
                  width: screenWidth * 0.35,
                  fit: BoxFit.contain,
                )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.product.nombre, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 5,),
                      Text(
                        CurrencyFormatter.guaraniFormat(cartItem.product.precio), 
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Spacer(),   
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {ref.read(cartProvider.notifier).decreaseProduct(cartItem.product);},
                            icon: Icon(Icons.remove_circle, size: 30, color: Colors.grey,),
                          ),
                          Text(cartItem.cantidad.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          IconButton(
                            onPressed: () {ref.read(cartProvider.notifier).addProduct(cartItem.product);},
                            icon: Icon(Icons.add_circle, size: 30, color: Colors.grey,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(onPressed: () {
                ref.read(cartProvider.notifier).removeProduct(cartItem.product);
              }, icon: Icon(Icons.delete, color: Colors.grey.shade600,size: 28,))
            ],
          ),
        ),
      ),
    );
  }
}