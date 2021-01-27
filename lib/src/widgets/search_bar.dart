part of "widgets.dart";

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.isManual
            ? Container()
            : FadeInDown(
                child: buildSearchBar(context),
                duration: Duration(milliseconds: 400),
              );
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          final proximity = BlocProvider.of<MyUbicationBloc>(context).state.latLng;
          final result = await showSearch(context: context, delegate: SearchDestination(proximity));
          this.retornoBusqueda(context, result);
        },
        child: Container(
          padding: EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 5)),
            ],
          ),
          alignment: Alignment.centerLeft,
          child: Text("¿Where do you wanna go?", style: TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) async {
    if (result.isCanceled) {
      return;
    }
    if (result.manual) {
      BlocProvider.of<SearchBloc>(context).add(OnManual());
      return;
    }
    calculandoAlert(context);
    final start = BlocProvider.of<MyUbicationBloc>(context).state.latLng;
    final end = result.latLng;

    final routeResponse = await TrafficService().getCoordsStartEnd(start, end);

    if (routeResponse.code != null) {
      final geometry = routeResponse.routes[0].geometry;
      final distance = routeResponse.routes[0].distance;
      final duration = routeResponse.routes[0].duration;

      final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
      final coords = points.map((e) => LatLng(e[0], e[1])).toList();

      BlocProvider.of<MapaBloc>(context).add(OnBuildRoute(
        coords: coords,
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
    Navigator.pop(context);
    BlocProvider.of<SearchBloc>(context).add(OnAddHistory(result));
  }
}
