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
      body: Stack(
        children: [
          BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (_, state) => Center(child: buildMap(state)),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment(0, -0.97),
              child: SearchBar(),
            ),
          ),
          ManualMarker(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbication(),
          BtnFollowing(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget buildMap(MyUbicationState state) {
    if (state.existUbication) {
      // ignore: close_sinks
      final mapaBloc = BlocProvider.of<MapaBloc>(context);
      mapaBloc.add(OnLocationUpdate(state.latLng));
      final cameraPosition = new CameraPosition(
        target: state.latLng,
        zoom: 15,
      );
      return BlocBuilder<MapaBloc, MapaState>(
        builder: (context, _) {
          return GoogleMap(
            initialCameraPosition: cameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: mapaBloc.initMap,
            polylines: mapaBloc.state.polylines.values.toSet(),
            onCameraMove: (position) {
              mapaBloc.add(OnMapMoved(position.target));
            },
          );
        },
      );
    }
    return Text('Ubicando...');
  }
}
