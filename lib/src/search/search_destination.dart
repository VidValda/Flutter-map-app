import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/src/models/search_result.dart';
import 'package:mapas_app/src/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  SearchDestination(this.proximity)
      : this.searchFieldLabel = "Buscar",
        this._trafficService = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final result = new SearchResult(isCanceled: true);
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, result),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    this._trafficService.getResultsQuery(query.trim(), proximity);
    return Text("Build results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = new SearchResult(isCanceled: false, manual: true);
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Manual ubication"),
          onTap: () {
            this.close(context, result);
          },
        )
      ],
    );
  }
}
