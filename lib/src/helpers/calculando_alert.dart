part of "helpers.dart";

void calculandoAlert(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Wait Please"),
        content: Text("Calculating Route"),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Wait Please"),
        content: CupertinoActivityIndicator(),
      ),
    );
  }
}
