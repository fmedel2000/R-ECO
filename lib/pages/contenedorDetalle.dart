import 'package:flutter/material.dart';
import 'package:r_eco/pages/paginaPrincipal.dart';

class ContenedorDetalle extends StatelessWidget {
  final Contenedor contenedor;
  const ContenedorDetalle({Key? key, required this.contenedor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contenedor.nombre),
        backgroundColor: Color(0xFF34B27D),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              contenedor.rutaImagen,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(contenedor.descripcion),
            ),
          ),
        ],
      ),
    );
  }
}
