import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContrasenaOlvidadaPage extends StatefulWidget {
  const ContrasenaOlvidadaPage({super.key});

  @override
  State<ContrasenaOlvidadaPage> createState() => _ContrasenaOlvidadaPageState();
}

class _ContrasenaOlvidadaPageState extends State<ContrasenaOlvidadaPage> {
  final emailControlador = TextEditingController();

  //Dispose libera el controlador cuando el widget ContrasenaOlvidadaPage es eliminado
  @override
  void dispose() {
    emailControlador.dispose();
    super.dispose();
  }

  //Métedo para recuperar la contraseña mediante un email
  Future recuperarContrasena() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailControlador.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text('Se ha enviado un enlace a tu email!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      String errorMessage = '';

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Correo electrónico inválido.';
          break;
        case 'user-disabled':
          errorMessage = 'Correo electrónico inválido.';
          break;
        case 'user-not-found':
          errorMessage = 'Revisa tu correo para recuperar tu contraseña!';
          break;
        case 'wrong-password':
          errorMessage = 'Contraseña incorrecta.';
          break;

        default:
          errorMessage = 'Se produjo un error de autenticación.';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar contraseña"),
        backgroundColor: const Color(0xFF34B27D),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Introduce tu email y te enviaremos un link para actualizar la contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 10),

          //email textield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: const Color(0xFF2980B9)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: emailControlador,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                )),
          ),

          //Botón para resetear contraseña
          MaterialButton(
            onPressed: recuperarContrasena,
            child: Text(
              'Recuperar Contraseña',
              style: TextStyle(
                color: Colors.white, // Cambia el color del texto a blanco
              ),
            ),
            color: const Color(0xFF34B27D),
          ),
        ],
      ),
    );
  }
}
