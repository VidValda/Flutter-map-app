import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/src/helpers/debouncer.dart';
import 'package:mapas_app/src/models/route_response.dart';
import 'package:mapas_app/src/models/search_response.dart';

class TrafficService {
  //singleton
  TrafficService._private();
  static final TrafficService _instance = TrafficService._private();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));
  final StreamController<SearchResponse> _sugerenciasStreamController =
      StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;
  void closeStream() {
    _sugerenciasStreamController.close();
  }

  final String _baseUrl = "https://api.mapbox.com/directions/v5";
  final String _baseUrlDir = "https://api.mapbox.com/geocoding/v5";
  final String _apiKey =
      "pk.eyJ1IjoidmlkdmFsZGEiLCJhIjoiY2trNGRmdTM5MHJraTJvazN1bW5vd293aiJ9.4esOMu8WM1jM8X2TTD-1yQ";

  Future<RouteResponse> getCoordsStartEnd(LatLng start, LatLng end) async {
    print(start);
    print(end);
    final coordString = "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final url = "$_baseUrl/mapbox/driving/$coordString";
    try {
      final resp = await this._dio.get(url, queryParameters: {
        "alternatives": true,
        "geometries": "polyline6",
        "steps": false,
        "access_token": _apiKey,
        "language": "es",
      });
      final data = RouteResponse.fromJson(resp.data);
      return data;
    } catch (e) {
      return RouteResponse();
    }
  }

  Future<SearchResponse> getResultsQuery(String query, LatLng proximity) async {
    print("Searching..");
    final url = "$_baseUrlDir/mapbox.places/$query.json";
    try {
      final resp = await this._dio.get(
        url,
        queryParameters: {
          "access_token": this._apiKey,
          "autocomplete": true,
          "proximity": "${proximity.longitude},${proximity.latitude}",
          "language": "es",
        },
      );
      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }

  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultsQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }
}
