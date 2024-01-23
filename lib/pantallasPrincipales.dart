// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:r_eco/pages/paginaPrincipal.dart';
import 'package:r_eco/pages/pcarga.dart';
import 'package:r_eco/pages/paginaSeleccion.dart';

//Hacemos esta clase para aplicar el bottom tab navigator a las pantallas
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Para controllar el bottom tab navigator
  int indicePagina = 0;

  //Lista con las paginas para controllar el bottom tab navigator
  List<Widget> listaPaginas = <Widget>[
    PaginaPrincipal(),
    PaginaSeleccion(),
    pcarga(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Por defecto nos direcciona a la home page indicePagina==0(home)
      body: listaPaginas[indicePagina],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indicePagina,
          onTap: ((value) {
            setState(() {
              indicePagina = value;
            });
          }),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF34B27D),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete), label: "Contenedores"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bolt), label: "Puntos de carga"),
          ]),
    );
  }
}
