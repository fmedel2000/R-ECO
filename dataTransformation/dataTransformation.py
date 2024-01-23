# Usar el comando: pip install --upgrade firebase-admin
import json

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from google.cloud.firestore import GeoPoint

cred= credentials.Certificate("DATABASE_CREDENTIALS.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

archivo = 'data.json'

def cargar_archivo(archivo):
  with open(archivo) as datos:
    data=json.load(datos)
  return data

def insertar_datos(data):
  for element in data["features"]:
    if (("recycling:clothes" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000002
      LatLng[1] += 0.000002
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "ropa")
    if (("recycling:plastic_packaging" in element["properties"] or "recycling:plastic" in element[
      "properties"] or "recycling:plastic_bottles" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000004
      LatLng[1] += 0.000004
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "plastico")
    if (("recycling:cooking_oil" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000006
      LatLng[1] += 0.000006
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "aceite")
    if (("recycling:shoes" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000006
      LatLng[1] += 0.000006
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "zapatos")
    if (("recycling:glass_bottles" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000008
      LatLng[1] += 0.000008
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "vidrio")
    if (("recycling:magazines" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.00001
      LatLng[1] += 0.00001
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "revistas")
    if (("recycling:newspaper" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000012
      LatLng[1] += 0.000012
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "periodico")
    if (("recycling:cartons" in element["properties"]) or ("recycling:paper" in element["properties"]) or (
            "recycling:beverage_cartons" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000014
      LatLng[1] += 0.000014
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "papelYcarton")
    if (("recycling:cans" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000016
      LatLng[1] += 0.000016
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "latas")

    #Organico
    LatLng = element["geometry"]["coordinates"]
    LatLng[0] += 0.000016
    LatLng[1] += 0.000016
    # LatLng.reverse()
    location = GeoPoint(LatLng[1], LatLng[0])
    añadirContenedor(element["properties"]["@id"], location, "organico")

def añadirContenedor(nodeId,location, categoria):
  doc_ref = db.collection(u'contenedores').document()
  #docId = doc_ref.id
  doc_ref.set({
    u'node_id': nodeId,
    u'location': location,
    u'categoria': categoria,
  })

def main():
  data=cargar_archivo(archivo)
  insertar_datos(data)

main()
