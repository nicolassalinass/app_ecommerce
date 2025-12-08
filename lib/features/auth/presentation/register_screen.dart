import 'package:app_ecomerce/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // Controladores de los campos de texto
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isPasswordIconVisible = false;
  bool isConfirmPasswordIconVisible = false;
  bool isCheckbox = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightDisplay = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: heightDisplay,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 1, 3, 121),
                const Color.fromARGB(255, 1, 111, 161),
                const Color.fromARGB(255, 69, 232, 253),
              ],
              begin: AlignmentGeometry.bottomLeft,
              end: AlignmentGeometry.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Image.asset(
                  'assets/neptune_white.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                Text(
                  "CREAR CUENTA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo Nombre
                    Text(
                      "Nombre",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Juan Pérez",
                        ),
                        cursorColor: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    // Campo Email
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "ejemplo123@gmail.com",
                        ),
                        cursorColor: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    // Campo Contraseña
                    Text(
                      "Contraseña",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Mínimo 8 caracteres",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isPasswordIconVisible
                                ? Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  )
                                : Text(""),
                          ),
                        ),
                        cursorColor: Colors.blueGrey,
                        obscureText: isPasswordVisible,
                        onChanged: (text) {
                          setState(() {
                            if (text.isEmpty) {
                              isPasswordIconVisible = false;
                            } else {
                              isPasswordIconVisible = true;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    // Campo Confirmar Contraseña
                    Text(
                      "Confirmar Contraseña",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Repite tu contraseña",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible = !isConfirmPasswordVisible;
                              });
                            },
                            icon: isConfirmPasswordIconVisible
                                ? Icon(
                                    isConfirmPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  )
                                : Text(""),
                          ),
                        ),
                        cursorColor: Colors.blueGrey,
                        obscureText: isConfirmPasswordVisible,
                        onChanged: (text) {
                          setState(() {
                            if (text.isEmpty) {
                              isConfirmPasswordIconVisible = false;
                            } else {
                              isConfirmPasswordIconVisible = true;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    
                    // Checkbox términos y condiciones
                    Row(
                      children: [
                        Checkbox(
                          value: isCheckbox,
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          checkColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              isCheckbox = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "Acepto los términos y condiciones",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                
                // Botón Registrarse
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final confirmPassword = confirmPasswordController.text.trim();

                      // Validaciones
                      if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Complete todos los campos!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (!isCheckbox) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Debe aceptar los términos y condiciones",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Las contraseñas no coinciden",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (password.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "La contraseña debe tener al menos 8 caracteres",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      await ref.read(registerUserCase).register(name, email, password);

                      // TODO: Lógica de registro con el provider
                      // Realizar login usando el provider
                      await ref.read(authProvider.notifier).login(email, password);

                      // Verificar el estado de autenticación
                      final authState = ref.read(authProvider);
                      if (authState.isAuthenticated) {
                        // Login exitoso
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "¡Bienvenido!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          final userData = authState.userData;

                          // Navegar según el tipo de usuario
                          if (userData?.rol == 'admin') {
                            context.go('/homeAdmin');
                          } else {
                            context.go('/homeUser');
                          }
                        }
                      }else {
                        // Error en el login
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                authState.error ?? "Error al iniciar sesión",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> state,
                      ) {
                        if (state.contains(WidgetState.pressed)) {
                          return const Color.fromARGB(255, 1, 96, 139);
                        }
                        return const Color.fromARGB(255, 3, 169, 244);
                      }),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Link para ir al login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿Ya tienes una cuenta?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}