import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_movie_player/presentation/views/subtitles_screen/subtitles_screen.dart';

class CustomPlayerControls extends StatefulWidget {
  final FlickManager flickManager;
  const CustomPlayerControls({super.key, required this.flickManager});

  @override
  State<CustomPlayerControls> createState() => _CustomPlayerControlsState();
}

class _CustomPlayerControlsState extends State<CustomPlayerControls> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlickAutoHideChild(
              child: Container(
                color: Colors.black.withOpacity(.6),
              ),
            ),
          ),
          Positioned.fill(
            child: FlickShowControlsAction(
              child: FlickSeekVideoAction(
                seekForward: () {},
                seekBackward: () {},
                forwardSeekIcon: const SizedBox.shrink(),
                backwardSeekIcon: const SizedBox.shrink(),
                duration: const Duration(seconds: 15),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlickAutoHideChild(
                        child: GestureDetector(
                          onTap: () {
                            widget.flickManager.flickControlManager!
                                .seekBackward(
                              const Duration(seconds: 15),
                            );
                          },
                          child: const Icon(
                            Icons.history,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FlickVideoBuffer(
                        child: FlickAutoHideChild(
                          showIfVideoNotInitialized: false,
                          child: FlickPlayToggle(
                            size: 70,
                            playChild: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.black,
                              size: 50,
                            ),
                            pauseChild: const Icon(
                              Icons.pause_rounded,
                              color: Colors.black,
                              size: 50,
                            ),
                            color: Colors.black,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      FlickAutoHideChild(
                        child: GestureDetector(
                          onTap: () {
                            widget.flickManager.flickControlManager!
                                .seekForward(const Duration(seconds: 15));
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FlickAutoHideChild(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          "Título do Vídeo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(width: 100),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              SubtitlesScreen.routeName,
                            );
                          },
                          child: const Icon(
                            Icons.subtitles_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FlickAutoHideChild(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FlickVideoProgressBar(
                            flickProgressBarSettings: FlickProgressBarSettings(
                              backgroundColor: Colors.grey.shade500,
                              playedColor: Colors.redAccent,
                              handleColor: Colors.redAccent,
                              height: 4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 28),
                        const FlickLeftDuration(
                          fontSize: 17,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
