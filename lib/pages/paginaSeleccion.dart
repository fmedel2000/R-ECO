import 'package:flutter/material.dart';
import 'mapaContenedores.dart';

class PaginaSeleccion extends StatefulWidget {
  @override
  _PaginaSeleccionState createState() => _PaginaSeleccionState();
}

class _PaginaSeleccionState extends State<PaginaSeleccion> {
  List<String> elegidos = [];

  List<Opcion> opciones = [
    Opcion('Aceite', 'assets/aceite.png', 'aceite'),
    Opcion('Latas', 'assets/latas.png', 'latas'),
    Opcion('Restos Orgánicos', 'assets/nuevosOrganicos.png', 'nuevosorganicos'),
    Opcion('Restos', 'assets/organico.png', 'organico'),
    Opcion('Papel y cartón', 'assets/papelycarton.png', 'papelYcarton'),
    Opcion('Plástico', 'assets/plastico.png', 'plastico'),
    Opcion('Ropa', 'assets/ropa.png', 'ropa'),
    Opcion('Vidrio', 'assets/vidrio.png', 'vidrio'),
    Opcion('Puntos Limpios', 'assets/puntoLimpio.png', 'puntoLimpio'),
    Opcion('Sal', 'assets/sal.png', 'sal'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione los contenedores a mostrar'),
        backgroundColor: Color(0xFF34B27D),
      ),
      body: ListView.builder(
        itemCount: opciones.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Row(
              children: [
                Image.asset(
                  opciones[index].rutaImagen,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Text(opciones[index].titulo),
              ],
            ),
            value: elegidos.contains(opciones[index].valor),
            onChanged: (bool? value) {
              if (value!) {
                setState(() {
                  elegidos.add(opciones[index].valor);
                });
              } else {
                setState(() {
                  elegidos.remove(opciones[index].valor);
                });
              }
            },
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapaContenedores(elegidos: elegidos),
              ),
            );
          },
          mini: true,
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class Opcion {
  final String titulo;
  final String rutaImagen;
  final String valor;

  Opcion(this.titulo, this.rutaImagen, this.valor);
}
