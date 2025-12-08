import 'package:app_ecomerce/features/products/presentation/widget/product_card.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homecontent extends ConsumerStatefulWidget {
  const Homecontent({super.key});

  @override
  ConsumerState<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends ConsumerState<Homecontent> with RouteAware {
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   routeObserver.subscribe(this, ModalRoute.of(context)!);
  // }
  //
  // @override
  // void dispose() {
  //   routeObserver.unsubscribe(this);
  //   super.dispose();
  // }
  //
  // @override
  // void didPopNext() {
  //   // El usuario volvió a esta pantalla desde otra
  //   ref.read(autoRefreshProductsProvider);
  // }
  //
  // @override
  // void didPushNext() {
  //   // El usuario salió de esta pantalla
  //   ref.invalidate(autoRefreshProductsProvider);
  // }

  String searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    return Column(
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Buscar productos',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),

          Expanded(
            child: productState.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('No hay productos'));
                }
          
                // Filtrar productos por búsqueda
                final filteredProducts = products.where((product) {
                  return product.isActive && 
                         product.nombre.toLowerCase().contains(searchQuery);
                }).toList();

                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron productos',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
          
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3.2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(producto: product);
                  },
                );
              },
              loading: ()  {
                return  Center(child: CircularProgressIndicator());
              },
              error: (err, stack) => Center(child: Text('Error: $err')),
              
            ),
          ),
      ],
    );
  }
}