# 🏗️ Guía de Arquitectura - Clean Architecture

## Visión General

Este proyecto implementa **Clean Architecture** siguiendo los principios de Robert C. Martin (Uncle Bob), organizando el código en capas con responsabilidades claramente definidas.

## Capas de la Arquitectura

```
┌─────────────────────────────────────────────────────┐
│              PRESENTATION LAYER                      │
│  (UI, Widgets, Screens, State Management)           │
│  Providers (Riverpod) + Screens + Widgets           │
└────────────────┬────────────────────────────────────┘
                 │ Depende de ↓
┌────────────────┴────────────────────────────────────┐
│               DOMAIN LAYER                           │
│  (Business Logic, Entities, Use Cases)              │
│  Entities + Repositories (Interface) + Use Cases    │
└────────────────┬────────────────────────────────────┘
                 │ Depende de ↓
┌────────────────┴────────────────────────────────────┐
│                DATA LAYER                            │
│  (Data Sources, Models, Repository Implementation)  │
│  Models + Data Sources + Repositories (Impl)        │
└─────────────────────────────────────────────────────┘
```

## 1. Presentation Layer (Capa de Presentación)

### Responsabilidades
- Mostrar la interfaz de usuario
- Capturar eventos del usuario
- Gestionar el estado de la UI
- Comunicarse con los Use Cases a través de Providers

### Componentes

#### Screens (Pantallas)
```dart
// Ejemplo: product_screen.dart
class ProductScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productNotifierProvider);
    
    return productsAsync.when(
      data: (products) => ProductList(products: products),
      loading: () => LoadingWidget(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

#### Widgets (Componentes Reutilizables)
```dart
// Ejemplo: product_card.dart
class ProductCard extends StatelessWidget {
  final Product product;
  
  const ProductCard({required this.product});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.imagen),
          Text(product.nombre),
          Text('${product.precio}'),
        ],
      ),
    );
  }
}
```

#### Providers (State Management con Riverpod)
```dart
// Ejemplo: product_providers.dart

// Notifier para gestionar el estado
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final getProducts = ref.read(getProductUseCaseProvider);
    return await getProducts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final getProducts = ref.read(getProductUseCaseProvider);
      return await getProducts();
    });
  }

  Future<void> createProduct(Product product) async {
    final createUseCase = ref.read(createProductUseCaseProvider);
    await createUseCase(product);
    await refresh();
  }
}

// Provider del Notifier
final productNotifierProvider = 
    AsyncNotifierProvider<ProductNotifier, List<Product>>(
      () => ProductNotifier()
    );
```

### Flujo de Eventos

```
Usuario interactúa → Widget captura evento → Provider procesa
         ↓
    Use Case ejecuta lógica
         ↓
    State actualizado → UI se reconstruye
```

---

## 2. Domain Layer (Capa de Dominio)

### Responsabilidades
- Contener la lógica de negocio
- Definir las entidades del sistema
- Definir interfaces de repositorios
- Implementar casos de uso

### Componentes

#### Entities (Entidades)
Las entidades son objetos puros de Dart sin dependencias externas.

```dart
// Ejemplo: product.dart
class Product {
  final int? id;
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
```

**Características de las Entidades:**
- No tienen dependencias de frameworks
- Representan conceptos del negocio
- Son inmutables (preferiblemente)
- Contienen lógica de negocio simple

#### Repositories (Interfaces)
Definen contratos que la capa de datos debe implementar.

```dart
// Ejemplo: product_repository.dart
abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(int id);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);
  Future<String> uploadImage(String imagePath);
}
```

**Principios:**
- Son abstractas (interfaces)
- No contienen implementación
- Definen el contrato de datos
- Son independientes de frameworks

#### Use Cases (Casos de Uso)
Contienen la lógica de negocio de una operación específica.

```dart
// Ejemplo: get_products.dart
class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
```

```dart
// Ejemplo más complejo: create_product.dart
class CreateProduct {
  final ProductRepository repository;

  CreateProduct(this.repository);

  Future<void> call(Product product) async {
    // Validaciones de negocio
    if (product.precio <= 0) {
      throw Exception('El precio debe ser mayor a 0');
    }
    
    if (product.stock < 0) {
      throw Exception('El stock no puede ser negativo');
    }
    
    // Delegar al repositorio
    await repository.createProduct(product);
  }
}
```

**Características de los Use Cases:**
- Una clase por operación
- Contienen lógica de negocio
- Se comunican con repositories
- Son testeables de forma aislada
- Método `call()` para ejecutar

---

## 3. Data Layer (Capa de Datos)

### Responsabilidades
- Implementar repositorios
- Gestionar fuentes de datos (API, DB local)
- Convertir Models a Entities
- Manejar la persistencia

### Componentes

#### Models (Modelos de Datos)
Son DTOs (Data Transfer Objects) que representan la estructura de datos de la API o DB.

```dart
// Ejemplo: product_model.dart
class ProductModel {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final bool isActive;
  final String imagen;
  final String category;

  ProductModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.isActive,
    required this.imagen,
    required this.category,
  });

  // Conversión desde JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      isActive: json['isActive'] ?? true,
      imagen: json['imagen'] ?? '',
      category: json['category'] ?? '',
    );
  }

  // Conversión a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock,
      'isActive': isActive,
      'imagen': imagen,
      'category': category,
    };
  }

  // Conversión a Entity
  Product toEntity() {
    return Product(
      id: id,
      nombre: nombre,
      descripcion: descripcion,
      precio: precio,
      stock: stock,
      isActive: isActive,
      imagen: imagen,
      category: category,
    );
  }

  // Conversión desde Entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      nombre: product.nombre,
      descripcion: product.descripcion,
      precio: product.precio,
      stock: product.stock,
      isActive: product.isActive,
      imagen: product.imagen,
      category: product.category,
    );
  }
}
```

#### Data Sources (Fuentes de Datos)
Gestionan la comunicación con APIs, bases de datos, etc.

```dart
// Ejemplo: products_remote_data_source.dart

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ProductRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException('Error al obtener productos');
    }
  }

  @override
  Future<void> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw ServerException('Error al crear producto');
    }
  }

  // Más métodos...
}
```

#### Repository Implementation
Implementa las interfaces definidas en el dominio.

```dart
// Ejemplo: product_repository_impl.dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw ServerFailure('Error al obtener productos');
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      await remoteDataSource.createProduct(productModel);
    } catch (e) {
      throw ServerFailure('Error al crear producto');
    }
  }

  // Más métodos...
}
```

---

## Dependency Rule (Regla de Dependencias)

### Principio Fundamental
**Las dependencias siempre apuntan hacia adentro (hacia el dominio)**

```
Presentation → Domain ← Data
```

- ✅ Presentation puede depender de Domain
- ✅ Data puede depender de Domain
- ❌ Domain NO puede depender de Presentation ni Data
- ❌ Data NO puede depender de Presentation

### Beneficios

1. **Independencia de Frameworks**: El dominio no conoce Flutter, Riverpod, HTTP, etc.
2. **Testabilidad**: Cada capa se puede testear de forma aislada
3. **Flexibilidad**: Puedes cambiar la UI sin afectar la lógica de negocio
4. **Escalabilidad**: Fácil de mantener y extender

---

## Dependency Injection con GetIt

### Configuración

```dart
// dependency_injection.dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Cliente HTTP
  sl.registerLazySingleton(() => http.Client());

  // Data Sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      client: sl(),
      baseUrl: "http://API_URL",
    ),
  );

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl<ProductsRemoteDataSource>()
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetProducts>(
    () => GetProducts(sl<ProductRepository>()),
  );
  
  sl.registerLazySingleton<CreateProduct>(
    () => CreateProduct(sl<ProductRepository>()),
  );
}
```

### Uso en Providers

```dart
// Usando GetIt
final getProductUseCaseProvider = Provider<GetProducts>((ref) {
  return sl<GetProducts>();
});

// O directamente con Riverpod
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
});
```

---

## Flujo Completo de Datos

### Ejemplo: Crear un Producto

```
1. Usuario presiona "Guardar" en la UI
              ↓
2. Widget llama al Provider
   ref.read(productNotifierProvider.notifier).createProduct(product)
              ↓
3. Provider llama al Use Case
   final createUseCase = ref.read(createProductUseCaseProvider);
   await createUseCase(product);
              ↓
4. Use Case ejecuta validaciones y llama al Repository
   if (product.precio <= 0) throw Exception();
   await repository.createProduct(product);
              ↓
5. Repository convierte Entity a Model y llama al Data Source
   final model = ProductModel.fromEntity(product);
   await remoteDataSource.createProduct(model);
              ↓
6. Data Source hace la petición HTTP
   await client.post('/products', body: model.toJson());
              ↓
7. Respuesta viaja de vuelta hasta la UI
   Repository → Use Case → Provider → Widget
              ↓
8. Provider actualiza el estado y la UI se reconstruye
```

---

## Error Handling (Manejo de Errores)

### Jerarquía de Errores

```dart
// core/errors/exceptions.dart
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

// core/errors/failures.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}
```

### Manejo en Capas

#### Data Source
```dart
// Lanza Exceptions
if (response.statusCode != 200) {
  throw ServerException('Error en el servidor');
}
```

#### Repository
```dart
// Convierte Exceptions a Failures
try {
  return await remoteDataSource.getProducts();
} on ServerException catch (e) {
  throw ServerFailure(e.message);
} catch (e) {
  throw ServerFailure('Error desconocido');
}
```

#### Provider
```dart
// Maneja Failures y actualiza el estado
try {
  final products = await getProducts();
  state = AsyncData(products);
} on ServerFailure catch (e) {
  state = AsyncError(e.message, StackTrace.current);
}
```

---

## Testing Strategy

### Unit Tests por Capa

#### Domain Layer Tests
```dart
// test/domain/usecases/get_products_test.dart
void main() {
  late GetProducts useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProducts(mockRepository);
  });

  test('should get products from repository', () async {
    // Arrange
    when(() => mockRepository.getProducts())
        .thenAnswer((_) async => [testProduct]);

    // Act
    final result = await useCase();

    // Assert
    expect(result, [testProduct]);
    verify(() => mockRepository.getProducts()).called(1);
  });
}
```

#### Data Layer Tests
```dart
// test/data/repositories/product_repository_impl_test.dart
void main() {
  late ProductRepositoryImpl repository;
  late MockProductsRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockProductsRemoteDataSource();
    repository = ProductRepositoryImpl(remoteDataSource: mockDataSource);
  });

  test('should return products when call to data source is successful', () async {
    // Arrange
    when(() => mockDataSource.getProducts())
        .thenAnswer((_) async => [testProductModel]);

    // Act
    final result = await repository.getProducts();

    // Assert
    expect(result, [testProduct]);
  });
}
```

---

## Mejores Prácticas

### 1. Separación de Responsabilidades
- Cada clase debe tener una única responsabilidad
- Los Use Cases deben ser pequeños y específicos

### 2. Inmutabilidad
- Preferir objetos inmutables
- Usar `copyWith` para actualizaciones

### 3. Dependency Inversion
- Depender de abstracciones, no de implementaciones
- Usar interfaces para los contratos

### 4. Single Source of Truth
- El estado debe tener una única fuente de verdad
- Los Providers de Riverpod gestionan el estado global

### 5. Error Handling Consistente
- Usar el sistema de Exceptions y Failures
- Propagar errores correctamente a través de las capas

---

## Diagrama de Componentes

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │   Widgets    │  │   Providers  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────┴────────────────────────────────┐
│                        DOMAIN                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Entities   │  │ Repositories │  │  Use Cases   │      │
│  │              │  │ (Interface)  │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────┴────────────────────────────────┐
│                         DATA                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │    Models    │  │ Data Sources │  │ Repositories │      │
│  │              │  │  (API/Local) │  │    (Impl)    │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

---

## Conclusión

Esta arquitectura proporciona:
- ✅ Código mantenible y escalable
- ✅ Alta testabilidad
- ✅ Independencia de frameworks
- ✅ Separación clara de responsabilidades
- ✅ Flexibilidad para cambios futuros

**Recuerda**: La clave está en respetar la regla de dependencias y mantener cada capa enfocada en su responsabilidad específica.

