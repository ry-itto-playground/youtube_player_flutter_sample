import 'package:youtube_player_flutter/youtube_player_flutter.dart';

extension YoutubeMetaDataExt on YoutubeMetaData {
  bool get isLive => duration == Duration.zero;
}
