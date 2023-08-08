import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_player/presentation/stores/player_store.dart';
import 'package:flutter_movie_player/presentation/views/player_screen/components/custom_player_controls.dart';
import 'package:get_it/get_it.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "player_screen";
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with WidgetsBindingObserver {
  final store = GetIt.I.get<PlayerStore>();
  late FlickManager flickManager;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      store.updateSubtitleUrl(subtitleLanguage: store.subtitles[0]);
    });
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/9th_may_compressed.mp4?raw=true",
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: flickManager,
              preferredDeviceOrientation: const [
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft
              ],
              flickVideoWithControls: SubtitleWrapper(
                subtitleController: store.subtitleController,
                videoPlayerController:
                    flickManager.flickVideoManager!.videoPlayerController!,
                subtitleStyle: const SubtitleStyle(
                  textColor: Colors.yellow,
                  fontSize: 20,
                  hasBorder: true,
                  position: SubtitlePosition(bottom: 40),
                ),
                videoChild: FlickVideoWithControls(
                  controls: CustomPlayerControls(
                    flickManager: flickManager,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
