import 'package:app_ecomerce/features/products/presentation/admin/add_product_screen.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:app_ecomerce/features/products/presentation/widget/product_card_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  ConsumerState<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen> {
  bool isSearch = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(productNotifierProvider);
    

    return Scaffold(
      appBar: AppBar(
        // title: Text("Gestión de Productos"),
        toolbarHeight: 80,
        title: !isSearch ? Text("Gestión de Productos") 
         : SearchBar(
          controller: _searchController,
          elevation: WidgetStatePropertyAll(0),
          leading: Icon(Icons.search,),
          trailing: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearch = false;
                  _searchQuery = '';
                  _searchController.clear();
                });
              }, 
              icon: Icon(Icons.close,)
            )
          ],
          hintText: 'Buscar productos...',
          onChanged: (query) {
            setState(() {
              _searchQuery = query.toLowerCase();
            });
          },
        ),
        scrolledUnderElevation: 0,
        actions: [
          if(!isSearch)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              }, 
              icon: Icon(Icons.search)
            ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(productNotifierProvider.notifier).refresh();
            },
            tooltip: 'Actualizar lista',
          ),
        ],
      ),
      body: productsAsyncValue.when(
        data: (products) {
          // Filtrar productos según la búsqueda
          final filteredProducts = _searchQuery.isEmpty
              ? products
              : products.where((product) {
                  return product.nombre.toLowerCase().contains(_searchQuery);
                }).toList();

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No hay productos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Agrega tu primer producto',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(productNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              slivers: [
                // Contador de productos
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total de Productos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${products.length}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Activos: ${products.where((p) => p.isActive).length}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Inactivos: ${products.where((p) => !p.isActive).length}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Mensaje cuando no hay resultados de búsqueda
                if (filteredProducts.isEmpty && _searchQuery.isNotEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No se encontraron productos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Intenta con otro término de búsqueda',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Grid de productos
                if (filteredProducts.isNotEmpty)
                  SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final producto = filteredProducts[index];
                        return ProductCardAdmin(producto: producto);
                      },
                      childCount: filteredProducts.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Cargando productos...'),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'Error al cargar productos',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(productNotifierProvider.notifier).refresh();
                },
                icon: Icon(Icons.refresh),
                label: Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary,),
        label: Text('Nuevo Producto', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
      ),
    );
  }
}

