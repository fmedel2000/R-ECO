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
    if (("recycling:cooking_oil" in element["properties"])):
      LatLng = element["geometry"]["coordinates"]
      LatLng[0] += 0.000006
      LatLng[1] += 0.000006
      #LatLng.reverse()
      location = GeoPoint(LatLng[1], LatLng[0])
      añadirContenedor(element["properties"]["@id"], location, "aceite")

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
