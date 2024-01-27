
import 'package:audioplayers/audioplayers.dart';

class MySource implements Source {
  final String link;

  MySource(this.link);

  @override
  String toString() {
    return link;
  }

  @override
  Future<void> setOnPlayer(Object ) {
    // TODO: implement setOnPlayer
    throw UnimplementedError();
  }


}
