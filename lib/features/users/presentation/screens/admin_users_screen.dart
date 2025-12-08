import 'package:app_ecomerce/features/users/presentation/provider/user_notifier_provider.dart';
import 'package:app_ecomerce/features/users/presentation/screens/add_user_screen.dart';
import 'package:app_ecomerce/features/users/presentation/widgets/user_card_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminUsersScreen extends ConsumerStatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  bool isSearch = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedRolFilter = 'Todos';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersAsyncValue = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: !isSearch
            ? const Text("Gestión de Usuarios")
            : SearchBar(
                controller: _searchController,
                elevation: const WidgetStatePropertyAll(0),
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = false;
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
                hintText: 'Buscar usuarios...',
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                  });
                },
              ),
        scrolledUnderElevation: 0,
        actions: [
          if (!isSearch)
            IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                });
              },
              icon: const Icon(Icons.search),
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filtrar por rol',
            onSelected: (value) {
              setState(() {
                _selectedRolFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Todos', child: Text('Todos')),
              const PopupMenuItem(value: 'Admin', child: Text('Admin')),
              const PopupMenuItem(value: 'Customer', child: Text('Usuario')),
              const PopupMenuItem(value: 'Vendedor', child: Text('Vendedor')),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(userNotifierProvider.notifier).refresh();
            },
            tooltip: 'Actualizar lista',
          ),
        ],
      ),
      body: usersAsyncValue.when(
        data: (users) {
          var filteredUsers = users;

          if (_searchQuery.isNotEmpty) {
            filteredUsers = filteredUsers.where((user) {
              return user.name.toLowerCase().contains(_searchQuery) ||
                  user.email.toLowerCase().contains(_searchQuery);
            }).toList();
          }

          if (_selectedRolFilter != 'Todos') {
            filteredUsers = filteredUsers.where((user) {
              return user.rol.toLowerCase() == _selectedRolFilter.toLowerCase();
            }).toList();
          }

          if (users.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 100, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay usuarios',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Agrega tu primer usuario',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(userNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total de Usuarios',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${users.length}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Activos: ${users.where((u) => u.isActive).length}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Inactivos: ${users.where((u) => !u.isActive).length}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRoleBadge(
                              context,
                              'Admin',
                              users
                                  .where((u) => u.rol.toLowerCase() == 'admin')
                                  .length,
                              Colors.purple,
                            ),
                            _buildRoleBadge(
                              context,
                              'Usuario',
                              users
                                  .where(
                                    (u) => u.rol.toLowerCase() == 'customer',
                                  )
                                  .length,
                              Colors.blue,
                            ),
                            // _buildRoleBadge(
                            //   context,
                            //   'Vendedor',
                            //   users
                            //       .where(
                            //         (u) => u.rol.toLowerCase() == 'vendedor',
                            //       )
                            //       .length,
                            //   Colors.orange,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_selectedRolFilter != 'Todos')
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Chip(
                        label: Text('Filtrando: $_selectedRolFilter'),
                        onDeleted: () {
                          setState(() {
                            _selectedRolFilter = 'Todos';
                          });
                        },
                      ),
                    ),
                  ),
                if (filteredUsers.isEmpty &&
                    (_searchQuery.isNotEmpty || _selectedRolFilter != 'Todos'))
                  const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No se encontraron usuarios',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Intenta con otro término o filtro',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (filteredUsers.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = filteredUsers[index];
                        return UserCardAdmin(user: user);
                      },
                      childCount: filteredUsers.length,
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Cargando usuarios...'),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Error al cargar usuarios',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(userNotifierProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
        icon: Icon(
          Icons.person_add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          'Nuevo Usuario',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget _buildRoleBadge(
    BuildContext context,
    String rol,
    int count,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(rol.toLowerCase() == 'customer' ? 'Usuario' : rol, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
      ],
    );
  }
}
