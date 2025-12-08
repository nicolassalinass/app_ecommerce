// Ejemplo de uso de auth_me en tu UI

// En tu página de perfil o donde necesites mostrar los datos del usuario:

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_ecomerce/features/auth/presentation/provider/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Si no hay datos del usuario, mostrar loading o llamar a getMe()
    if (authState.userData == null && authState.isAuthenticated) {
      // Llamar a getMe() para obtener los datos
      Future.microtask(() => ref.read(authProvider.notifier).getMe());

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Si hay un error
    if (authState.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${authState.error}'),
              ElevatedButton(
                onPressed: () => ref.read(authProvider.notifier).getMe(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    // Mostrar datos del usuario
    final userData = authState.userData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              // Navegar a la pantalla de login
            },
          ),
        ],
      ),
      body: userData != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('ID'),
                    subtitle: Text('${userData.id}'),
                  ),
                  ListTile(
                    title: const Text('Nombre'),
                    subtitle: Text(userData.name),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(userData.email),
                  ),
                  ListTile(
                    title: const Text('Rol'),
                    subtitle: Text(userData.rol),
                  ),
                  ListTile(
                    title: const Text('Estado'),
                    subtitle: Text(userData.isActive ? 'Activo' : 'Inactivo'),
                    trailing: userData.isActive
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.cancel, color: Colors.red),
                  ),
                  if (userData.createdAt != null)
                    ListTile(
                      title: const Text('Fecha de creación'),
                      subtitle: Text(userData.createdAt.toString()),
                    ),
                ],
              ),
            )
          : const Center(
              child: Text('No hay datos del usuario'),
            ),
    );
  }
}

// También puedes acceder a los datos del usuario en cualquier parte de tu app:
// final userData = ref.watch(authProvider.select((state) => state.userData));

