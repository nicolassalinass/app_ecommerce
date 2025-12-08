import 'package:flutter/material.dart';
import 'package:app_ecomerce/features/category/presentation/category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 100.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Buscar categorías',
              //     prefixIcon: Icon(Icons.search),
              //   ),
              // ),
              Text(
                "Dispositos Moviles", 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  CardCategoria(title: "Celulares y Tablets", icon: Icons.phone_android, category: "Celulares y Tablets"),
                  CardCategoria(title: "SmartWatch", icon: Icons.watch, category: "SmartWatch"),
                ],
              ),
              Text(
                "Computación", 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  CardCategoria(title: "Laptops", icon: Icons.laptop, category: "Laptops"),
                  CardCategoria(title: "Computadoras", icon: Icons.monitor, category: "Computadoras"),
                ],
              ),
              Text(
                "Accesorios", 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  CardCategoria(title: "Audio", icon: Icons.headphones, category: "Audio"),
                  CardCategoria(title: "Perifericos", icon: Icons.keyboard, category: "Perifericos"),
                ],
              ),
              Row(
                spacing: 16,
                children: [
                  CardCategoria(title: "Redes", icon: Icons.network_check, category: "Redes"),
                  CardCategoria(title: "Cables y Accesorios", icon: Icons.cable, category: "Cables y Accesorios"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardCategoria extends StatelessWidget {

  final String title;
  final IconData icon;
  final String category;

  const CardCategoria({
    super.key,
    required this.title,
    required this.icon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProductsScreen(
                categoryName: category,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            // border: Border.all(
            //   color: Colors.grey.shade300,
            //   width: 1
            // ),
          ),
          padding: EdgeInsets.only(top: 60, bottom: 60, left: 14, right: 14),
          //color: Colors.blue,
          child: Column(
            spacing: 14,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40,color: Colors.lightBlue,),
              Text(title, 
                style: TextStyle(
                  fontSize: 20
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}