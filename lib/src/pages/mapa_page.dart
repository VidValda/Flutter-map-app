import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/src/bloc/mi_ubicacion/my_ubication_bloc.dart';
import 'package:mapas_app/src/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MyUbicationBloc>(context).initFollowing();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyUbicationBloc>(context).disposeFollowing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyUbicationBloc, MyUbicationState>(
        builder: (_, state) => Center(child: buildMap(state)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbication(),
        ],
      ),
    );
  }

  Widget buildMap(MyUbicationState state) {
    print(state);
    if (state.existUbication) {
      final cameraPosition = new CameraPosition(
        target: state.latLng,
        zoom: 15,
      );
      return GoogleMap(
        initialCameraPosition: cameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: BlocProvider.of<MapaBloc>(context).initMap,
      );
    }
    return Text('Ubicando...');
  }
}
