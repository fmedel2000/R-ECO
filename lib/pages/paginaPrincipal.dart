import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_eco/pages/contenedorDetalle.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  final user = FirebaseAuth.instance.currentUser!;
  final List<Contenedor> contenedores = [
    Contenedor(
      nombre: 'Aceite',
      rutaImagen: 'assets/aceite.png',
      descripcion:
          'Reciclar los contenedores de aceite es importante para reducir el impacto ambiental. Aquí tienes algunos pasos para reciclarlos adecuadamente:\n\n1- Espera a que el aceite usado se enfríe por completo antes de manipularlo.\n\n2- Transfiere el aceite usado a un contenedor adecuado, como una botella de plástico resistente o una lata metálica vacía y limpia.\n\n3- Asegúrate de que el contenedor esté bien cerrado para evitar derrames durante el transporte.\n\n4- Busca un centro de reciclaje o un punto de recogida de aceite usado en tu localidad.\n\n5- Lleva el contenedor de aceite usado al centro de reciclaje o punto de recogida designado.\n\nNunca viertas el aceite usado por el desagüe o en la basura, ya que puede causar daños al medio ambiente.',
    ),
    Contenedor(
      nombre: 'Latas',
      rutaImagen: 'assets/latas.png',
      descripcion:
          'Reciclar latas es una excelente manera de reducir la cantidad de residuos y ahorrar recursos. \n\nAsegúrate de enjuagar las latas vacías y eliminar cualquier residuo antes de reciclarlas. \n\nLuego, deposítalas en un contenedor de reciclaje designado en tu área o llévalas a un centro de reciclaje cercano.',
    ),
    Contenedor(
      nombre: 'Restos orgánicos',
      rutaImagen: 'assets/nuevosOrganicos.png',
      descripcion:
          'El compostaje de restos orgánicos es una forma efectiva de reducir la cantidad de desechos que van a los vertederos. \n\nPuedes compostar restos de frutas, verduras, cáscaras de huevo, posos de café y otros materiales orgánicos. \n\nCrea un área de compost en tu jardín o busca los nuevos contenedores de basura orgánica comunitarios en tu localidad.',
    ),
    Contenedor(
      nombre: 'Restos',
      rutaImagen: 'assets/organico.png',
      descripcion:
          'Algunos restos, como ramas, hojas y recortes de césped, se pueden reciclar a través de la compostaje o el mulching. Estas prácticas ayudan a devolver nutrientes al suelo y reducir la cantidad de residuos. \n\nInvestiga sobre los métodos adecuados de compostaje o mulching en tu área.',
    ),
    Contenedor(
      nombre: 'Papel y Cartón',
      rutaImagen: 'assets/papelycarton.png',
      descripcion:
          'Reciclar papel y cartón es fundamental para conservar los recursos forestales y reducir la deforestación. \n\nAsegúrate de separar el papel y cartón limpios de otros residuos. \n\nDeposita los materiales en contenedores de reciclaje específicos o llévalos a un centro de reciclaje cercano.',
    ),
    Contenedor(
      nombre: 'Plástico',
      rutaImagen: 'assets/plastico.png',
      descripcion:
          'Reciclar plástico es esencial para reducir la contaminación y la acumulación de residuos en el medio ambiente. \n\nBusca los símbolos de reciclaje en los envases de plástico para identificar qué tipo de plástico es y si es reciclable. \n\nLuego, deposítalos en contenedores de reciclaje designados o llévalos a un centro de reciclaje cercano.',
    ),
    Contenedor(
      nombre: 'Puntos Limpios',
      rutaImagen: 'assets/puntoLimpio.png',
      descripcion:
          'Los puntos limpios son lugares especialmente habilitados para el depósito y reciclaje de residuos especiales, como pilas, baterías, aparatos electrónicos, medicamentos vencidos y otros productos que requieren un manejo adecuado. \n\nConsulta en tu localidad la ubicación y los tipos de residuos aceptados en los puntos limpios.',
    ),
    Contenedor(
      nombre: 'Ropa',
      rutaImagen: 'assets/ropa.png',
      descripcion:
          'Reciclar ropa es una excelente manera de reducir el impacto ambiental de la industria de la moda y prolongar la vida útil de las prendas. \n\nPuedes donar ropa en buen estado a organizaciones benéficas o tiendas de segunda mano. \n\nSi la ropa está desgastada o dañada, busca contenedores de reciclaje de textiles en tu área.',
    ),
    Contenedor(
      nombre: 'Sal',
      rutaImagen: 'assets/sal.png',
      descripcion:
          'Los saleros, también conocidos como contenedores de sal, son recipientes diseñados para almacenar y distribuir sal para uso en la remoción de nieve y el control de hielo en carreteras, calles y otras superficies pavimentadas.\n\n Son elementos esenciales durante las nevadas y en climas fríos para mantener las vías transitables y reducir el riesgo de accidentes causados por el hielo. \n\nConsulta en el mapa para obtener más información sobre la ubicación de saleros en tu área.',
    ),
    Contenedor(
      nombre: 'Vidrio',
      rutaImagen: 'assets/vidrio.png',
      descripcion:
          'Reciclar vidrio es fundamental para reducir la cantidad de residuos y conservar los recursos naturales. \n\nAsegúrate de enjuagar los envases de vidrio vacíos y eliminar cualquier tapa o etiqueta antes de reciclarlos. \n\nDeposita los envases en contenedores de reciclaje de vidrio designados o llévalos a un centro de reciclaje cercano.',
    ),
    Contenedor(
      nombre: 'Puestos de carga rápida',
      rutaImagen: 'assets/rapida.png',
      descripcion:
          'Los puestos de carga rápida son estaciones de carga para vehículos eléctricos que permiten una carga más rápida(30-350kW) y eficiente.\n\n Utilizar los puestos de carga rápida es una forma conveniente y sostenible de cargar tu vehículo eléctrico mientras estás en movimiento. \n\nBusca los puntos de carga rápida disponibles en tu área o en las rutas que sueles recorrer.',
    ),
    Contenedor(
      nombre: 'Puestos de carga media',
      rutaImagen: 'assets/media.png',
      descripcion:
          'Los puestos de carga media son estaciones de carga para vehículos eléctricos que proporcionan una carga moderada(16-30kW). \n\nEstas estaciones son ideales para cargar tu vehículo eléctrico durante períodos de estacionamiento prolongado, como en el trabajo o en centros comerciales. \n\nBusca los puntos de carga media disponibles en tu área o en los lugares que frecuentas.',
    ),
    Contenedor(
      nombre: 'Puestos de carga lenta',
      rutaImagen: 'assets/lenta.png',
      descripcion:
          'Los puestos de carga lenta son estaciones de carga para vehículos eléctricos que ofrecen una carga más lenta pero constante(5-16kW). \n\nEstas estaciones son ideales para cargar tu vehículo eléctrico durante períodos de estacionamiento prolongado, como en casa durante la noche. \n\nBusca los puntos de carga lenta disponibles en tu área o considera instalar uno en tu hogar.',
    ),
    Contenedor(
      nombre: 'Puestos inhabilitados',
      rutaImagen: 'assets/inhabilitado.png',
      descripcion:
          'Los puestos de carga inhabilitados son aquellos que actualmente no están en funcionamiento o no están disponibles para su uso. \n\nSi encuentras un puesto de carga inhabilitado, busca alternativas cercanas para cargar tu vehículo eléctrico, como otros puntos de carga o estaciones de servicio con carga eléctrica.',
    ),
    // Agrega el resto de los contenedores aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hola " + user.email!),
        backgroundColor: Color(0xFF34B27D),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contenedores.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                contenedores[index].nombre,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(contenedores[index].rutaImagen),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContenedorDetalle(
                      contenedor: contenedores[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Contenedor {
  final String nombre;
  final String rutaImagen;
  final String descripcion;

  Contenedor({
    required this.nombre,
    required this.rutaImagen,
    required this.descripcion,
  });
}
