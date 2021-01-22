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

  void retornoBusqueda(BuildContext context, SearchResult result) {
    if (result.isCanceled) {
      return;
    }
    if (result.manual) {
      BlocProvider.of<SearchBloc>(context).add(OnManual());
      return;
    }
  }
}
