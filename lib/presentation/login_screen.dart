import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "INICIAR SESIÓN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text("Email o telefono", style: TextStyle(color: Colors.white)),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  // prefixIconColor: Colors.white      ------- Forma alternativa de relizar el cambio de color del icono
                  label: Text("Correo"),
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "ejemplo123@gmail.com",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // icon: Icon(Icons.phone),
                  prefixIcon: Icon(Icons.lock),
                  label: Text("Contraseña"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
