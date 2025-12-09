# 📱 Documentación Completa - App E-Commerce Flutter

## 📋 Índice
1. [Información General](#información-general)
2. [Arquitectura del Proyecto](#arquitectura-del-proyecto)
3. [Características Principales](#características-principales)
4. [Estructura de Carpetas](#estructura-de-carpetas)
5. [Tecnologías y Dependencias](#tecnologías-y-dependencias)
6. [Configuración del Proyecto](#configuración-del-proyecto)
7. [Módulos y Features](#módulos-y-features)
8. [Flujo de Datos](#flujo-de-datos)
9. [Guía de Desarrollo](#guía-de-desarrollo)

---

## 📖 Información General

**App E-Commerce** es una aplicación móvil multiplataforma desarrollada en Flutter que implementa un sistema completo de comercio electrónico con dos tipos de usuarios: clientes y administradores.

### Características Destacadas
- 🏗️ **Clean Architecture** por features
- 🔄 **State Management** con Riverpod
- 🛣️ **Navegación** con Go Router
- 🌐 **Consumo de API REST**
- 💾 **Persistencia local** con SharedPreferences
- 🎨 **Temas** claro y oscuro
- 📱 **Responsive design**

### Estado del Proyecto
Versión: 1.0.0+1  
SDK: Flutter ^3.8.0  
Última actualización: Diciembre 2025

---

## 🏗️ Arquitectura del Proyecto

El proyecto sigue los principios de **Clean Architecture** organizando el código en tres capas principales:

### Capas de la Arquitectura

```
Feature/
├── data/              # Capa de Datos
│   ├── datasources/   # Fuentes de datos (API, Local)
│   ├── models/        # Modelos de datos
│   └── repositories/  # Implementación de repositorios
├── domain/            # Capa de Dominio
│   ├── entities/      # Entidades del negocio
│   ├── repositories/  # Interfaces de repositorios
│   └── usecases/      # Casos de uso
└── presentation/      # Capa de Presentación
    ├── screens/       # Pantallas
    ├── widgets/       # Widgets reutilizables
    └── providers/     # Providers de Riverpod
```

### Principios Aplicados

1. **Separation of Concerns**: Cada capa tiene responsabilidades bien definidas
2. **Dependency Rule**: Las dependencias apuntan hacia el centro (dominio)
3. **Dependency Injection**: Uso de GetIt para inyección de dependencias
4. **Single Responsibility**: Cada clase tiene una única responsabilidad

---

## ✨ Características Principales

### Para Usuarios (Clientes)

- ✅ **Autenticación**: Login y registro de usuarios
- 🏠 **Home**: Visualización de productos disponibles
- 🔍 **Búsqueda**: Búsqueda y filtrado de productos
- 📂 **Categorías**: Navegación por categorías
- 📦 **Detalle de Producto**: Información detallada de cada producto
- 🛒 **Carrito**: Gestión de productos en el carrito
- ❤️ **Favoritos**: Lista de productos favoritos
- 📜 **Historial**: Historial de compras
- 👤 **Perfil**: Configuración de cuenta de usuario

### Para Administradores

- 📊 **Dashboard**: Panel de control con estadísticas
- 📦 **Gestión de Productos**: CRUD completo de productos
- 🖼️ **Gestión de Imágenes**: Carga y actualización de imágenes
- 👥 **Gestión de Usuarios**: CRUD completo de usuarios
- 📈 **Reportes**: Visualización de ventas y métricas
- 📋 **Órdenes**: Gestión de pedidos

---

## 📁 Estructura de Carpetas

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── config/                      # Configuraciones globales
│   ├── depends/                 # Inyección de dependencias
│   │   ├── dependency_injection.dart
│   │   ├── provider_client_url.dart
│   │   └── token_provider.dart
│   ├── routes/                  # Configuración de rutas
│   │   └── app_routes.dart
│   └── theme/                   # Temas de la aplicación
│       └── theme.dart
├── core/                        # Funcionalidades compartidas
│   ├── errors/                  # Manejo de errores
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/                 # Cliente HTTP
│   │   ├── api_client.dart
│   │   └── endpoints.dart
│   ├── usecases/               # Casos de uso base
│   │   └── usecase.dart
│   └── utils/                  # Utilidades
│       ├── currency_formatter.dart
│       └── guarani_input_formatter.dart
├── features/                   # Módulos por funcionalidad
│   ├── account_settings/       # Configuración de cuenta
│   │   └── presentation/
│   │       ├── admin/
│   │       └── user/
│   ├── auth/                   # Autenticación
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── cart/                   # Carrito de compras
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── category/               # Categorías
│   │   └── presentation/
│   ├── favorites/              # Favoritos
│   │   ├── domain/
│   │   └── presentation/
│   ├── history/                # Historial
│   │   └── presentation/
│   ├── home/                   # Pantalla principal
│   │   └── presentation/
│   │       ├── admin/
│   │       └── user/
│   ├── products/               # Productos
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── users/                  # Usuarios
│       ├── data/
│       ├── domain/
│       └── presentation/
└── docs/                       # Documentación
```

---

## 🔧 Tecnologías y Dependencias

### Dependencias Principales

```yaml
dependencies:
  flutter_sdk: ^3.8.0
  
  # Estado y Navegación
  flutter_riverpod: ^3.0.3    # State management
  go_router: ^17.0.0          # Navegación
  
  # Inyección de Dependencias
  get_it: ^8.2.0              # Service locator
  
  # HTTP y API
  http: ^1.5.0                # Cliente HTTP
  
  # UI y Componentes
  cupertino_icons: ^1.0.8     # Iconos iOS
  fl_chart: ^1.1.1            # Gráficos
  
  # Utilidades
  intl: ^0.20.2               # Internacionalización
  image_picker: ^1.0.7        # Selector de imágenes
  shared_preferences: ^2.5.3   # Almacenamiento local
```

### Dependencias de Desarrollo

```yaml
dev_dependencies:
  flutter_test:
  flutter_lints: ^5.0.0       # Linting
```

---

## ⚙️ Configuración del Proyecto

### Requisitos Previos

- Flutter SDK ^3.8.0
- Dart SDK incluido con Flutter
- Android Studio / Xcode (para desarrollo móvil)
- VS Code / Android Studio (IDE recomendado)

### Instalación

1. **Clonar el repositorio**
```bash
git clone <url-del-repositorio>
cd app_ecommerce
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar la URL de la API**

Editar el archivo `lib/config/depends/dependency_injection.dart`:
```dart
sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(
    client: sl(), 
    baseUrl: "http://TU_IP:PUERTO"
  ),
);
```

4. **Ejecutar la aplicación**
```bash
flutter run
```

### Configuración de Variables de Entorno

El proyecto utiliza dos endpoints diferentes:
- **Auth Service**: `http://192.168.0.160:8000`
- **Products Service**: `http://10.0.2.2:8080/api`

Asegúrate de actualizar estas URLs según tu entorno de desarrollo.

---

## 🧩 Módulos y Features

### 1. Authentication (auth)

**Propósito**: Gestionar la autenticación de usuarios

#### Entidades
```dart
class Login {
  final String accessToken;
  final String tokenType;
}

class Register {
  final String name;
  final String email;
  final String password;
  final String rol;
}

class AuthMe {
  final int id;
  final String name;
  final String email;
  final String rol;
  final bool isActive;
}
```

#### Casos de Uso
- `LoginUser`: Autenticación de usuario
- `RegisterUser`: Registro de nuevo usuario
- `GetAuthMe`: Obtener datos del usuario autenticado

#### Providers Principales
```dart
final authProvider = NotifierProvider<AuthNotifier, AuthState>
final loginUserProvider = Provider<LoginUser>
```

#### Flujo de Autenticación
1. Usuario ingresa credenciales
2. Se llama al caso de uso `LoginUser`
3. Se guarda el token en SharedPreferences
4. Se obtienen datos del usuario con `GetAuthMe`
5. Se actualiza el estado global

---

### 2. Products (products)

**Propósito**: Gestión completa de productos

#### Entidad
```dart
class Product {
  int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final bool isActive;
  final String imagen;
  final String category;
}
```

#### Casos de Uso
- `GetProducts`: Obtener lista de productos
- `CreateProduct`: Crear nuevo producto
- `UpdateProduct`: Actualizar producto existente
- `DeleteProduct`: Eliminar producto
- `UploadImage`: Subir imagen de producto
- `UpdateProductImage`: Actualizar imagen de producto

#### Providers Principales
```dart
final productNotifierProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>
final getProductUseCaseProvider = Provider<GetProducts>
final createProductUseCaseProvider = Provider<CreateProduct>
final updateProductUseCaseProvider = Provider<UpdateProduct>
final deleteProductUseCaseProvider = Provider<DeleteProduct>
```

#### Pantallas
- **Para Usuarios**:
  - `DetailProductScreen`: Detalle del producto
  
- **Para Administradores**:
  - `AdminProductsScreen`: Lista de productos (CRUD)
  - `AddProductScreen`: Agregar nuevo producto
  - `UpdateProductScreen`: Editar producto

---

### 3. Cart (cart)

**Propósito**: Gestión del carrito de compras

#### Entidades
```dart
class Cart {
  int id;
  List<Item> items;
}

class Item {
  int? id;
  Product product;
  int quantity;
}
```

#### Casos de Uso
- `GetCart`: Obtener carrito del usuario
- `AddCart`: Agregar producto al carrito
- `RemoveCartItem`: Eliminar producto del carrito
- `UpdateQuantity`: Actualizar cantidad de un producto
- `ClearCart`: Vaciar el carrito

#### Providers Principales
```dart
final cartProvider = StateNotifierProvider
final cartRemoteProvider = Provider
```

#### Pantallas
- `CartShoppingScreen`: Vista del carrito de compras
- `CardProductCart`: Widget de producto en el carrito

---

### 4. Users (users)

**Propósito**: Administración de usuarios (solo para admins)

#### Entidad
```dart
class User {
  int? id;
  final String name;
  final String email;
  String? password;
  final String rol;
  final bool isActive;
  DateTime? createdAt;
}
```

#### Casos de Uso
- `GetUsers`: Obtener lista de usuarios
- `CreateUser`: Crear nuevo usuario
- `UpdateUser`: Actualizar usuario
- `DeleteUser`: Eliminar usuario

#### Pantallas (Admin)
- `AdminUsersScreen`: Lista de usuarios
- `AddUserScreen`: Agregar usuario
- `UpdateUserScreen`: Editar usuario
- `UserCardAdmin`: Widget de tarjeta de usuario

---

### 5. Favorites (favorites)

**Propósito**: Gestión de productos favoritos

#### Entidad
```dart
class Favorites {
  // Estructura de favoritos
}
```

#### Pantallas
- `FavoritesScreen`: Lista de productos favoritos
- `FavoriteButton`: Botón para marcar/desmarcar favorito
- `FavoriteProductCard`: Tarjeta de producto favorito

---

### 6. Category (category)

**Propósito**: Navegación por categorías de productos

#### Pantallas
- `CategoriesScreen`: Lista de categorías
- `CategoryProductsScreen`: Productos de una categoría específica

---

### 7. Home (home)

**Propósito**: Pantalla principal para usuarios y administradores

#### Pantallas de Usuario
- `HomeScreen`: Pantalla principal con navegación inferior
- `HomeContent`: Contenido de la pantalla de inicio

#### Pantallas de Admin
- `HomeAdminScreen`: Dashboard administrativo
- Widgets:
  - `CardView`: Tarjetas de estadísticas
  - `GraficLinear`: Gráficos lineales
  - `ManageList`: Lista de gestión
  - `SelectionPeriod`: Selector de período

---

### 8. Account Settings (account_settings)

**Propósito**: Configuración de cuenta de usuario

#### Pantallas
- **Usuario**: `UserAccountScreen`
- **Admin**: `AdminAccountScreen`

---

### 9. History (history)

**Propósito**: Historial de compras del usuario

#### Pantallas
- `HistoryScreen`: Lista del historial de pedidos

---

## 🔄 Flujo de Datos

### Arquitectura de Capas

```
Presentation Layer (UI)
        ↓ (eventos)
        ↓
    Providers (Riverpod)
        ↓ (llamadas)
        ↓
     Use Cases
        ↓ (operaciones)
        ↓
    Repositories
        ↓ (solicitudes)
        ↓
   Data Sources (API/Local)
        ↓ (datos)
        ↓
    Models → Entities
        ↓ (respuesta)
        ↑
```

### Ejemplo de Flujo Completo: Obtener Productos

1. **UI (Presentation)**
```dart
// Widget solicita datos
final productsAsync = ref.watch(productNotifierProvider);
```

2. **Provider (Estado)**
```dart
// ProductNotifier maneja el estado
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final getProducts = ref.read(getProductUseCaseProvider);
    return await getProducts();
  }
}
```

3. **Use Case (Domain)**
```dart
// GetProducts ejecuta la lógica de negocio
class GetProducts {
  final ProductRepository repository;
  
  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
```

4. **Repository (Domain Interface)**
```dart
// Interfaz del repositorio
abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
```

5. **Repository Implementation (Data)**
```dart
// Implementación concreta
class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource remoteDataSource;
  
  @override
  Future<List<Product>> getProducts() async {
    final models = await remoteDataSource.getProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}
```

6. **Data Source (Data)**
```dart
// Fuente de datos (API)
class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));
    // Parsear y retornar modelos
  }
}
```

---

## 🎨 Sistema de Temas

### Configuración de Temas

El proyecto implementa temas claro y oscuro con Material Design 3:

```dart
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade100,
    colorScheme: ColorScheme.light(...),
    // Personalización de componentes
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFF0B132B),
    colorScheme: ColorScheme.dark(...),
    // Personalización de componentes
  );
}
```

### Componentes Personalizados

- SearchBar con estilo personalizado
- NavigationBar con indicadores personalizados
- InputDecoration con bordes redondeados
- ChipTheme para filtros y categorías

---

## 🛣️ Sistema de Navegación

### Configuración con Go Router

```dart
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Rutas de autenticación
    GoRoute(path: '/login', ...),
    GoRoute(path: '/register', ...),
    
    // Rutas de usuario
    GoRoute(path: '/homeUser', ...),
    GoRoute(path: '/productDetails', ...),
    GoRoute(path: '/cart', ...),
    GoRoute(path: '/favorites', ...),
    
    // Rutas de administrador
    GoRoute(path: '/homeAdmin', ...),
    GoRoute(path: '/adminProductScreen', ...),
    GoRoute(path: '/adminUserScreen', ...),
  ],
);
```

### Navegación con Parámetros

```dart
// Pasar objeto Product
context.push('/productDetails', extra: product);

// Recibir en la pantalla de destino
final product = state.extra as Product;
```

---

## 🔐 Gestión de Estado con Riverpod

### Tipos de Providers Utilizados

1. **Provider**: Para dependencias inmutables
```dart
final httpClientProvider = Provider<http.Client>((ref) => http.Client());
```

2. **StateNotifierProvider**: Para estado mutable
```dart
final cartProvider = StateNotifierProvider<CartNotifier, CartState>(...);
```

3. **AsyncNotifierProvider**: Para datos asíncronos
```dart
final productNotifierProvider = 
    AsyncNotifierProvider<ProductNotifier, List<Product>>(...);
```

4. **NotifierProvider**: Para estado complejo
```dart
final authProvider = NotifierProvider<AuthNotifier, AuthState>(...);
```

### Consumir Providers

```dart
// En ConsumerWidget
@override
Widget build(BuildContext context, WidgetRef ref) {
  final productsAsync = ref.watch(productNotifierProvider);
  
  return productsAsync.when(
    data: (products) => ListView(...),
    loading: () => CircularProgressIndicator(),
    error: (error, stack) => Text('Error: $error'),
  );
}
```

---

## 💾 Persistencia de Datos

### SharedPreferences

Utilizado para almacenar:
- Token de autenticación
- Tipo de token
- Preferencias de usuario

```dart
// Guardar
final prefs = await SharedPreferences.getInstance();
await prefs.setString('access_token', token);

// Leer
final token = prefs.getString('access_token');
```

---

## 🌐 Integración con API

### Cliente HTTP Personalizado

```dart
final http.Client client = http.Client();
```

### Manejo de Autenticación

```dart
// Headers con token
final headers = {
  'Authorization': 'Bearer $token',
  'Content-Type': 'application/json',
};
```

### Endpoints Principales

- **Auth**: Login, Register, Get User Info
- **Products**: CRUD de productos
- **Cart**: Gestión de carrito
- **Users**: CRUD de usuarios (admin)

---

## 🎯 Guía de Desarrollo

### Agregar un Nuevo Feature

1. **Crear la estructura de carpetas**
```
features/nuevo_feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── screens/
    ├── widgets/
    └── providers/
```

2. **Definir la entidad (Domain)**
```dart
class MiEntidad {
  final int id;
  final String nombre;
  
  MiEntidad({required this.id, required this.nombre});
}
```

3. **Crear el repositorio (Domain)**
```dart
abstract class MiRepositorio {
  Future<List<MiEntidad>> obtener();
}
```

4. **Implementar el repositorio (Data)**
```dart
class MiRepositorioImpl implements MiRepositorio {
  @override
  Future<List<MiEntidad>> obtener() async {
    // Implementación
  }
}
```

5. **Crear el caso de uso (Domain)**
```dart
class ObtenerDatos {
  final MiRepositorio repositorio;
  
  Future<List<MiEntidad>> call() async {
    return await repositorio.obtener();
  }
}
```

6. **Configurar providers (Presentation)**
```dart
final miProvider = AsyncNotifierProvider<MiNotifier, List<MiEntidad>>(...);
```

7. **Crear la pantalla (Presentation)**
```dart
class MiPantalla extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datosAsync = ref.watch(miProvider);
    // UI
  }
}
```

### Buenas Prácticas

1. **Naming Conventions**
   - Archivos: `snake_case.dart`
   - Clases: `PascalCase`
   - Variables: `camelCase`
   - Constantes: `lowerCamelCase` o `SCREAMING_SNAKE_CASE`

2. **Organización de Imports**
```dart
// 1. Paquetes de Dart
import 'dart:async';

// 2. Paquetes de Flutter
import 'package:flutter/material.dart';

// 3. Paquetes de terceros
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 4. Imports locales
import 'package:app_ecomerce/features/...';
```

3. **Manejo de Errores**
```dart
try {
  // Operación
} catch (e) {
  state = state.copyWith(
    isLoading: false,
    error: e.toString(),
  );
}
```

4. **Comentarios y Documentación**
```dart
/// Obtiene la lista de productos desde la API
/// 
/// Returns:
///   Lista de [Product] si la petición es exitosa
///   
/// Throws:
///   [ServerException] si hay un error en el servidor
Future<List<Product>> getProducts() async {
  // Implementación
}
```

---

## 🧪 Testing

### Estructura de Tests
```
test/
├── features/
│   ├── auth/
│   ├── products/
│   └── ...
├── core/
└── widget_test.dart
```

### Ejecutar Tests
```bash
flutter test
```

---

## 🚀 Build y Deployment

### Build para Android
```bash
flutter build apk --release
```

### Build para iOS
```bash
flutter build ios --release
```

### Build para Web
```bash
flutter build web
```

---

## 📝 Changelog

### Version 1.0.0 (Actual)
- ✅ Implementación de Clean Architecture
- ✅ Sistema de autenticación completo
- ✅ CRUD de productos
- ✅ Carrito de compras funcional
- ✅ Panel de administración
- ✅ Temas claro y oscuro
- ✅ Navegación con Go Router

### Próximas Características
- 🔄 Sistema de pagos
- 🔄 Notificaciones push
- 🔄 Chat de soporte
- 🔄 Sistema de reviews
- 🔄 Múltiples métodos de pago

---

## 🤝 Contribución

### Proceso de Contribución

1. Fork del proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

---

## 📞 Soporte y Contacto

Para preguntas o soporte, por favor abre un issue en el repositorio.

---

## 📄 Licencia

Este proyecto es privado y no está publicado en pub.dev.

---

**Última actualización**: Diciembre 2025
**Mantenido por**: Equipo de Desarrollo

