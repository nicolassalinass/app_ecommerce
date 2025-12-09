# 🚀 Guía de Desarrollo - Setup y Best Practices

## Índice
1. [Configuración del Entorno](#configuración-del-entorno)
2. [Estructura del Proyecto](#estructura-del-proyecto)
3. [Convenciones de Código](#convenciones-de-código)
4. [State Management con Riverpod](#state-management-con-riverpod)
5. [Inyección de Dependencias](#inyección-de-dependencias)
6. [Manejo de Errores](#manejo-de-errores)
7. [Testing](#testing)
8. [Git Workflow](#git-workflow)
9. [Performance y Optimización](#performance-y-optimización)
10. [Debugging](#debugging)

---

## Configuración del Entorno

### Requisitos del Sistema

```yaml
Flutter SDK: ^3.8.0
Dart SDK: Incluido con Flutter
IDE: VS Code o Android Studio
Extensiones Recomendadas:
  - Flutter
  - Dart
  - Flutter Riverpod Snippets
  - Error Lens
  - GitLens
```

### Instalación Paso a Paso

#### 1. Instalar Flutter
```bash
# Windows (PowerShell)
# Descargar Flutter SDK desde flutter.dev
# Extraer en C:\src\flutter

# Agregar al PATH
$env:Path += ";C:\src\flutter\bin"

# Verificar instalación
flutter doctor
```

#### 2. Clonar el Proyecto
```bash
git clone <repository-url>
cd app_ecommerce
```

#### 3. Instalar Dependencias
```bash
flutter pub get
```

#### 4. Configurar la API
Editar `lib/config/depends/dependency_injection.dart`:
```dart
sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(
    client: sl(), 
    baseUrl: "http://TU_IP:TU_PUERTO" // <-- Cambiar aquí
  ),
);
```

#### 5. Ejecutar la App
```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# O simplemente
flutter run
```

### Configuración de VS Code

#### settings.json
```json
{
  "dart.lineLength": 80,
  "editor.rulers": [80],
  "editor.formatOnSave": true,
  "dart.previewFlutterUiGuides": true,
  "dart.previewFlutterUiGuidesCustomTracking": true,
  "[dart]": {
    "editor.defaultFormatter": "Dart-Code.dart-code",
    "editor.formatOnSave": true,
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  }
}
```

#### launch.json
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "app_ecomerce",
      "request": "launch",
      "type": "dart"
    },
    {
      "name": "app_ecomerce (profile mode)",
      "request": "launch",
      "type": "dart",
      "flutterMode": "profile"
    },
    {
      "name": "app_ecomerce (release mode)",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release"
    }
  ]
}
```

---

## Estructura del Proyecto

### Organización por Features

```
lib/
├── main.dart                 # Punto de entrada
├── config/                   # Configuración global
│   ├── depends/             # DI y providers globales
│   ├── routes/              # Configuración de rutas
│   └── theme/               # Temas de la app
├── core/                    # Código compartido
│   ├── errors/              # Excepciones y failures
│   ├── network/             # Cliente HTTP
│   ├── usecases/            # UseCase base
│   └── utils/               # Utilidades
└── features/                # Módulos por funcionalidad
    ├── feature_name/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── screens/
    │       ├── widgets/
    │       └── providers/
```

### Cuándo Crear un Nuevo Feature

Crea un nuevo feature cuando:
- ✅ Representa una funcionalidad de negocio completa
- ✅ Tiene su propia lógica de dominio
- ✅ Puede ser desarrollado y testeado independientemente
- ✅ Tiene su propio conjunto de pantallas y flujos

No creates un nuevo feature si:
- ❌ Es solo un widget reutilizable (va en `core/widgets/`)
- ❌ Es una utilidad compartida (va en `core/utils/`)
- ❌ Es parte de otro feature existente

---

## Convenciones de Código

### Naming Conventions

#### Archivos
```dart
// snake_case para archivos
product_repository.dart
user_card_admin.dart
home_screen.dart
```

#### Clases
```dart
// PascalCase para clases
class ProductRepository {}
class UserCardAdmin extends StatelessWidget {}
class HomeScreen extends ConsumerWidget {}
```

#### Variables y Métodos
```dart
// camelCase para variables y métodos
final userName = 'Juan';
void getUserData() {}
Future<void> loadProducts() async {}
```

#### Constantes
```dart
// lowerCamelCase para constantes locales
const maxRetries = 3;
const defaultTimeout = Duration(seconds: 30);

// SCREAMING_SNAKE_CASE para constantes globales (opcional)
const String API_BASE_URL = 'http://...';
```

#### Providers
```dart
// Sufijo según el tipo
final userProvider = Provider<User>(...);
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(...);
final productsAsyncProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(...);
```

### Organización de Imports

```dart
// 1. Imports de Dart
import 'dart:async';
import 'dart:convert';

// 2. Imports de Flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// 3. Paquetes de terceros (alfabéticamente)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

// 4. Imports locales (por capas)
import 'package:app_ecomerce/core/errors/failures.dart';
import 'package:app_ecomerce/features/products/domain/entities/product.dart';
import 'package:app_ecomerce/features/products/presentation/providers/product_providers.dart';
```

### Formato de Código

#### Líneas
```dart
// Máximo 80 caracteres por línea
// Si excede, dividir en múltiples líneas

// ❌ Evitar
final user = User(id: 1, name: 'Juan Pérez', email: 'juan@example.com', rol: 'cliente', isActive: true);

// ✅ Correcto
final user = User(
  id: 1,
  name: 'Juan Pérez',
  email: 'juan@example.com',
  rol: 'cliente',
  isActive: true,
);
```

#### Trailing Commas
```dart
// Siempre usar trailing comma en listas de parámetros
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Hello'),
      Text('World'),  // <-- trailing comma
    ],  // <-- trailing comma
  );
}
```

#### Const Constructors
```dart
// Usar const cuando sea posible
const SizedBox(height: 16)
const Text('Static text')
const EdgeInsets.all(8)
```

### Comentarios y Documentación

#### Comentarios de Documentación
```dart
/// Obtiene la lista de productos desde la API.
/// 
/// Retorna una lista de [Product] si la petición es exitosa.
/// 
/// Lanza [ServerException] si hay un error en el servidor.
/// 
/// Ejemplo:
/// ```dart
/// final products = await getProducts();
/// print('Total: ${products.length}');
/// ```
Future<List<Product>> getProducts() async {
  // Implementación
}
```

#### Comentarios TODO
```dart
// TODO: Implementar paginación
// FIXME: Corregir bug de memoria
// HACK: Solución temporal hasta que se arregle el backend
```

---

## State Management con Riverpod

### Tipos de Providers y Cuándo Usarlos

#### 1. Provider
Para valores inmutables que nunca cambian.
```dart
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final baseUrlProvider = Provider<String>((ref) {
  return 'http://192.168.0.160:8000';
});
```

#### 2. StateProvider
Para estado simple que puede cambiar.
```dart
final counterProvider = StateProvider<int>((ref) => 0);

// Usar
ref.read(counterProvider.notifier).state++;
```

#### 3. NotifierProvider
Para estado complejo con lógica.
```dart
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await ref.read(loginUseCaseProvider)(email, password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
```

#### 4. AsyncNotifierProvider
Para datos asíncronos.
```dart
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
}

final productNotifierProvider = 
    AsyncNotifierProvider<ProductNotifier, List<Product>>(() {
      return ProductNotifier();
    });
```

#### 5. FutureProvider
Para operaciones asíncronas simples.
```dart
final userDataProvider = FutureProvider<User>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  return await fetchUser(userId);
});
```

### Consumir Providers

#### En Widgets
```dart
// ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);
    
    return products.when(
      data: (data) => ListView(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

// Consumer
class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final products = ref.watch(productNotifierProvider);
        return ListView(...);
      },
    );
  }
}
```

#### Leer vs Watch
```dart
// watch: Se reconstruye cuando el provider cambia
final products = ref.watch(productNotifierProvider);

// read: Lee el valor una vez, sin reconstruir
final notifier = ref.read(productNotifierProvider.notifier);
notifier.refresh();

// listen: Ejecuta callback cuando cambia
ref.listen(productNotifierProvider, (previous, next) {
  if (next.hasError) {
    showSnackBar('Error al cargar productos');
  }
});
```

### Patrón de Estado

```dart
// Estado inmutable con copyWith
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }
}
```

---

## Inyección de Dependencias

### GetIt Setup

```dart
// config/depends/dependency_injection.dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton(() => http.Client());

  // Features - se registran en orden de dependencia
  _initAuthFeature();
  _initProductsFeature();
  _initCartFeature();
}

void _initAuthFeature() {
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl(), baseUrl: "..."),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
}
```

### Combinando GetIt con Riverpod

```dart
// Opción 1: Usar GetIt directamente
final loginUseCaseProvider = Provider<LoginUser>((ref) {
  return sl<LoginUser>();
});

// Opción 2: Crear providers que construyen las dependencias
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: dataSource);
});

final loginUseCaseProvider = Provider<LoginUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUser(repository);
});
```

### Buenas Prácticas de DI

1. **Registrar interfaces, no implementaciones**
```dart
// ✅ Correcto
sl.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(...)
);

// ❌ Evitar
sl.registerLazySingleton<ProductRepositoryImpl>(
  () => ProductRepositoryImpl(...)
);
```

2. **Usar Factory vs Singleton correctamente**
```dart
// Singleton: Una única instancia
sl.registerLazySingleton<HttpClient>(() => HttpClient());

// Factory: Nueva instancia cada vez
sl.registerFactory<CreateProduct>(() => CreateProduct(sl()));
```

3. **Inicializar en el orden correcto**
```dart
// 1. Core (HTTP, Storage, etc.)
// 2. Data Sources
// 3. Repositories
// 4. Use Cases
```

---

## Manejo de Errores

### Jerarquía de Errores

```dart
// core/errors/exceptions.dart
abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class ServerException extends AppException {
  ServerException(String message) : super(message);
}

class CacheException extends AppException {
  CacheException(String message) : super(message);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
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

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}
```

### Try-Catch en Diferentes Capas

#### Data Source
```dart
Future<List<ProductModel>> getProducts() async {
  try {
    final response = await client.get(Uri.parse('$baseUrl/products'));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException('Error ${response.statusCode}');
    }
  } on SocketException {
    throw NetworkException('No hay conexión a internet');
  } on FormatException {
    throw ServerException('Respuesta inválida del servidor');
  } catch (e) {
    throw ServerException('Error desconocido: $e');
  }
}
```

#### Repository
```dart
@override
Future<List<Product>> getProducts() async {
  try {
    final productModels = await remoteDataSource.getProducts();
    return productModels.map((model) => model.toEntity()).toList();
  } on ServerException catch (e) {
    throw ServerFailure(e.message);
  } on NetworkException catch (e) {
    throw NetworkFailure(e.message);
  } catch (e) {
    throw ServerFailure('Error al obtener productos: $e');
  }
}
```

#### Provider/Notifier
```dart
Future<void> loadProducts() async {
  state = state.copyWith(isLoading: true, error: null);
  
  try {
    final products = await ref.read(getProductsUseCaseProvider)();
    state = state.copyWith(
      isLoading: false,
      products: products,
    );
  } on ServerFailure catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: 'Error del servidor: ${e.message}',
    );
  } on NetworkFailure catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: 'Sin conexión: ${e.message}',
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: 'Error inesperado: $e',
    );
  }
}
```

#### UI
```dart
ref.listen(productNotifierProvider, (previous, next) {
  next.whenOrNull(
    error: (error, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    },
  );
});
```

---

## Testing

### Estructura de Tests

```
test/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_data_source_test.dart
│   │   │   ├── models/
│   │   │   │   └── login_model_test.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl_test.dart
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_user_test.dart
│   │   └── presentation/
│   │       └── providers/
│   │           └── auth_provider_test.dart
│   └── products/
│       └── ...
└── core/
    └── utils/
        └── currency_formatter_test.dart
```

### Unit Tests

```dart
// test/domain/usecases/get_products_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProductRepository])
void main() {
  late GetProducts useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProducts(mockRepository);
  });

  group('GetProducts UseCase', () {
    final testProducts = [
      Product(
        id: 1,
        nombre: 'Test Product',
        descripcion: 'Test',
        precio: 1000,
        stock: 10,
        isActive: true,
        imagen: 'test.jpg',
        category: 'Test',
      ),
    ];

    test('should get products from repository', () async {
      // Arrange
      when(mockRepository.getProducts())
          .thenAnswer((_) async => testProducts);

      // Act
      final result = await useCase();

      // Assert
      expect(result, testProducts);
      verify(mockRepository.getProducts()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw ServerFailure when repository fails', () async {
      // Arrange
      when(mockRepository.getProducts())
          .thenThrow(ServerFailure('Server error'));

      // Act & Assert
      expect(() => useCase(), throwsA(isA<ServerFailure>()));
    });
  });
}
```

### Widget Tests

```dart
// test/presentation/widgets/product_card_test.dart
void main() {
  testWidgets('ProductCard displays product information', (tester) async {
    // Arrange
    final testProduct = Product(
      id: 1,
      nombre: 'Test Product',
      precio: 1000,
      // ...más campos
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(product: testProduct),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Gs. 1.000'), findsOneWidget);
  });
}
```

### Ejecutar Tests

```bash
# Todos los tests
flutter test

# Tests específicos
flutter test test/domain/usecases/

# Con coverage
flutter test --coverage

# Ver coverage (requiere lcov)
genhtml coverage/lcov.info -o coverage/html
```

---

## Git Workflow

### Branch Strategy

```
main (producción)
  └── develop (desarrollo)
       ├── feature/login
       ├── feature/products-crud
       ├── bugfix/cart-update
       └── hotfix/critical-bug
```

### Naming Conventions

```bash
# Features
feature/nombre-descriptivo
feature/user-authentication
feature/product-search

# Bugfixes
bugfix/descripcion-del-bug
bugfix/cart-total-calculation

# Hotfixes
hotfix/descripcion-critica
hotfix/payment-crash

# Releases
release/v1.0.0
```

### Commit Messages

```bash
# Formato
<tipo>: <descripción corta>

<descripción detallada (opcional)>

# Tipos:
feat: Nueva funcionalidad
fix: Corrección de bug
docs: Cambios en documentación
style: Formato, punto y coma, etc.
refactor: Refactorización de código
test: Agregar o modificar tests
chore: Actualizar dependencias, config, etc.

# Ejemplos:
git commit -m "feat: agregar pantalla de login"
git commit -m "fix: corregir cálculo de total en carrito"
git commit -m "docs: actualizar README con instrucciones de instalación"
git commit -m "refactor: mejorar estructura de providers"
```

### Git Commands Útiles

```bash
# Crear nueva branch
git checkout -b feature/mi-feature

# Actualizar desde develop
git checkout develop
git pull
git checkout feature/mi-feature
git rebase develop

# Commit
git add .
git commit -m "feat: descripción"

# Push
git push origin feature/mi-feature

# Merge a develop (después de code review)
git checkout develop
git merge feature/mi-feature
git push origin develop
```

---

## Performance y Optimización

### 1. Optimizar Listas

```dart
// ✅ Usar ListView.builder para listas grandes
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(items[index]);
  },
)

// ❌ Evitar ListView con children
ListView(
  children: items.map((item) => ItemWidget(item)).toList(),
)
```

### 2. Const Widgets

```dart
// ✅ Usar const siempre que sea posible
const Text('Static text')
const SizedBox(height: 16)
const Padding(padding: EdgeInsets.all(8))
```

### 3. Cacheo de Imágenes

```dart
// Usar CachedNetworkImage
CachedNetworkImage(
  imageUrl: product.imagen,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### 4. Evitar Rebuilds Innecesarios

```dart
// ✅ Separar widgets que no deben reconstruirse
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const StaticHeader(), // No se reconstruye
        DynamicContent(ref: ref), // Solo esto se reconstruye
      ],
    );
  }
}
```

### 5. Lazy Loading

```dart
// Cargar datos bajo demanda
class ProductNotifier extends AsyncNotifier<List<Product>> {
  int _page = 1;
  
  Future<void> loadMore() async {
    _page++;
    final newProducts = await _fetchProducts(page: _page);
    state = AsyncData([...state.value!, ...newProducts]);
  }
}
```

---

## Debugging

### Flutter DevTools

```bash
# Abrir DevTools
flutter pub global activate devtools
flutter pub global run devtools

# O desde VS Code
# Cmd/Ctrl + Shift + P > "Flutter: Open DevTools"
```

### Print Debugging

```dart
// Debug print (solo en debug mode)
debugPrint('Value: $value');

// Print con color
print('\x1B[31mError: $error\x1B[0m'); // Rojo
print('\x1B[32mSuccess: $message\x1B[0m'); // Verde
```

### Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

### Breakpoints en VS Code

1. Click en el margen izquierdo de la línea
2. Run > Start Debugging (F5)
3. La ejecución se pausará en el breakpoint

### Hot Reload vs Hot Restart

```bash
# Hot Reload (r)
# - Rápido
# - Mantiene el estado
# - Para cambios en UI

# Hot Restart (R)
# - Más lento
# - Resetea el estado
# - Para cambios en lógica/inicialización
```

---

## Comandos Útiles

### Flutter

```bash
# Limpiar build
flutter clean

# Obtener dependencias
flutter pub get

# Actualizar dependencias
flutter pub upgrade

# Analizar código
flutter analyze

# Formatear código
flutter format lib/

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Ver dispositivos
flutter devices

# Ver logs
flutter logs
```

### Dart

```bash
# Ejecutar script
dart run script.dart

# Analizar código
dart analyze

# Formatear
dart format .

# Fix issues
dart fix --apply
```

---

## Checklist Antes de Commit

- [ ] Código formateado (`flutter format .`)
- [ ] Sin warnings de análisis (`flutter analyze`)
- [ ] Tests pasan (`flutter test`)
- [ ] Sin console.log/print innecesarios
- [ ] Comentarios actualizados
- [ ] Imports organizados
- [ ] Nombres descriptivos
- [ ] Sin código comentado
- [ ] README actualizado si es necesario

---

## Recursos Adicionales

### Documentación Oficial
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Docs](https://dart.dev/guides)
- [Riverpod Docs](https://riverpod.dev/)

### Tutoriales Recomendados
- Flutter & Dart - The Complete Guide (Udemy)
- Reso Coder - Clean Architecture Tutorial
- Riverpod Essential Course

### Comunidad
- [r/FlutterDev](https://reddit.com/r/FlutterDev)
- [Flutter Discord](https://discord.gg/flutter)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

**Última actualización**: Diciembre 2025

