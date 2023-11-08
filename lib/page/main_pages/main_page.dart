import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/map_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: context.read<MapModel>().onMapCreated,
      initialCameraPosition: const CameraPosition(target: LatLng(37.63,127.07),zoom: 14.0),
    );
  }
}
