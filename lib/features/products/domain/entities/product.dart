class Product{
  int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final bool isActive;
  final String imagen;
  final String category;

  Product({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.isActive,
    required this.imagen,
    required this.category,
  });

}