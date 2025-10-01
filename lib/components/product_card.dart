import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  const ProductCard({super.key, required this.title, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
          padding: const EdgeInsets.only(left: 5, right: 5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/3.6,
          ),
          itemCount: 50,
          itemBuilder: (context, index) {
            return Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15),
                
              // ),
              //elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.fill,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                  ),    
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text('Gs.$price',
                          style: TextStyle(
                            fontSize: 16
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),        
                ],
              ),
            );
      },
    );
  }
}