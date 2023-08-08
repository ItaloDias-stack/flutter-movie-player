import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_movie_player/external/models/movie_subtitles.dart';
import 'package:flutter_movie_player/presentation/stores/player_store.dart';
import 'package:get_it/get_it.dart';

class SubtitlesScreen extends StatefulWidget {
  static const routeName = "subtitles_screen";
  const SubtitlesScreen({super.key});

  @override
  State<SubtitlesScreen> createState() => _SubtitlesScreenState();
}

class _SubtitlesScreenState extends State<SubtitlesScreen> {
  final movieStore = GetIt.I.get<PlayerStore>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: Observer(
        builder: (context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                right: 16,
                left: 44,
                top: 24,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 40,
                          child: Text(
                            "Close",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.yellow,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subtitle",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          ...movieStore.subtitles
                              .map(
                                (subtitle) => Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: LanguageContainer(subtitle: subtitle),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LanguageContainer extends StatelessWidget {
  final MovieSubtitle subtitle;
  LanguageContainer({
    super.key,
    required this.subtitle,
  });

  final movieStore = GetIt.I.get<PlayerStore>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () {
          movieStore.updateSubtitleUrl(subtitleLanguage: subtitle);
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: subtitle == movieStore.selectedSubtitle
                ? Colors.yellow.withOpacity(.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            subtitle.language,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: subtitle == movieStore.selectedSubtitle
                      ? Colors.yellow
                      : Colors.white.withOpacity(.45),
                ),
          ),
        ),
      );
    });
  }
}
