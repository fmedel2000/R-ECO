import 'package:flutter/material.dart';
import 'package:r_eco/pages/InicioSesion.dart';
import 'package:r_eco/pages/registro.dart';

class Autenticador extends StatefulWidget {
  const Autenticador({super.key});

  @override
  State<Autenticador> createState() => _AutenticadorState();
}

class _AutenticadorState extends State<Autenticador> {
  bool mostrarLogin = true;

  void cambiarAutenticacion() {
    setState(() {
      mostrarLogin = !mostrarLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mostrarLogin) {
      return InicioSesion(MuestraPaginaRegistro: cambiarAutenticacion);
    } else {
      return Registro(mostrarLogin: cambiarAutenticacion);
    }
  }
}
