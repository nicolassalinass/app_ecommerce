# Pantalla de Administración de Usuarios

## Descripción
La pantalla de administración de usuarios (`AdminUsersScreen`) es una interfaz similar a la de productos, diseñada para gestionar usuarios en la aplicación e-commerce.

## Archivos Creados

### 1. **user_notifier_provider.dart**
**Ubicación:** `lib/features/users/presentation/provider/user_notifier_provider.dart`

Provider que maneja el estado de la lista de usuarios usando Riverpod AsyncNotifier.

```dart
final userNotifierProvider = AsyncNotifierProvider<UserNotifier, List<User>>(() => UserNotifier());
```

**Funcionalidades:**
- Carga inicial de usuarios
- Método `refresh()` para actualizar la lista

### 2. **user_card_admin.dart**
**Ubicación:** `lib/features/users/presentation/widgets/user_card_admin.dart`

Widget de tarjeta para mostrar información de un usuario con acciones de administración.

**Características:**
- Avatar con inicial del nombre
- Badge de estado (Activo/Inactivo)
- Información del usuario (nombre, email)
- Badge de rol con colores diferenciados:
  - Admin: Morado
  - Usuario: Azul
  - Vendedor: Naranja
- Botones de editar y eliminar
- Dialog de detalles completos
- Dialog de edición con formulario
- Dialog de confirmación de eliminación

### 3. **admin_users_screen.dart**
**Ubicación:** `lib/features/users/presentation/screens/admin_users_screen.dart`

Pantalla principal de gestión de usuarios.

**Características:**
- **Búsqueda:** Barra de búsqueda por nombre o email
- **Filtros:** Filtro por rol (Admin, Usuario, Vendedor)
- **Estadísticas:**
  - Total de usuarios
  - Usuarios activos e inactivos
  - Contador por roles
- **Grid responsivo:** Muestra usuarios en cuadrícula 2 columnas
- **Refresh:** Pull-to-refresh y botón de actualizar
- **Estados:**
  - Loading con spinner
  - Error con opción de reintentar
  - Empty state cuando no hay usuarios
  - No results cuando no hay coincidencias de búsqueda/filtro
- **FAB:** Botón flotante para agregar nuevo usuario (placeholder)

## Uso

### Navegación a la Pantalla

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AdminUsersScreen(),
  ),
);
```

### Integración con el Sistema Existente

La pantalla ya está integrada con:
- Los providers existentes de usuarios
- Los use cases: `GetUsers`, `UpdateUser`, `DeleteUser`
- El repositorio de usuarios

### Ejemplo de Integración en un Menú

```dart
ListTile(
  leading: Icon(Icons.people),
  title: Text('Gestión de Usuarios'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminUsersScreen(),
      ),
    );
  },
)
```

## Funcionalidades Principales

### 1. Búsqueda de Usuarios
- Click en el icono de búsqueda en el AppBar
- Escribir nombre o email del usuario
- Los resultados se filtran en tiempo real

### 2. Filtrar por Rol
- Click en el icono de filtro (tres líneas)
- Seleccionar un rol específico o "Todos"
- Se muestra un chip indicando el filtro activo

### 3. Ver Detalles
- Click en cualquier tarjeta de usuario
- Se muestra un dialog con información completa

### 4. Editar Usuario
- Click en el botón "Editar" de la tarjeta
- Modificar nombre, email, rol o estado
- Guardar cambios

### 5. Eliminar Usuario
- Click en el icono de eliminar (papelera)
- Confirmar la eliminación
- El usuario se elimina y la lista se actualiza

### 6. Actualizar Lista
- Pull-to-refresh deslizando hacia abajo
- O click en el botón de refresh en el AppBar

## Personalización

### Cambiar Colores de Roles

Editar el método `_getRolColor` en `user_card_admin.dart`:

```dart
Color _getRolColor(String rol) {
  switch (rol.toLowerCase()) {
    case 'admin':
      return Colors.purple; // Cambiar aquí
    // ... más casos
  }
}
```

### Cambiar Iconos de Roles

Editar el método `_getRolIcon` en `user_card_admin.dart`:

```dart
IconData _getRolIcon(String rol) {
  switch (rol.toLowerCase()) {
    case 'admin':
      return Icons.admin_panel_settings; // Cambiar aquí
    // ... más casos
  }
}
```

### Ajustar Grid

En `admin_users_screen.dart`, modificar `SliverGridDelegateWithFixedCrossAxisCount`:

```dart
SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2, // Número de columnas
  crossAxisSpacing: 16, // Espacio horizontal
  mainAxisSpacing: 16, // Espacio vertical
  childAspectRatio: 0.75, // Relación ancho/alto
)
```

## Pendientes / Mejoras Futuras

1. **Agregar Usuario:** Implementar el use case `CreateUser` en el FAB
2. **Paginación:** Para grandes cantidades de usuarios
3. **Ordenamiento:** Por nombre, fecha de creación, etc.
4. **Filtros Avanzados:** Por estado, fecha de registro, etc.
5. **Exportación:** Exportar lista de usuarios a CSV/Excel
6. **Permisos:** Validar permisos del usuario actual antes de permitir editar/eliminar

## Notas Técnicas

- La pantalla usa `ConsumerStatefulWidget` para manejar estado local
- Los datos se obtienen mediante Riverpod providers
- Los diálogos usan `StatefulBuilder` para manejar estado interno
- Se implementa `pull-to-refresh` con `RefreshIndicator`
- El layout usa `CustomScrollView` con `Slivers` para mejor performance

## Estructura Similar a Productos

Esta implementación mantiene la misma estructura y patterns que `AdminProductsScreen`:
- Mismo layout y disposición
- Mismos patterns de estado (loading, error, success)
- Misma experiencia de usuario
- Mismos componentes (search, filter, refresh)

## Dependencias Requeridas

Asegúrate de tener en tu `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^2.x.x
  flutter:
    sdk: flutter
```
