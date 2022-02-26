import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'extensions/youtube_meta_data.dart';
import 'hooks/timer.dart';
import 'hooks/youtube_player_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = useYoutubePlayerController('1b5AQ1yPGBo');
    final metaData = useState(controller.value.metaData);

    useEffect(() {
      void listenMetaDataChange() {
        if (controller.value.metaData != metaData.value) {
          metaData.value = controller.value.metaData;
        }
      }

      controller.addListener(listenMetaDataChange);
      return () => controller.removeListener(listenMetaDataChange);
    }, [controller]);

    usePeriodicTimer(
      duration: const Duration(seconds: 1),
      callback: (_) {
        print(controller.value.position);
      },
      keys: [controller.value.metaData],
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        bottomActions: [
          if (!metaData.value.isLive) ...[
            RemainingDuration(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                backgroundColor: Colors.grey,
                bufferedColor: Colors.blueGrey,
                playedColor: Colors.redAccent,
                handleColor: Colors.red,
              ),
            ),
          ],
          FullScreenButton(),
        ],
        onEnded: (metadata) {
          print('ended');
          // controller.load(metadata.videoId);
        },
      ),
      builder: (context, player) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                player,
                Center(
                  child: TextButton(
                    child: const Text('Load Video'),
                    onPressed: () {
                      controller.load('Z4haMzs_ins');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
