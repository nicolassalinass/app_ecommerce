# 📚 Guía de API - Endpoints y Documentación

## Índice
1. [Configuración de la API](#configuración-de-la-api)
2. [Autenticación](#autenticación)
3. [Endpoints de Productos](#endpoints-de-productos)
4. [Endpoints de Carrito](#endpoints-de-carrito)
5. [Endpoints de Usuarios](#endpoints-de-usuarios)
6. [Manejo de Errores](#manejo-de-errores)
7. [Ejemplos de Uso](#ejemplos-de-uso)

---

## Configuración de la API

### Base URLs

El proyecto utiliza dos servicios de backend:

```dart
// Auth Service
final authBaseUrl = "http://192.168.0.160:8000";

// Products/Main Service
final mainBaseUrl = "http://10.0.2.2:8080/api";
```

### Cliente HTTP

```dart
import 'package:http/http.dart' as http;

final client = http.Client();
```

### Headers Comunes

```dart
// Sin autenticación
final headers = {
  'Content-Type': 'application/json',
};

// Con autenticación
final authHeaders = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $accessToken',
};
```

---

## Autenticación

### 1. Login

**Endpoint**: `POST /auth/login`

**Request Body**:
```json
{
  "username": "user@example.com",
  "password": "password123"
}
```

**Response** (200 OK):
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer"
}
```

**Implementación**:
```dart
Future<Login> login(String username, String password) async {
  final response = await client.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return LoginModel.fromJson(data).toEntity();
  } else {
    throw ServerException('Error al iniciar sesión');
  }
}
```

### 2. Register

**Endpoint**: `POST /auth/register`

**Request Body**:
```json
{
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "password": "password123",
  "rol": "cliente"
}
```

**Response** (201 Created):
```json
{
  "message": "Usuario registrado exitosamente",
  "user_id": 1
}
```

**Implementación**:
```dart
Future<void> register(Register registerData) async {
  final response = await client.post(
    Uri.parse('$baseUrl/auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': registerData.name,
      'email': registerData.email,
      'password': registerData.password,
      'rol': registerData.rol,
    }),
  );

  if (response.statusCode != 201) {
    throw ServerException('Error al registrar usuario');
  }
}
```

### 3. Get Current User (Auth Me)

**Endpoint**: `GET /auth/me`

**Headers**: Requiere autenticación

**Response** (200 OK):
```json
{
  "id": 1,
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "rol": "cliente",
  "isActive": true
}
```

**Implementación**:
```dart
Future<AuthMe> getAuthMe(String token) async {
  final response = await client.get(
    Uri.parse('$baseUrl/auth/me'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return AuthMeModel.fromJson(data).toEntity();
  } else {
    throw ServerException('Error al obtener datos del usuario');
  }
}
```

---

## Endpoints de Productos

### 1. Obtener Todos los Productos

**Endpoint**: `GET /products`

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "nombre": "Laptop Dell",
    "descripcion": "Laptop de alto rendimiento",
    "precio": 5000000,
    "stock": 10,
    "isActive": true,
    "imagen": "http://example.com/image.jpg",
    "category": "Electrónica"
  },
  {
    "id": 2,
    "nombre": "Mouse Logitech",
    "descripcion": "Mouse inalámbrico",
    "precio": 150000,
    "stock": 50,
    "isActive": true,
    "imagen": "http://example.com/mouse.jpg",
    "category": "Accesorios"
  }
]
```

**Implementación**:
```dart
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
```

### 2. Obtener Producto por ID

**Endpoint**: `GET /products/{id}`

**Response** (200 OK):
```json
{
  "id": 1,
  "nombre": "Laptop Dell",
  "descripcion": "Laptop de alto rendimiento",
  "precio": 5000000,
  "stock": 10,
  "isActive": true,
  "imagen": "http://example.com/image.jpg",
  "category": "Electrónica"
}
```

### 3. Crear Producto

**Endpoint**: `POST /products`

**Headers**: Requiere autenticación (admin)

**Request Body**:
```json
{
  "nombre": "Teclado Mecánico",
  "descripcion": "Teclado gaming RGB",
  "precio": 450000,
  "stock": 20,
  "isActive": true,
  "imagen": "http://example.com/teclado.jpg",
  "category": "Accesorios"
}
```

**Response** (201 Created):
```json
{
  "id": 3,
  "nombre": "Teclado Mecánico",
  "descripcion": "Teclado gaming RGB",
  "precio": 450000,
  "stock": 20,
  "isActive": true,
  "imagen": "http://example.com/teclado.jpg",
  "category": "Accesorios"
}
```

**Implementación**:
```dart
Future<void> createProduct(ProductModel product, String token) async {
  final response = await client.post(
    Uri.parse('$baseUrl/products'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode(product.toJson()),
  );

  if (response.statusCode != 201) {
    throw ServerException('Error al crear producto');
  }
}
```

### 4. Actualizar Producto

**Endpoint**: `PUT /products/{id}`

**Headers**: Requiere autenticación (admin)

**Request Body**:
```json
{
  "nombre": "Laptop Dell Actualizada",
  "descripcion": "Nueva descripción",
  "precio": 5500000,
  "stock": 8,
  "isActive": true,
  "imagen": "http://example.com/new-image.jpg",
  "category": "Electrónica"
}
```

**Response** (200 OK):
```json
{
  "message": "Producto actualizado exitosamente"
}
```

**Implementación**:
```dart
Future<void> updateProduct(int id, ProductModel product, String token) async {
  final response = await client.put(
    Uri.parse('$baseUrl/products/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode(product.toJson()),
  );

  if (response.statusCode != 200) {
    throw ServerException('Error al actualizar producto');
  }
}
```

### 5. Eliminar Producto

**Endpoint**: `DELETE /products/{id}`

**Headers**: Requiere autenticación (admin)

**Response** (200 OK):
```json
{
  "message": "Producto eliminado exitosamente"
}
```

**Implementación**:
```dart
Future<void> deleteProduct(int id, String token) async {
  final response = await client.delete(
    Uri.parse('$baseUrl/products/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw ServerException('Error al eliminar producto');
  }
}
```

### 6. Subir Imagen de Producto

**Endpoint**: `POST /products/upload-image`

**Headers**: 
- Requiere autenticación (admin)
- Content-Type: multipart/form-data

**Request Body** (multipart):
```
file: [binary data]
```

**Response** (200 OK):
```json
{
  "image_url": "http://example.com/uploads/image-123456.jpg"
}
```

**Implementación**:
```dart
Future<String> uploadImage(String imagePath, String token) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrl/products/upload-image'),
  );

  request.headers['Authorization'] = 'Bearer $token';
  request.files.add(await http.MultipartFile.fromPath('file', imagePath));

  var response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final data = json.decode(responseData);
    return data['image_url'];
  } else {
    throw ServerException('Error al subir imagen');
  }
}
```

### 7. Actualizar Imagen de Producto

**Endpoint**: `PUT /products/{id}/image`

**Headers**: 
- Requiere autenticación (admin)
- Content-Type: multipart/form-data

**Request Body** (multipart):
```
file: [binary data]
```

**Response** (200 OK):
```json
{
  "message": "Imagen actualizada exitosamente",
  "image_url": "http://example.com/uploads/image-789012.jpg"
}
```

---

## Endpoints de Carrito

### 1. Obtener Carrito del Usuario

**Endpoint**: `GET /cart`

**Headers**: Requiere autenticación

**Response** (200 OK):
```json
{
  "id": 1,
  "items": [
    {
      "id": 1,
      "product": {
        "id": 1,
        "nombre": "Laptop Dell",
        "precio": 5000000,
        "imagen": "http://example.com/image.jpg"
      },
      "quantity": 2
    },
    {
      "id": 2,
      "product": {
        "id": 3,
        "nombre": "Mouse",
        "precio": 150000,
        "imagen": "http://example.com/mouse.jpg"
      },
      "quantity": 1
    }
  ]
}
```

**Implementación**:
```dart
Future<CartModel> getCart(String token) async {
  final response = await client.get(
    Uri.parse('$baseUrl/cart'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return CartModel.fromJson(data);
  } else {
    throw ServerException('Error al obtener carrito');
  }
}
```

### 2. Agregar Producto al Carrito

**Endpoint**: `POST /cart/add`

**Headers**: Requiere autenticación

**Request Body**:
```json
{
  "product_id": 1,
  "quantity": 2
}
```

**Response** (200 OK):
```json
{
  "message": "Producto agregado al carrito",
  "cart_item_id": 5
}
```

**Implementación**:
```dart
Future<void> addToCart(int productId, int quantity, String token) async {
  final response = await client.post(
    Uri.parse('$baseUrl/cart/add'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'product_id': productId,
      'quantity': quantity,
    }),
  );

  if (response.statusCode != 200) {
    throw ServerException('Error al agregar producto al carrito');
  }
}
```

### 3. Actualizar Cantidad en Carrito

**Endpoint**: `PUT /cart/items/{item_id}`

**Headers**: Requiere autenticación

**Request Body**:
```json
{
  "quantity": 3
}
```

**Response** (200 OK):
```json
{
  "message": "Cantidad actualizada"
}
```

**Implementación**:
```dart
Future<void> updateCartItemQuantity(int itemId, int quantity, String token) async {
  final response = await client.put(
    Uri.parse('$baseUrl/cart/items/$itemId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({'quantity': quantity}),
  );

  if (response.statusCode != 200) {
    throw ServerException('Error al actualizar cantidad');
  }
}
```

### 4. Eliminar Item del Carrito

**Endpoint**: `DELETE /cart/items/{item_id}`

**Headers**: Requiere autenticación

**Response** (200 OK):
```json
{
  "message": "Item eliminado del carrito"
}
```

**Implementación**:
```dart
Future<void> removeFromCart(int itemId, String token) async {
  final response = await client.delete(
    Uri.parse('$baseUrl/cart/items/$itemId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw ServerException('Error al eliminar del carrito');
  }
}
```

### 5. Vaciar Carrito

**Endpoint**: `DELETE /cart/clear`

**Headers**: Requiere autenticación

**Response** (200 OK):
```json
{
  "message": "Carrito vaciado exitosamente"
}
```

---

## Endpoints de Usuarios

### 1. Obtener Todos los Usuarios (Admin)

**Endpoint**: `GET /users`

**Headers**: Requiere autenticación (admin)

**Response** (200 OK):
```json
[
  {
    "id": 1,
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "rol": "cliente",
    "isActive": true,
    "createdAt": "2025-01-15T10:30:00Z"
  },
  {
    "id": 2,
    "name": "María García",
    "email": "maria@example.com",
    "rol": "admin",
    "isActive": true,
    "createdAt": "2025-01-10T08:20:00Z"
  }
]
```

**Implementación**:
```dart
Future<List<UserModel>> getUsers(String token) async {
  final response = await client.get(
    Uri.parse('$baseUrl/users'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  } else {
    throw ServerException('Error al obtener usuarios');
  }
}
```

### 2. Crear Usuario (Admin)

**Endpoint**: `POST /users`

**Headers**: Requiere autenticación (admin)

**Request Body**:
```json
{
  "name": "Carlos López",
  "email": "carlos@example.com",
  "password": "password123",
  "rol": "cliente",
  "isActive": true
}
```

**Response** (201 Created):
```json
{
  "id": 3,
  "name": "Carlos López",
  "email": "carlos@example.com",
  "rol": "cliente",
  "isActive": true
}
```

### 3. Actualizar Usuario (Admin)

**Endpoint**: `PUT /users/{id}`

**Headers**: Requiere autenticación (admin)

**Request Body**:
```json
{
  "name": "Carlos López Actualizado",
  "email": "carlos.nuevo@example.com",
  "rol": "admin",
  "isActive": true
}
```

**Response** (200 OK):
```json
{
  "message": "Usuario actualizado exitosamente"
}
```

### 4. Eliminar Usuario (Admin)

**Endpoint**: `DELETE /users/{id}`

**Headers**: Requiere autenticación (admin)

**Response** (200 OK):
```json
{
  "message": "Usuario eliminado exitosamente"
}
```

---

## Manejo de Errores

### Códigos de Estado HTTP

| Código | Descripción | Uso |
|--------|-------------|-----|
| 200 | OK | Operación exitosa |
| 201 | Created | Recurso creado exitosamente |
| 400 | Bad Request | Datos inválidos en la petición |
| 401 | Unauthorized | No autenticado o token inválido |
| 403 | Forbidden | No tiene permisos para esta acción |
| 404 | Not Found | Recurso no encontrado |
| 500 | Internal Server Error | Error del servidor |

### Formato de Errores

```json
{
  "error": "Descripción del error",
  "message": "Mensaje detallado",
  "statusCode": 400
}
```

### Manejo en la Aplicación

```dart
Future<T> handleResponse<T>(http.Response response) async {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);
  } else if (response.statusCode == 401) {
    throw UnauthorizedException('Token inválido o expirado');
  } else if (response.statusCode == 403) {
    throw ForbiddenException('No tiene permisos para esta acción');
  } else if (response.statusCode == 404) {
    throw NotFoundException('Recurso no encontrado');
  } else if (response.statusCode >= 500) {
    throw ServerException('Error en el servidor');
  } else {
    throw ServerException('Error desconocido');
  }
}
```

---

## Ejemplos de Uso

### Ejemplo Completo: Login y Obtener Productos

```dart
// 1. Login
final loginResponse = await authRemoteDataSource.login(
  'usuario@example.com',
  'password123'
);

// 2. Guardar token
final token = loginResponse.accessToken;
await SharedPreferences.getInstance()
    .then((prefs) => prefs.setString('token', token));

// 3. Obtener productos
final products = await productRemoteDataSource.getProducts();

// 4. Mostrar en UI
for (var product in products) {
  print('${product.nombre}: ${product.precio}');
}
```

### Ejemplo: Agregar Producto al Carrito

```dart
try {
  // Obtener token guardado
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  
  if (token == null) {
    throw Exception('No autenticado');
  }
  
  // Agregar al carrito
  await cartRemoteDataSource.addToCart(
    productId: 1,
    quantity: 2,
    token: token,
  );
  
  print('Producto agregado al carrito');
} on ServerException catch (e) {
  print('Error: ${e.message}');
}
```

### Ejemplo: Crear Producto (Admin)

```dart
try {
  // Token de admin
  final token = await getAdminToken();
  
  // Crear producto
  final newProduct = ProductModel(
    nombre: 'Nuevo Producto',
    descripcion: 'Descripción del producto',
    precio: 1000000,
    stock: 50,
    isActive: true,
    imagen: 'http://example.com/image.jpg',
    category: 'Electrónica',
  );
  
  await productRemoteDataSource.createProduct(newProduct, token);
  
  print('Producto creado exitosamente');
} on ServerException catch (e) {
  print('Error: ${e.message}');
}
```

---

## Configuración de Timeouts

```dart
final client = http.Client();

Future<http.Response> makeRequest(String url) async {
  return await client.get(Uri.parse(url)).timeout(
    Duration(seconds: 10),
    onTimeout: () {
      throw TimeoutException('La petición tardó demasiado');
    },
  );
}
```

---

## Interceptores y Logging

### Log de Peticiones

```dart
Future<http.Response> loggedRequest(
  Future<http.Response> Function() request
) async {
  print('📤 Enviando petición...');
  final startTime = DateTime.now();
  
  try {
    final response = await request();
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    
    print('📥 Respuesta recibida en ${duration.inMilliseconds}ms');
    print('   Status: ${response.statusCode}');
    
    return response;
  } catch (e) {
    print('❌ Error en la petición: $e');
    rethrow;
  }
}
```

---

## Buenas Prácticas

1. **Siempre validar el statusCode**
```dart
if (response.statusCode == 200) {
  // Procesar respuesta
} else {
  // Manejar error
}
```

2. **Usar try-catch para capturar excepciones**
```dart
try {
  final data = await api.getData();
} catch (e) {
  print('Error: $e');
}
```

3. **Implementar reintentos para operaciones críticas**
```dart
Future<T> retryRequest<T>(
  Future<T> Function() request,
  {int maxAttempts = 3}
) async {
  for (var i = 0; i < maxAttempts; i++) {
    try {
      return await request();
    } catch (e) {
      if (i == maxAttempts - 1) rethrow;
      await Future.delayed(Duration(seconds: 2));
    }
  }
  throw Exception('Max retries exceeded');
}
```

4. **Cachear datos cuando sea posible**
```dart
class CachedDataSource {
  final Map<String, dynamic> _cache = {};
  
  Future<T> getCached<T>(String key, Future<T> Function() fetch) async {
    if (_cache.containsKey(key)) {
      return _cache[key] as T;
    }
    
    final data = await fetch();
    _cache[key] = data;
    return data;
  }
}
```

---

**Nota**: Los endpoints y estructuras de datos pueden variar según la implementación específica del backend. Asegúrate de consultar la documentación actualizada de tu API.

