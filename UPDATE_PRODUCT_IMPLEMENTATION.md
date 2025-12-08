# Implementación de Actualización de Productos

## 📋 Resumen

Se ha implementado la funcionalidad completa para actualizar productos en la aplicación de e-commerce, siguiendo la arquitectura limpia existente.

## 🏗️ Arquitectura Implementada

### 1. **Domain Layer (Capa de Dominio)**

#### Repositorio Abstracto
- **Archivo**: `lib/features/products/domain/repositories/product_repository.dart`
- **Métodos agregados**:
  - `Future<Product> updateProduct(int productId, Product product, String token)`
  - `Future<Product> updateProductImage(int productId, XFile image, String token)`

#### Use Cases (Casos de Uso)
Se crearon dos nuevos casos de uso:

1. **UpdateProduct** - `lib/features/products/domain/usecases/update_product.dart`
   ```dart
   Future<Product> call(int productId, Product product, String token)
   ```

2. **UpdateProductImage** - `lib/features/products/domain/usecases/update_product_image.dart`
   ```dart
   Future<Product> call(int productId, XFile image, String token)
   ```

### 2. **Data Layer (Capa de Datos)**

#### Data Source
- **Archivo**: `lib/features/products/data/datasources/products_remote_data_source.dart`
- **Métodos implementados**:
  - `updateProduct()`: Envía una petición PUT a `/products/{product_id}` con los datos del producto
  - `updateProductImage()`: Envía una petición PUT a `/products/{product_id}/image` con el archivo de imagen

#### Repository Implementation
- **Archivo**: `lib/features/products/data/repositories/product_repository_impl.dart`
- Implementa los métodos abstractos del repositorio

### 3. **Presentation Layer (Capa de Presentación)**

#### Providers
- **Archivo**: `lib/features/products/presentation/providers/product_providers.dart`
- **Providers agregados**:
  - `updateProductUseCaseProvider`
  - `updateProductImageUseCaseProvider`

#### UI - Update Product Screen
- **Archivo**: `lib/features/products/presentation/admin/update_product_screen.dart`
- **Características**:
  - Pre-rellena los campos con los datos actuales del producto
  - Permite editar: nombre, descripción, precio, stock, categoría y estado (activo/inactivo)
  - Cambiar imagen del producto (opcional)
  - Validaciones de campos obligatorios
  - AlertDialogs para feedback al usuario
  - Refresca automáticamente la lista de productos después de actualizar

## 🚀 Cómo Usar

### Navegación a la Pantalla de Actualización

```dart
import 'package:app_ecomerce/features/products/presentation/admin/update_product_screen.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';

// Ejemplo de navegación
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UpdateProductScreen(
      product: miProducto, // Instancia de Product
    ),
  ),
);
```

### Ejemplo de Uso en una Lista de Productos

```dart
ListView.builder(
  itemCount: productos.length,
  itemBuilder: (context, index) {
    final producto = productos[index];
    return ListTile(
      title: Text(producto.nombre),
      subtitle: Text('Gs. ${producto.precio}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateProductScreen(
                product: producto,
              ),
            ),
          );
        },
      ),
    );
  },
)
```

## 📡 Endpoints del Backend

### 1. Actualizar Producto
```
PUT /products/{product_id}
Authorization: Bearer {token}
Content-Type: application/json

Body:
{
  "name": "string",
  "description": "string",
  "price": 1,
  "stock": 0,
  "is_active": true,
  "image": "string"
}
```

### 2. Actualizar Imagen del Producto
```
PUT /products/{product_id}/image
Authorization: Bearer {token}
Content-Type: multipart/form-data

Form Data:
- file: (archivo de imagen)
```

## ✨ Características Principales

1. **Pre-carga de Datos**: Todos los campos se inicializan con los valores actuales del producto
2. **Actualización de Imagen Opcional**: Solo se actualiza la imagen si el usuario selecciona una nueva
3. **Formateo de Precio**: El precio se muestra con separadores de miles (formato guaraní)
4. **Validaciones**: 
   - Campos obligatorios (nombre, descripción, precio, stock)
   - Verificación de token de autenticación
5. **Feedback Visual**: AlertDialogs para éxito y errores
6. **Auto-actualización**: La lista de productos se refresca automáticamente después de actualizar
7. **Control de Estado**: Switch para activar/desactivar productos

## 🔄 Flujo de Actualización

1. Usuario navega a `UpdateProductScreen` con un producto existente
2. Los campos se pre-rellenan con los datos actuales
3. Usuario modifica los campos deseados
4. (Opcional) Usuario selecciona una nueva imagen
5. Usuario presiona "Actualizar Producto"
6. **Si hay nueva imagen**:
   - Se sube la imagen primero (`PUT /products/{id}/image`)
7. Se actualiza la información del producto (`PUT /products/{id}`)
8. Se muestra un AlertDialog de éxito
9. Se cierra la pantalla y se refresca la lista de productos

## 🛡️ Manejo de Errores

La aplicación maneja los siguientes errores:
- Campos vacíos
- Token inválido o expirado
- Error al subir imagen
- Error al actualizar producto
- Errores de red

Todos los errores se muestran al usuario mediante AlertDialogs informativos.

## 📝 Notas Importantes

1. **Categorías**: Actualmente las categorías están hardcodeadas en el dropdown. Considera cargarlas dinámicamente desde el backend en el futuro.

2. **Imagen**: La URL de la imagen actual se mantiene en el objeto Product hasta que se actualice con una nueva.

3. **Estado isActive**: Se maneja con una variable local `_isActive` ya que `Product.isActive` es final.

4. **Formato de Precio**: Se utiliza `GuaraniInputFormatter()` para formatear el precio con separadores de miles.

## 🔧 Mejoras Futuras

- [ ] Cargar categorías dinámicamente desde el backend
- [ ] Agregar preview de imagen antes de subir
- [ ] Implementar validación de tamaño de imagen
- [ ] Agregar opción para eliminar producto
- [ ] Implementar carga asíncrona con loading indicator
- [ ] Agregar confirmación antes de actualizar

