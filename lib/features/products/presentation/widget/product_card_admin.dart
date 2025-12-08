import 'package:app_ecomerce/core/utils/currency_formatter.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/admin/update_product_screen.dart';
import 'package:app_ecomerce/features/products/presentation/detail_product_screen.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCardAdmin extends ConsumerStatefulWidget {
  final Product producto;
  const ProductCardAdmin({super.key, required this.producto});

  @override
  ConsumerState<ProductCardAdmin> createState() => _ProductCardAdminState();
}

class _ProductCardAdminState extends ConsumerState<ProductCardAdmin> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(
              product: widget.producto,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade600, width: 0.1),
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del producto
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: "product-admin-${widget.producto.id}",
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.network(
                        widget.producto.imagen,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/laptop.png");
                        },
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  // Badge de estado (Activo/Inactivo)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.producto.isActive
                            ? Colors.green.withOpacity(0.9)
                            : Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.producto.isActive ? 'ACTIVO' : 'INACTIVO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Botón de editar
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProductScreen(
                              product: widget.producto,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.producto.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CurrencyFormatter.guaraniFormat(
                                widget.producto.precio,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Stock: ${widget.producto.stock}',
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.producto.stock > 0
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //IconButton(onPressed: () => _showOptionsMenu(context), icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.primary,)),
                      //Botón de más opciones
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.red,
                        onTap: () {
                          _showOptionsMenu(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          //padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.more_vert,
                            color: Theme.of(context).colorScheme.primary,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Editar Producto'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(
                        product: widget.producto,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility, color: Colors.green),
                title: Text('Ver Detalles'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailProductScreen(
                        product: widget.producto,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  widget.producto.isActive
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.orange,
                ),
                title: Text(
                  widget.producto.isActive
                      ? 'Desactivar Producto'
                      : 'Activar Producto',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _toggleProductStatus();
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Eliminar Producto',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleProductStatus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          widget.producto.isActive
              ? '¿Desactivar producto?'
              : '¿Activar producto?',
        ),
        content: Text(
          widget.producto.isActive
              ? 'El producto no será visible para los clientes'
              : 'El producto será visible para los clientes',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Aquí iría la lógica para actualizar el estado
              // Por ahora solo navegamos a la pantalla de edición
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(
                    product: widget.producto,
                  ),
                ),
              );
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¿Eliminar producto?'),
        content: Text(
          '¿Estás seguro de que deseas eliminar "${widget.producto.nombre}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              // Aquí iría la lógica para eliminar el producto
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('access_token');
              if (token == null) {
                // Manejar el caso donde no hay token
                return;
                
              }
              await ref.read(deleteProductUseCaseProvider).delete(widget.producto.id!, token);

              ref.read(productNotifierProvider.notifier).refresh();
              // showDialog(
              //   context: context,
              //   builder: (context) => AlertDialog(
              //     title: Text('PRODUCTO ELIMINADO!'),
              //     actions: [
              //       TextButton(
              //         onPressed: () => Navigator.of(context).pop(),
              //         child: Text('Aceptar', style: TextStyle(color: Colors.red),),
              //       ),
              //     ],
              //   ),
              // );
            },
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

