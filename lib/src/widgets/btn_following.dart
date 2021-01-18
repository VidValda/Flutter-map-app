part of "widgets.dart";

class BtnFollowing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapaBloc>(context);
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                mapBloc.state.seguirUbicacion ? Icons.directions_run : Icons.accessibility_new,
                color: Colors.black87,
              ),
              onPressed: () {
                mapBloc.add(OnFollowing());
              },
            ),
          ),
        );
      },
    );
  }
}
