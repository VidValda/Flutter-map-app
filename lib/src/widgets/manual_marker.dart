part of "widgets.dart";

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.isManual ? _BuildManualMarker() : Container();
      },
    );
  }
}

class _BuildManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          left: 20,
          top: 70,
          child: FadeInLeft(
            duration: Duration(milliseconds: 400),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  BlocProvider.of<SearchBloc>(context).add(OnManual());
                },
              ),
            ),
          ),
        ),
        BounceInDown(
          from: 200,
          child: Center(
            child: Transform.translate(
              offset: Offset(0, -22),
              child: Icon(Icons.location_on, size: 50),
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 2,
              textColor: Colors.white,
              minWidth: width - 120,
              child: Text("Confirm ubication?"),
              onPressed: () {
                calcularDestino(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlert(context);
    final trafficService = TrafficService();

    final start = BlocProvider.of<MyUbicationBloc>(context).state.latLng;
    final end = BlocProvider.of<MapaBloc>(context).state.centralUbication;

    final routeResponse = await trafficService.getCoordsStartEnd(start, end);
    if (routeResponse.code != null) {
      final geometry = routeResponse.routes[0].geometry;
      final duration = routeResponse.routes[0].duration;
      final distance = routeResponse.routes[0].distance;
      // decodificar los puntos del geometry
      final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
      final List<LatLng> coordList = points.map((punto) => LatLng(punto[0], punto[1])).toList();
      BlocProvider.of<MapaBloc>(context).add(OnBuildRoute(
        coords: coordList,
        distance: distance,
        duration: duration,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Route not founded"),
        action: SnackBarAction(
          label: "OK",
          onPressed: Scaffold.of(context).hideCurrentSnackBar,
        ),
      ));
    }
    Navigator.of(context).pop();
    BlocProvider.of<SearchBloc>(context).add(
      OnAddHistory(
        SearchResult(
          isCanceled: false,
          description: "Manual marker",
          latLng: end,
          manual: false,
          nombreDest: "${end.latitude}, ${end.longitude}",
        ),
      ),
    );
    BlocProvider.of<SearchBloc>(context).add(OnManual());
  }
}
