// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:r_eco/constants/constantes.dart';
import 'package:r_eco/helpers/conversorImagenes.dart';

class MapaContenedores extends StatefulWidget {
  final List<String> elegidos;
  const MapaContenedores({super.key, required this.elegidos});

  @override
  State<MapaContenedores> createState() => _MapaContenedoresState();
}

class _MapaContenedoresState extends State<MapaContenedores> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<LatLng> polylineCoordinates = [];
  List<String> definitivos = [];
  late String titulo;

  var posicionActual;
  var latitudActual = 42.345772;
  var longitudActual = -3.721287;

  //var markers = [];
  late BitmapDescriptor mapMarker;
  late GoogleMapController mapaControlador;
  var posicionCamara = CameraPosition(target: LatLng(0.0, 0.0));

  void getPolyPoints(LatLng dest) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult resultado = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(latitudActual, longitudActual),
        PointLatLng(dest.latitude, dest.longitude),
        travelMode: TravelMode.walking);

    if (resultado.points.isNotEmpty) {
      resultado.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }

    // Calcula y muestra la distancia entre las ubicaciones
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
    final iconAceite = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/aceite.png', width: 30));
    final iconLatas = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/latas.png', width: 30));
    final iconNuevosOrganicos = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/nuevosOrganicos.png', width: 30));
    final iconOrganico = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/organico.png', width: 30));
    final iconPapelYCarton = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/papelycarton.png', width: 30));
    final iconPlastico = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/plastico.png', width: 30));
    final iconVidrio = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/vidrio.png', width: 30));
    final iconRopa = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/ropa.png', width: 30));
    final iconSal = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/sal.png', width: 30));
    final iconPuntoLimpio = BitmapDescriptor.fromBytes(
        await conversorImagenes('assets/puntoLimpio.png', width: 30));

    final posicion =
        LatLng(specify['location'].latitude, specify['location'].longitude);

    switch (specify['categoria']) {
      case "latas":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconLatas,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "papelYcarton":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconPapelYCarton,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "plastico":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconPlastico,
        );
        setState(() {
          markers[markerId] = marker;
        });
        break;
      case "vidrio":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconVidrio,
        );
        setState(() {
          markers[markerId] = marker;
        });
        break;
      case "organico":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconOrganico,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "ropa":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconRopa,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "aceite":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconAceite,
        );
        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "sal":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconSal,
        );

        setState(() {
          markers[markerId] = marker;
        });

        break;
      case "nuevosorganicos":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconNuevosOrganicos,
        );

        setState(() {
          markers[markerId] = marker;
        });

        break;

      case "puntoLimpio":
        final Marker marker = Marker(
          markerId: markerId,
          position: posicion,
          onTap: () {
            borrarPolyline();
            getPolyPoints(posicion);
          },
          icon: iconPuntoLimpio,
        );

        setState(() {
          markers[markerId] = marker;
        });

        break;

      default:
    }
  }

  getMarker() async {
    definitivos.addAll(widget.elegidos);
    FirebaseFirestore.instance
        .collection('contenedores')
        .where("categoria", whereIn: definitivos)
        .get()
        .then((value) => value.docs.forEach((element) {
              inicializarMarker(element.data(), element.reference.id);
            }));
  }

  @override
  void initState() {
    //getUbicacionActual();
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
          markerId: MarkerId('Contenedor'),
          position: LatLng(21.1458, 79.2882),
          icon: BitmapDescriptor.defaultMarker,
        )
      };
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            titulo,
          ),
          backgroundColor: Color(0xFF34B27D),
        ),
        body: GoogleMap(
          polylines: {
            Polyline(
              polylineId: PolylineId("ruta"),
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
