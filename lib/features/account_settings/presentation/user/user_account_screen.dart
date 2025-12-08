import 'package:app_ecomerce/features/account_settings/presentation/user/widget/option_user_list.dart';
import 'package:app_ecomerce/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserAccountScreen extends ConsumerStatefulWidget {
  const UserAccountScreen({super.key});

  @override
  ConsumerState<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends ConsumerState<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final userData = authState.userData;
    final isLoading = authState.isLoading;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 20,
              children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  radius: 90,
                  child: Icon(Icons.person, size: 100, color: Colors.grey.shade400,),
                ),
                SizedBox(height: 10,),
                Text("${userData?.name}", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                Text("${userData?.email}", style: TextStyle(
                    fontSize: 20,
                ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: Text("Mi Cuenta", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )),
                ),
                OptionUserList(
                  icon: CupertinoIcons.cube_box,
                  title: "Mis pedidos",
                  pathRoute: '/history',
                ),
                OptionUserList(
                  icon: Icons.settings,
                  title: "Configuracion de cuenta",
                  pathRoute: '/pedidosUsuario',
                ),
                OptionUserList(
                  icon: Icons.payment_outlined,
                  title: "Metodos de pago",
                  pathRoute: '/pedidosUsuario',
                )
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                    foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Cerrar sesion", style: TextStyle(fontSize: 20),),
                        Icon(Icons.logout, size: 25,)
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
          // Indicador de carga superpuesto
          if (isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Cerrando sesión...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
