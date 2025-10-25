import 'package:app_ecomerce/features/cart/ui/cart_shopping_screen.dart';
import 'package:app_ecomerce/features/category/ui/categories_screen.dart';
import 'package:app_ecomerce/features/account_settings/ui/pages/client_account_screen.dart';
import 'package:app_ecomerce/features/home/ui/homecontent.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //TabController? _tabController = null;

  int _selecterdIndex = 0;

  List<String> titulos = ['Inicio', 'Categorias', 'Carrito', 'Perfil'];

  List<Widget> pages = [
    const Homecontent(),
    const CategoriesScreen(),
    const CartShoppingScreen(),
    const ClientAccountScreen()
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[_selecterdIndex]),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: pages[_selecterdIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300,width: 0.2)),
        ),
        child: NavigationBar(
          selectedIndex: _selecterdIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selecterdIndex = value;
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