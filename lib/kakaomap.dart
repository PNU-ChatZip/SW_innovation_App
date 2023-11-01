import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'myGeolocator.dart';

class MyKakaoMap extends StatefulWidget {
  const MyKakaoMap({super.key});

  @override
  State<MyKakaoMap> createState() => _MyKakaoMapState();
}

class _MyKakaoMapState extends State<MyKakaoMap> {
  late KakaoMapController mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final LatLng? userLocation = snapshot.data;
          return KakaoMap(
            onMapCreated: ((controller) async {
              mapController = controller;

              markers.add(Marker(
                markerId: UniqueKey().toString(),
                latLng: await mapController.getCenter(),
              ));

              setState(() {});
            }),
            markers: markers.toList(),
            center: userLocation,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<LatLng> getLocation() async {
  Position position = await determinePosition();
  print(position);
  return LatLng(position.latitude, position.longitude);
}

// void _printCurrentLocation() async {
//   try {
//     LatLng currentLocation = await getLocation();
//     print(currentLocation.latitude.toString() +
//         " " +
//         currentLocation.longitude.toString());
//     location loc =location(currentLocation.latitude.toString(),currentLocation.longitude.toString());
//     Api().sendLocation(loc);
//   } catch (e) {
//     print("Failed to get location: $e");
//   }
// }
