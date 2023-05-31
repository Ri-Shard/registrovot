import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(10.477445, -73.246214),
          zoom: 12,
        ),
        nonRotatedChildren: [
          SizedBox(
            // width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          final centerZoom = _mapController
                              .centerZoomFitBounds(_mapController.bounds!);
                          var zoom = centerZoom.zoom + 0.5;
                          if (zoom > 20) {
                            zoom = 20;
                          }
                          _mapController.move(centerZoom.center, zoom);
                        }),
                    FloatingActionButton(
                        child: Icon(Icons.remove),
                        onPressed: () {
                          final centerZoom = _mapController
                              .centerZoomFitBounds(_mapController.bounds!);
                          var zoom = centerZoom.zoom - 0.5;
                          if (zoom < 10) {
                            zoom = 10;
                          }
                          _mapController.move(centerZoom.center, zoom);
                        }),
                  ],
                ),
              ],
            ),
          )
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                  point: LatLng(10.477445, -73.246214),
                  builder: (_) {
                    return const Icon(Icons.location_on_rounded);
                  })
            ],
          )
        ],
      ),
    );
  }
}
