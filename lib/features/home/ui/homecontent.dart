import 'package:app_ecomerce/features/products/ui/product_card.dart';
import 'package:app_ecomerce/features/products/ui/providers/product_providers.dart';
import 'package:app_ecomerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homecontent extends ConsumerStatefulWidget {
  const Homecontent({super.key});

  @override
  ConsumerState<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends ConsumerState<Homecontent> with RouteAware{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // El usuario volvió a esta pantalla desde otra
    ref.read(productNotifierProvider.notifier).refresh();
  }


  List<String> options = ['Todos', 'Ofertas', 'Novedades', 'Populares'];
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    return Column(
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar productos',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Wrap(
            spacing: 16,
            children: List<Widget>.generate(options.length, (i) {
              return ChoiceChip(
                showCheckmark: false,
                label: Text(options[i]),
                selected: selectedIndex == i,
                onSelected: (selected) {
                  if (selected) {
                    setState(() => selectedIndex = i);
                  }
                  ref.invalidate(productNotifierProvider);
                },
              );
            }),
          ),

          Expanded(
            child: productState.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('No hay productos'));
                }
          
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3.6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(producto: product);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        // Expanded(
        //   child: _ContentBody(selectedIndex),
        // ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  // Widget _ContentBody(int index) {
  //   switch (index) {
  //     case 0:
  //       return ProductCard(
  //         title: 'Asus Rog Strix G15 2023 16gb Ram 512ssd Ryzen 7',
  //         price: '10.000.000',
  //         imageUrl: 'assets/laptop.png',
  //       );
  //     case 1:
  //       return ProductCard(
  //         title: 'Audofono Redragon H510 ZEUS',
  //         price: '350.000',
  //         imageUrl: 'assets/redragon3.jpg',
  //       );
  //     case 2:
  //       return ProductCard(
  //         title: 'Apple Watch Series 7',
  //         price: '1.500.000',
  //         imageUrl: 'assets/laptop.png',
  //       );
  //     case 3:
  //       return ProductCard(
  //         title: 'Cable HDMI 2.0 4K',
  //         price: '1.500.000',
  //         imageUrl: 'assets/laptop.png',
  //       );
  //     default:
  //       return Text("No Content");
  //   }
  // }
}