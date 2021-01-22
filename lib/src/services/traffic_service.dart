import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/models/route_response.dart';

class TrafficService {
  //singleton
  TrafficService._private();
  static final TrafficService _instance = TrafficService._private();
  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final String baseUrl = "https://api.mapbox.com/directions/v5";
  final String _apiKey =
      "pk.eyJ1IjoidmlkdmFsZGEiLCJhIjoiY2trNGRmdTM5MHJraTJvazN1bW5vd293aiJ9.4esOMu8WM1jM8X2TTD-1yQ";

  Future<RouteResponse> getCoordsStartEnd(LatLng start, LatLng end) async {
    print(start);
    print(end);
    final coordString = "${start.longitude},${start.latitude};${end.longitude},${end.latitude}";
    final url = "$baseUrl/mapbox/driving/$coordString";
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
}
