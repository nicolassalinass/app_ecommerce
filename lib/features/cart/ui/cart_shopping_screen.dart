import 'package:app_ecomerce/features/products/card_product_cart.dart';
import 'package:flutter/material.dart';

class CartShoppingScreen extends StatelessWidget {
  const CartShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CardProductCart();
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade800, width: 0.4
                  )
                ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subotal:", style: TextStyle(fontSize: 18,),),
                      Text("Gs. 3.500.000", style: TextStyle(fontSize: 18,),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Envio:", style: TextStyle(fontSize: 16,),),
                      Text("Gratis", style: TextStyle(fontSize: 16,),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text("Gs. 3.500.000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
          Divider(thickness: 0.1, color: Colors.grey.shade800,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 10,
                  shadowColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text("Proceder al Pago", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
          )
        ],
      ),
    );
  }
}