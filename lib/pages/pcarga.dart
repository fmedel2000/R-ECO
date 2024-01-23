import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:r_eco/constants/constantes.dart';
import 'package:r_eco/helpers/conversorImagenes.dart';

class pcarga extends StatefulWidget {
  const pcarga({super.key});

  @override
  State<pcarga> createState() => _pcargaState();
}

class _pcargaState extends State<pcarga> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<LatLng> polylineCoordinates = [];
  List<String> definitivos = ["rapida", "media", "lenta", "inhabilitado"];
  late String titulo;
  var posicionActual;
  var latitudActual = 42.345772;
  var longitudActual = -3.721287;

  //var markers = [];
  late BitmapDescriptor mapMarker;
  late GoogleMapController mapaControlador;
  var cameraPosition = CameraPosition(target: LatLng(0.0, 0.0));

  void getPolyPoints(LatLng dest) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult resultado = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(latitudActual, longitudActual),
        PointLatLng(dest.latitude, dest.longitude));

    if (resultado.points.isNotEmpty) {
      resultado.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
    double distanciaEnMetros = Geolocator.distanceBetween(
      latitudActual,
      longitudActual,
      dest.latitude,
      dest.longitude,
    );
    double distanciaEnKiloMetros = distanciaEnMetros / 1000;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Distancia: ${distanciaEnKiloMetros.toStringAsFixed(2)} km'),
      ),
    );
  }

  void borrarPolyline() {
    setState(() {
      polylineCoordinates.clear();
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapaControlador = controller;
    animarCamara();
  }

  void animarCamara() {
    mapaControlador.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudActual, longitudActual),
        zoom: 18.0,
        tilt: 50.0)));
  }

  getUbicacionActual() async {
    await Geolocator.getCurrentPosition().then((Position pos) async {
      setState(() {
        posicionActual = pos;
        latitudActual = pos.latitude;
        longitudActual = pos.longitude;
      });
    });
  }

  void inicializarMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final iconRapida = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/rapida.png', width: 30));
    final iconMedia = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/media.png', width: 30));
    final iconLenta = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/lenta.png', width: 30));
    final iconInhabilitado = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/inhabilitado.png', width: 30));

    final posicion =
        LatLng(specify['location'].latitude, specify['location'].longitude);

    switch (specify['categoria']) {
      case "rapida":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconRapida,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "media":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconMedia,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "lenta":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconLenta,
        );
        setState(() {
          markers[markerId] = marker;
        });
        break;
      case "inhabilitado":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconInhabilitado,
        );
        setState(() {
          markers[markerId] = marker;
        });
        break;

      default:
    }
  }

  getMarker() async {
    FirebaseFirestore.instance
        .collection('pCarga')
        .where("categoria", whereIn: definitivos)
        .get()
        .then((value) => value.docs.forEach((element) {
              inicializarMarker(element.data(), element.reference.id);
            }));
  }

  @override
  void initState() {
    super.initState();
    getMarker();
    titulo = definitivos.join(', ');
    getUbicacionActual();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>{
        Marker(
          markerId: MarkerId('Tienda'),
          position: LatLng(21.1458, 79.2882),
          icon: BitmapDescriptor.defaultMarker,
        )
      };
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Puntos de carga'),
          backgroundColor: Color(0xFF34B27D),
        ),
        body: GoogleMap(
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: Color.fromARGB(255, 201, 41, 151),
              width: 6,
            )
          },
          markers: Set<Marker>.of(markers.values),
          initialCameraPosition: CameraPosition(
            target: LatLng(latitudActual, longitudActual),
            zoom: 14.5,
          ),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: onMapCreated,
        ));
  }
}
