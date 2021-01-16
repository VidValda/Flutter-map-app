import 'package:flutter/material.dart';
import 'package:mapas_app/src/pages/acceso_gps_page.dart';
import 'package:mapas_app/src/pages/loading_page.dart';
import 'package:mapas_app/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "loading",
      routes: {
        "mapa": (_) => MapaPage(),
        "loading": (_) => LoadingPage(),
        "acceso_gps": (_) => AccesoGPSPage(),
      },
    );
  }
}
