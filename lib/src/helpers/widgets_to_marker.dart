part of "helpers.dart";

Future<BitmapDescriptor> getMarkerStartIcon(int segundos) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final startMarker = MarkerStartPainter((segundos / 60).floor());
  startMarker.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.floor(), size.height.floor());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerEndIcon(String description, double distance) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final size = ui.Size(350, 150);

  final endMarker = MarkerEndPainter(description, distance);
  endMarker.paint(canvas, size);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.floor(), size.height.floor());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}
