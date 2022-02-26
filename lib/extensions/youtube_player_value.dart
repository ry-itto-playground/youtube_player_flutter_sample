import 'package:youtube_player_flutter/youtube_player_flutter.dart';

extension YoutubePlayerValueExt on YoutubePlayerValue {
  bool get isLive => metaData.duration == Duration.zero;
}
