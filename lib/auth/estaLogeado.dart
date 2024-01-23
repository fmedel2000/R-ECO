import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_eco/auth/autenticador.dart';
import 'package:r_eco/pantallasPrincipales.dart';

class EstaLogeado extends StatelessWidget {
  const EstaLogeado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //authStateChanged se activará al llamar a la función
        //signInWithEmailAndPassword de loginpage, eso devolverá un snapshot
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Si tenemos a un user en el snapshot accedemos al main si no, volvemos a loginPage
          if (snapshot.hasData) {
            return MainScreen();
          } else {
            return Autenticador();
          }
        },
      ),
    );
  }
}
