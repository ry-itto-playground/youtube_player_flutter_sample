import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController useYoutubePlayerController(
  String initialVideoId, {
  YoutubePlayerFlags flags = const YoutubePlayerFlags(),
  List<Object?> keys = const [],
}) {
  return useMemoized(() {
    return YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: flags,
    );
  }, [...keys, initialVideoId, flags]);
}
