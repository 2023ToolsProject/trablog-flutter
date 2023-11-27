import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trablog/view_model/map_model.dart';
import 'package:trablog/view_model/memory_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MemoryModel>().getData();
  }

  @override
  Widget build(BuildContext context) {
      return GoogleMap(
        markers: context.watch<MemoryModel>().markers,
        onTap: context.read<MapModel>().onTap,
        onMapCreated: context.read<MapModel>().onMapCreated,
        initialCameraPosition: const CameraPosition(target: LatLng(37.63,127.07),zoom: 14.0),
      );
  }
}
