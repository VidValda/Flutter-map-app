part of "widgets.dart";

class BtnUbication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    // ignore: close_sinks
    final ubicacionBloc = BlocProvider.of<MyUbicationBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            final destiny = ubicacionBloc.state.latLng;
            mapaBloc?.moverCamara(destiny);
          },
        ),
      ),
    );
  }
}
