# Implementación de Auth Me - Resumen

## ✅ Cambios realizados

### 1. Caso de uso (Use Case)
**Archivo creado:** `lib/features/auth/domain/usecases/get_auth_me.dart`
- Caso de uso para obtener los datos del usuario autenticado
- Recibe el token como parámetro y lo pasa al repositorio

### 2. Data Source
**Archivo modificado:** `lib/features/auth/data/datasources/auth_remote_data_source.dart`
- ✅ Actualizado el método `authMe()` para recibir el token
- ✅ El token se envía en el header `Authorization: Bearer {token}`
- ✅ Envía el header `Content-Type: application/json`

### 3. Repository
**Archivos modificados:**
- `lib/features/auth/domain/repositories/auth_repository.dart` (interfaz)
- `lib/features/auth/data/repositories/login_repository_impl.dart` (implementación)
- ✅ Actualizado para recibir y pasar el token

### 4. Provider
**Archivo modificado:** `lib/features/auth/presentation/provider/auth_provider.dart`
- ✅ Agregado `AuthMe? userData` al estado
- ✅ Método `getMe()` para obtener datos del usuario autenticado
- ✅ Se llama automáticamente después del login
- ✅ Actualizado el `logout()` para limpiar `userData`
- ✅ Agregado `getAuthMeProvider` para el caso de uso

### 5. Ejemplo de uso
**Archivo creado:** `lib/features/auth/presentation/pages/profile_example.dart`
- Ejemplo completo de cómo usar `auth_me` en tu UI
- Muestra cómo acceder a los datos del usuario
- Manejo de estados: loading, error y éxito

## 📝 Cómo usar

### En el login (ya implementado automáticamente):
```dart
// Después del login exitoso, se obtienen automáticamente los datos del usuario
await ref.read(authProvider.notifier).login(username, password);
```

### Para obtener datos del usuario manualmente:
```dart
// Si necesitas refrescar los datos del usuario
await ref.read(authProvider.notifier).getMe();
```

### Para acceder a los datos del usuario en tu UI:
```dart
// En cualquier widget con ConsumerWidget o Consumer
final userData = ref.watch(authProvider.select((state) => state.userData));

if (userData != null) {
  Text(userData.name);
  Text(userData.email);
  Text(userData.rol);
  Text(userData.isActive ? 'Activo' : 'Inactivo');
}
```

### Para hacer logout:
```dart
await ref.read(authProvider.notifier).logout();
```

## 🔑 Datos disponibles en AuthMe:
- `id`: ID del usuario
- `name`: Nombre del usuario
- `email`: Email del usuario
- `rol`: Rol del usuario
- `isActive`: Estado activo/inactivo
- `createdAt`: Fecha de creación (opcional)

## 🔐 Seguridad
- El token se guarda en SharedPreferences
- El token se envía en el header Authorization con Bearer
- El token se elimina al hacer logout

## 📌 Notas importantes:
1. El método `getMe()` se llama automáticamente después del login exitoso
2. Los datos del usuario se almacenan en `state.userData`
3. Si hay un error al obtener los datos, se guarda en `state.error`
4. Puedes llamar a `getMe()` en cualquier momento para refrescar los datos

