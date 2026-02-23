import 'package:app_ecomerce/features/users/presentation/provider/user_notifier_provider.dart';
import 'package:app_ecomerce/features/users/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserScreen extends ConsumerStatefulWidget {
  final User user;
  const UpdateUserScreen({super.key, required this.user});

  @override
  ConsumerState<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends ConsumerState<UpdateUserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
  late bool isActive;
  bool _obscureText = true;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _emailController.text = widget.user.email;
    _selectedRole = widget.user.rol;
    isActive = widget.user.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              // SizedBox(
              //   width: double.infinity,
              //   child: Text(
              //     "Agregar Nuevo Usuario",
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              RichText(
                text: TextSpan(
                  text: "Nombre",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  children: const [
                    TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Ej: Juan Perez",
                    errorText: _showErrors && _nameController.text.isEmpty ? 'Este campo es obligatorio' : null,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _nameController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _nameController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  children: const [
                    TextSpan(
                      text: " *",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Ej: example@example.com",
                    errorText: _showErrors && _emailController.text.isEmpty ? 'Este campo es obligatorio' : null,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _emailController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _emailController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
              Text(
                "Contraseña",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: "********",
                  errorText: _showErrors && _passwordController.text.isEmpty ? 'Este campo es obligatorio' : null,  
                  suffixIcon: IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }, 
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _emailController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _showErrors && _emailController.text.isEmpty ? Colors.red : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Tipo de Usuario",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            children: const [
                              TextSpan(
                                text: " *",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        DropdownButtonFormField(
                          initialValue: _selectedRole,
                          hint: Text('Selecciona un rol'),
                          decoration: InputDecoration(
                            errorText: _showErrors && _selectedRole == null ? 'Selecciona un rol' : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _showErrors && _selectedRole == null ? Colors.red : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _showErrors && _selectedRole == null ? Colors.red : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "admin",
                              child: Text('Admin'),
                            ),
                            DropdownMenuItem(
                              value: "customer",
                              child: Text('Cliente'),
                            ),
                          ], 
                          onChanged: (value) {
                            setState(() {
                              _selectedRole  = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      spacing: 16,
                      children: [
                        Text(
                          "Estado",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                        Row(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isActive ? Text("Activo") : Text('Inactivo'),
                            Switch(
                              value: isActive,
                              onChanged: (value) {
                                setState(() {
                                  isActive = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              //Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async{
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final rol = _selectedRole.toString();
                    final estado = isActive;
          
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('access_token') ?? '';
          
                    if (name.isEmpty || email.isEmpty || password.isEmpty || _selectedRole == null) {
                      setState(() {
                        _showErrors = true;
                      });
                      _show_dialog_error(context, "Por favor completa todos los campos obligatorios.");
                      return;
                    }

                    try {
                      final userUpdate = ref.read(updateUserCaseProvider);
            
                      final editUser = User(
                        name: name, 
                        email: email, 
                        password: password,
                        rol: rol, 
                        isActive: estado
                      );
                      await userUpdate.updateUser(widget.user.id!, editUser, token);
                      
                      // Limpiar los campos después de crear el usuario
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() {
                        _selectedRole = null;
                        isActive = true;
                        _showErrors = false;
                      });
                      
                      if (context.mounted) {
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

                      ref.read(userNotifierProvider.notifier).refresh();
                    } catch (e) {
                      _show_dialog_error(context, e.toString());
                    }
                    
                    
          
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(  
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary)
                  ),
                  child: Text(
                    "Editar Usuario",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  Future<dynamic> _show_dialog_error(BuildContext context, String content) {
    return showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        content: Text(content),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            }, 
                            child: Text("OK")
                          )
                        ],
                      ),
                    );
  }
}