# 🎴 ProductCardAdmin - Card para Administración de Productos

## 📋 Descripción

Se ha creado una card especializada para el panel de administración que muestra los productos con funcionalidades de gestión.

---

## 📦 Archivos Creados

1. ✅ **ProductCardAdmin Widget**
   - `lib/features/products/presentation/widget/product_card_admin.dart`

2. ✅ **Pantalla de Administración de Productos**
   - `lib/features/products/presentation/admin/admin_products_screen.dart`

---

## ✨ Características de ProductCardAdmin

### 🎯 Elementos Visuales

1. **Badge de Estado**: Muestra si el producto está ACTIVO o INACTIVO
   - Verde para activos
   - Rojo para inactivos

2. **Botón de Edición Rápida**: Botón azul en la esquina superior derecha
   - Acceso directo a `UpdateProductScreen`

3. **Información de Stock**: Muestra el stock disponible
   - Verde si hay stock
   - Rojo si está agotado

4. **Botón de Más Opciones**: Menú contextual con acciones

### 🛠️ Funcionalidades

#### 1. Ver Detalles
- Tap en la card para ver detalles del producto
- Navegación a `DetailProductScreen`

#### 2. Editar Producto
- Botón de editar en la esquina superior derecha
- Menú de opciones → "Editar Producto"
- Navegación a `UpdateProductScreen`

#### 3. Menú de Opciones (Bottom Sheet)
Al presionar el botón de más opciones (⋮) se muestra un menú con:

- **📝 Editar Producto**: Abre la pantalla de edición
- **👁️ Ver Detalles**: Muestra los detalles del producto
- **🔄 Activar/Desactivar**: Cambia el estado del producto
- **🗑️ Eliminar Producto**: Elimina el producto (con confirmación)

---

## 🚀 Cómo Usar

### Uso Individual

```dart
import 'package:app_ecomerce/features/products/presentation/widget/product_card_admin.dart';

// En tu widget
ProductCardAdmin(
  producto: miProducto,
)
```

### Uso en Grid

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.7,
  ),
  itemCount: productos.length,
  itemBuilder: (context, index) {
    return ProductCardAdmin(producto: productos[index]);
  },
)
```

### Pantalla Completa de Administración

```dart
import 'package:app_ecomerce/features/products/presentation/admin/admin_products_screen.dart';

// Navegación
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AdminProductsScreen(),
  ),
);
```

---

## 📊 AdminProductsScreen - Pantalla Completa

### Características

1. **Contador de Productos**
   - Total de productos
   - Productos activos
   - Productos inactivos

2. **Grid de Productos**
   - Diseño responsivo de 2 columnas
   - Usa `ProductCardAdmin` para cada producto

3. **Pull to Refresh**
   - Desliza hacia abajo para actualizar la lista

4. **Botón Flotante**
   - "Nuevo Producto" → Navega a `AddProductScreen`

5. **Estados de la UI**
   - Loading: Muestra spinner mientras carga
   - Error: Muestra mensaje de error con botón de reintentar
   - Empty: Mensaje cuando no hay productos
   - Success: Grid con todos los productos

6. **Botón de Actualizar**
   - En el AppBar para refrescar manualmente

---

## 🎨 Comparación: ProductCard vs ProductCardAdmin

| Característica | ProductCard (Cliente) | ProductCardAdmin |
|----------------|----------------------|------------------|
| **Badge de Estado** | ❌ | ✅ (Activo/Inactivo) |
| **Botón Favoritos** | ✅ | ❌ |
| **Botón Agregar Carrito** | ✅ | ❌ |
| **Botón Editar** | ❌ | ✅ |
| **Menú de Opciones** | ❌ | ✅ |
| **Información de Stock** | ❌ | ✅ (Con color) |
| **Hero Tag** | `product-id-{id}` | `product-admin-{id}` |
| **Acciones al Tap** | Ver detalles | Ver detalles |

---

## 🔧 Estructura del Menú de Opciones

```
┌─────────────────────────────┐
│  📝 Editar Producto         │  → UpdateProductScreen
├─────────────────────────────┤
│  👁️ Ver Detalles           │  → DetailProductScreen
├─────────────────────────────┤
│  🔄 Activar/Desactivar      │  → Diálogo de confirmación
├─────────────────────────────┤
│         ─────               │
├─────────────────────────────┤
│  🗑️ Eliminar Producto (🔴) │  → Diálogo de confirmación
└─────────────────────────────┘
```

---

## 💡 Ejemplos de Uso

### 1. En una Pantalla Simple

```dart
class MiPantallaAdmin extends StatelessWidget {
  final List<Product> productos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ProductCardAdmin(producto: productos[index]);
        },
      ),
    );
  }
}
```

### 2. Con Riverpod (Recomendado)

```dart
// Usar directamente AdminProductsScreen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AdminProductsScreen(),
  ),
);
```

### 3. Filtrar por Estado

```dart
Consumer(
  builder: (context, ref, child) {
    final products = ref.watch(productNotifierProvider);
    
    return products.when(
      data: (allProducts) {
        // Filtrar solo productos activos
        final activeProducts = allProducts.where((p) => p.isActive).toList();
        
        return GridView.builder(
          itemCount: activeProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return ProductCardAdmin(producto: activeProducts[index]);
          },
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  },
)
```

---

## ⚙️ Personalización

### Cambiar Colores del Badge

```dart
// En product_card_admin.dart, línea ~70
color: widget.producto.isActive
    ? Colors.green.withOpacity(0.9)  // Cambiar verde
    : Colors.red.withOpacity(0.9),   // Cambiar rojo
```

### Cambiar Disposición del Grid

```dart
// En admin_products_screen.dart
crossAxisCount: 2,        // Número de columnas
childAspectRatio: 0.7,   // Proporción altura/ancho
crossAxisSpacing: 16,    // Espacio horizontal
mainAxisSpacing: 16,     // Espacio vertical
```

### Agregar Más Opciones al Menú

```dart
// En product_card_admin.dart, método _showOptionsMenu
ListTile(
  leading: Icon(Icons.tu_icono, color: Colors.purple),
  title: Text('Tu Nueva Opción'),
  onTap: () {
    Navigator.pop(context);
    // Tu acción aquí
  },
),
```

---

## 🚨 Notas Importantes

### 1. Funcionalidades Pendientes

Las siguientes funcionalidades muestran alertas porque aún no están implementadas en el backend:

- ❌ **Eliminar Producto**: Necesita endpoint `DELETE /products/{id}`
- ⚠️ **Cambiar Estado**: Se puede hacer editando el producto, pero no hay endpoint específico

### 2. Hero Tag

El Hero tag es diferente al de `ProductCard` para evitar conflictos:
- ProductCard: `product-id-{id}`
- ProductCardAdmin: `product-admin-{id}`

### 3. Navegación

Todas las navegaciones regresan a la pantalla de administración y refrescan automáticamente la lista después de editar.

---

## 🔮 Mejoras Futuras Sugeridas

- [ ] Implementar endpoint DELETE en el backend
- [ ] Endpoint PATCH para cambiar solo el estado (activo/inactivo)
- [ ] Búsqueda y filtros en AdminProductsScreen
- [ ] Ordenar por: nombre, precio, stock, fecha
- [ ] Vista de lista alternativa (además del grid)
- [ ] Selección múltiple para acciones en lote
- [ ] Estadísticas más detalladas
- [ ] Exportar lista de productos a CSV/PDF

---

## ✅ Resumen

**ProductCardAdmin** es una card completa para administración que incluye:
- ✅ Vista previa del producto con imagen
- ✅ Badge de estado (Activo/Inactivo)
- ✅ Información de stock con colores
- ✅ Edición rápida con botón dedicado
- ✅ Menú de opciones completo
- ✅ Confirmaciones para acciones críticas
- ✅ Integración perfecta con UpdateProductScreen
- ✅ Diseño consistente con ProductCard

**AdminProductsScreen** ofrece:
- ✅ Vista completa de todos los productos
- ✅ Estadísticas de productos activos/inactivos
- ✅ Pull to refresh
- ✅ Botón flotante para agregar productos
- ✅ Manejo completo de estados (loading, error, empty, success)

¡Todo listo para administrar tus productos! 🎉

