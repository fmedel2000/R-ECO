// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registro extends StatefulWidget {
  final VoidCallback mostrarLogin;
  const Registro({super.key, required this.mostrarLogin});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  //text controllers
  final emailControlador = TextEditingController();
  final contrasenaControlador = TextEditingController();
  final confirmarContrasenaControlador = TextEditingController();
  final nombreControlador = TextEditingController();
  final apellidosControlador = TextEditingController();
  final edadControlador = TextEditingController();

  @override
  void dispose() {
    emailControlador.dispose();
    contrasenaControlador.dispose();
    confirmarContrasenaControlador.dispose();
    nombreControlador.dispose();
    apellidosControlador.dispose();
    edadControlador.dispose();
    super.dispose();
  }

  Future registrarse() async {
    //autenticando usuario
    if (contrasenaConfirmada()) {
      //Crear al usuario
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailControlador.text.trim(),
          password: contrasenaControlador.text.trim(),
        );

        // añadir los datos del usuario
        anadirUsuario(
          nombreControlador.text.trim(),
          apellidosControlador.text.trim(),
          emailControlador.text.trim(),
          int.parse(edadControlador.text.trim()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'weak-password') {
          errorMessage = 'La contraseña es demasiado débil.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Error al crear el usuario';
        } else {
          errorMessage = 'Error al crear el usuario';
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error de autenticación'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra el diálogo
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error al crear el usuario'),
            content: Text('Ocurrió un error al crear el usuario.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra el diálogo
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future anadirUsuario(
      String firstName, String lastname, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastname,
      'email': email,
      'age': age,
    });
  }

  bool contrasenaConfirmada() {
    if (contrasenaControlador.text.trim() ==
        confirmarContrasenaControlador.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 247, 247),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 50,
              ),

              Text(
                'Hola!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 56,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Registrate debajo añadiendo tus datos',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),

              //Firstname textield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: nombreControlador,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Nombre',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //lastname textield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: apellidosControlador,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Apellidos',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //age textield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: edadControlador,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Edad',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //email textield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: emailControlador,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //password textfield
              //email textield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: contrasenaControlador,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Contraseña',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //confirmpassword textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: confirmarContrasenaControlador,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2980B9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Confirmar contraseña',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              //Sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: registrarse,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xFF34B27D),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Ya eres miembro? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.mostrarLogin,
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
