import 'package:app_ecomerce/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminAccountScreen extends ConsumerWidget {
  const AdminAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).logout();
                    context.go('/login');
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    elevation: WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                  ),
                  child: Text(
                    "Cerrar sesion",
                    style: TextStyle(
                        //fontStyle: FontStyle.italic,
                        color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
              ),
            )
        ),
      ),
    );
  }
}
