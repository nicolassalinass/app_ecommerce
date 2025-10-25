import 'package:app_ecomerce/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Creamos los controladores de los campos de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isIconVisible = false;
  bool isCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/neptune_white.png',
                  fit: BoxFit.cover,
                  width: 250,
                  height: 250,
                ),
                Text(
                  "INICIAR SESIÓN",
                  style: TextStyle(
                    fontFamily: "",
                    //fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 60),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email o telefono",
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
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          // prefixIconColor: Colors.white      ------- Forma alternativa de relizar el cambio de color del icono
                          // label: Text("Correo"),
                          // labelStyle: TextStyle(color: Colors.white),
                          hintText: "ejemplo123@gmail.com",
                          // hintStyle: TextStyle(color: Colors.white),
                        ),
                        cursorColor: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 20),
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
                          // icon: Icon(Icons.phone),
                          prefixIcon: Icon(Icons.lock),
                          // label: Text("Contraseña"),
                          hintText: "12345678.ejemplo",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: isIconVisible
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
                              isIconVisible = false;
                            } else {
                              isIconVisible = true;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            Text(
                              "Recordar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text(
                            "¿Olvidaste tu contraseña?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // ******************************** Boton Inicio de Sesión ***************************************
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
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
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
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
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes una cuenta?",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "Registrarse",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
