import 'package:app_ecomerce/components/product_card.dart';
import 'package:flutter/material.dart';

class Homecontent extends StatefulWidget {
  const Homecontent({super.key});

  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {

  List<String> options = ['Todos', 'Ofertas', 'Novedades', 'Populares'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
          /*Row(
            spacing: 20,
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                selected: true,
                label: Text("Todos"),
                showCheckmark: false,
                onSelected: (value) {
                  setState(() {
                    
                  });
                },
                //backgroundColor: Colors.white24,
                // shape: StadiumBorder(
                //   side: BorderSide(
                //     color: Colors.white24,
                //   ),
                // ),

              ),
              ChoiceChip(
                selected: false,
                label: Text("Ofertas"),
                // shape: StadiumBorder(
                //   side: BorderSide(
                //     color: Colors.white24,
                //   ),
                // ),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Novedades"),
                // shape: StadiumBorder(
                //   side: BorderSide(
                //     color: Colors.white24,
                //   ),
                // ),
              ),
              ChoiceChip(
                selected: false,
                label: Text("Populares"),
                // shape: StadiumBorder(
                //   side: BorderSide(
                //     color: Colors.white24,
                //   ),
                // ),
              ),
            ],
          ),*/
          
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
                  },
                );
              }),
            ),

          Expanded(
            child: _ContentBody(selectedIndex),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ContentBody(int index) {
    switch (index) {
      case 0:
        return ProductCard(
          title: 'Asus Rog Strix G15 2023 16gb Ram 512ssd Ryzen 7',
          price: '10.000.000',
          imageUrl: 'assets/laptop.png',
        );
      case 1:
        return ProductCard(
          title: 'Samsung Galaxy S21',
          price: '3.000.000',
          imageUrl: 'assets/laptop.png',
        );
      case 2:
        return ProductCard(
          title: 'Apple Watch Series 7',
          price: '1.500.000',
          imageUrl: 'assets/laptop.png',
        );
      case 3:
        return ProductCard(
          title: 'Cable HDMI 2.0 4K',
          price: '1.500.000',
          imageUrl: 'assets/laptop.png',
        );
      default:
        return Text("No Content");
    }
  }
}