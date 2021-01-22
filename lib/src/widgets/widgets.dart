import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/src/bloc/search/search_bloc.dart';
import 'package:mapas_app/src/bloc/mi_ubicacion/my_ubication_bloc.dart';
import 'package:mapas_app/src/helpers/helpers.dart';
import 'package:mapas_app/src/models/search_result.dart';
import 'package:mapas_app/src/search/search_destination.dart';
import 'package:mapas_app/src/services/traffic_service.dart';
import 'package:polyline/polyline.dart' as Poly;

part 'btn_location.dart';
part 'btn_mi_ruta.dart';
part 'btn_following.dart';
part 'search_bar.dart';
part 'manual_marker.dart';
