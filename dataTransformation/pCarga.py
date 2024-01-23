# Usar el comando: pip install --upgrade firebase-admin
import json

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from google.cloud.firestore import GeoPoint

cred= credentials.Certificate("DATABASE_CREDENTIALS.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

archivo = 'pCarga.json'

def cargar_archivo(archivo):
  with open(archivo) as datos:
    data=json.load(datos)
  return data

def insertar_datos(data,i):
  for element in data["features"]:
      LatLng = element["geometry"]["coordinates"]
      location = GeoPoint(LatLng[1], LatLng[0])
      i+=1
      añadirContenedor("pCarga"+str(i), location, element["geometry"]["categoria"])

def añadirContenedor(nodeId,location, categoria):
  doc_ref = db.collection(u'pCarga').document()
  #docId = doc_ref.id
  doc_ref.set({
    u'node_id': nodeId,
    u'location': location,
    u'categoria': categoria,
  })

def main():
  data=cargar_archivo(archivo)
  i=0
  insertar_datos(data,i)

main()
