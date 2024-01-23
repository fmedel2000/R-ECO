import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'configuracionFirebase.dart';
import 'auth/estaLogeado.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Inicio());
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EstaLogeado(),
    );
  }
}
