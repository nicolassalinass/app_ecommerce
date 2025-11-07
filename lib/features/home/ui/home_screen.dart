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

  int _selectedIndex = 0;

  List<String> titulos = ['Inicio', 'Categorias', 'Carrito', 'Perfil'];

  List<Widget> pages = [
    const Homecontent(),
    const CategoriesScreen(),
    const CartShoppingScreen(),
    const ClientAccountScreen()
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[_selectedIndex]),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      
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
              icon: Icon(Icons.history_outlined), 
              label: 'Historial',
              selectedIcon: Icon(Icons.history),
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

/*
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
  int _selectedIndex = 0;

  List<String> titulos = ['Inicio', 'Categorias', 'Carrito', 'Perfil'];

  List<Widget> pages = [
    const Homecontent(),
    const CategoriesScreen(),
    const CartShoppingScreen(),
    const ClientAccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(titulos[_selectedIndex]),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: pages[_selectedIndex],
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Floating Button Pressed'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),),
            );
          },
          elevation: 2,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        height: 85,
        //elevation: 50,
        surfaceTintColor: Colors.blue.shade800,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home, "Inicio", 0),
              _buildNavItem(Icons.search, "Categorias", 1),
              const SizedBox(width: 30), // Espacio para el FAB
              _buildNavItem(Icons.history, "Historial", 2),
              _buildNavItem(Icons.settings, "Perfil", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,size: 24,
            color: _selectedIndex == index ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: _selectedIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}*/