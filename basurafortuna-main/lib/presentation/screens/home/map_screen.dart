import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Color color1 = const Color(0xFF021024);
Color color2 = const Color(0xFF052659);

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(-33.44360731674993, -70.66221141951034),
        initialZoom: 17,
      ),
      children: [
        // show map
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),

        // map marker
        MarkerLayer(
          markers: [
            // actual location
            Marker(
              rotate: true,
              point: const LatLng(-33.44360731674993, -70.66221141951034),
              width: 10,
              height: 10,
              child: Icon(
                Icons.location_on,
                color: color2,
                size: 28,
              ),
            ),

            // recycling location
            Marker(
              rotate: true,
              point: const LatLng(-33.44300805853135, -70.6613902739964),
              width: 10,
              height: 10,
              child: Icon(
                Icons.recycling_rounded,
                color: Colors.redAccent[700],
              ),
            ),
            Marker(
              rotate: true,
              point: const LatLng(-33.44407994801386, -70.66326279332796),
              width: 10,
              height: 10,
              child: Icon(
                Icons.recycling_rounded,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),

        // attribution layer
        RichAttributionWidget(
          animationConfig: const ScaleRAWA(),
          attributions: [
            TextSourceAttribution(
              textStyle: const TextStyle(),
              prependCopyright: false,
              'Puntos cercanos de reciclaje.\nClic aqui para significado de colores',
              onTap: () {
                openDialog(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  openDialog(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Color por tipo de reciclaje',
                style: TextStyle(
                  color: color1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              RecyclingType(
                title: 'Papel y cartón',
                itColor: Colors.blue[900],
              ),
              RecyclingType(
                title: 'Plástico',
                itColor: Colors.yellowAccent[700],
              ),
              RecyclingType(
                title: 'Vidrio',
                itColor: Colors.greenAccent[400],
              ),
              RecyclingType(
                title: 'Residuos eléctricos y electrónicos',
                itColor: Colors.purpleAccent[100],
              ),
              RecyclingType(
                title: 'Residuos peligrosos',
                itColor: Colors.redAccent[700],
              ),
              RecyclingType(
                title: 'Materia orgánica',
                itColor: Colors.brown[600],
              ),
              const SizedBox(height: 15),
              const Divider(),

              // return button
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Volver',
                      style: TextStyle(color: color2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
