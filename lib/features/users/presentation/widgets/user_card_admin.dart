import 'package:app_ecomerce/features/users/domain/entities/user.dart';
import 'package:app_ecomerce/features/users/presentation/provider/user_notifier_provider.dart';
import 'package:app_ecomerce/features/users/presentation/provider/user_provider.dart';
import 'package:app_ecomerce/features/users/presentation/screens/update_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserCardAdmin extends ConsumerWidget {
  final User user;

  const UserCardAdmin({super.key, required this.user});

  Color _getRolColor(String rol) {
    switch (rol.toLowerCase()) {
      case 'admin':
        return Colors.purple;
      case 'usuario':
        return Colors.blue;
      case 'vendedor':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getRolIcon(String rol) {
    switch (rol.toLowerCase()) {
      case 'admin':
        return Icons.admin_panel_settings;
      case 'usuario':
        return Icons.person;
      case 'vendedor':
        return Icons.store;
      default:
        return Icons.badge;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(date.toLocal());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 1,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: user.isActive
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                user.isActive ? 'Activo' : 'Inactivo',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: user.isActive
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user.email,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getRolColor(user.rol).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getRolColor(user.rol), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getRolIcon(user.rol),
                    size: 14,
                    color: _getRolColor(user.rol),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    user.rol == 'customer' ? 'usuario' : user.rol,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getRolColor(user.rol),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'details':
                _showUserDetailsDialog(context, ref);
                break;
              case 'edit':
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserScreen(user: user),));
                break;
              case 'delete':
                _showDeleteConfirmation(context, ref);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'details',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20),
                  SizedBox(width: 12),
                  Text('Ver detalles'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 20),
                  SizedBox(width: 12),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Eliminar', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalles del Usuario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Nombre', user.name),
              _buildDetailRow('Email', user.email),
              _buildDetailRow('Rol', user.rol),
              _buildDetailRow('Estado', user.isActive ? 'Activo' : 'Inactivo'),
              //if (user.createdAt != null)
                _buildDetailRow('Fecha de Creacion', _formatDate(user.createdAt)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }


  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que deseas eliminar a ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('access_token') ?? '';
                final deleteUserN = ref.read(deleteUserCaseProvider);
                await deleteUserN.deleteUser(user.id!, token);
                if (context.mounted) {
                  Navigator.pop(context);
                  showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 64,
                            ),
                            title: const Text('¡Éxito!'),
                            content: const Text('Usuario actualizado exitosamente'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                }
                await ref.read(userNotifierProvider.notifier).refresh();

              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
