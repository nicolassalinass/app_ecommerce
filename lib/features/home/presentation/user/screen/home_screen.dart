import 'package:app_ecomerce/features/cart/presentation/cart_shopping_screen.dart';
import 'package:app_ecomerce/features/category/presentation/categories_screen.dart';
import 'package:app_ecomerce/features/account_settings/presentation/user/user_account_screen.dart';
import 'package:app_ecomerce/features/favorites/presentation/favorites_screen.dart';
import 'package:app_ecomerce/features/home/presentation/user/screen/homecontent.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int _selectedIndex = 0;

  final List<String> titulos = ['Inicio', 'Categorias', 'Carrito', 'Favoritos','Perfil'];

  final List<Widget> pages = [
    const Homecontent(),
    const CategoriesScreen(),
    const CartShoppingScreen(),
    const FavoritesScreen(),
    const UserAccountScreen()
  ];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[_selectedIndex]),
        centerTitle: true,
        scrolledUnderElevation: 0,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.shopping_cart),
        //   ),
        // ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300,width: 0.2)),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined), 
              label: 'Inicio',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined), 
              label: 'Categorias',
              selectedIcon: Icon(Icons.category_rounded),
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined), 
              label: 'Carrito',
              selectedIcon: Icon(Icons.shopping_cart),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border), 
              label: 'Favoritos',
              selectedIcon: Icon(Icons.favorite),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline), 
              label: 'Perfil',
              selectedIcon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

