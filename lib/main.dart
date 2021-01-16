import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/src/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/src/bloc/mi_ubicacion/my_ubication_bloc.dart';
import 'package:mapas_app/src/pages/acceso_gps_page.dart';
import 'package:mapas_app/src/pages/loading_page.dart';
import 'package:mapas_app/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyUbicationBloc()),
        BlocProvider(create: (_) => MapaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "loading",
        routes: {
          "mapa": (_) => MapaPage(),
          "loading": (_) => LoadingPage(),
          "acceso_gps": (_) => AccesoGPSPage(),
        },
      ),
    );
  }
}
