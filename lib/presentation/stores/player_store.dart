import 'package:flutter_movie_player/external/models/movie.dart';
import 'package:flutter_movie_player/external/models/movie_subtitles.dart';
import 'package:mobx/mobx.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
part 'player_store.g.dart';

class PlayerStore = _PlayerStoreBase with _$PlayerStore;

abstract class _PlayerStoreBase with Store {
  @observable
  FlickManager? flickManager;

  @observable
  Movie movie = const Movie();

  @observable
  MovieSubtitle selectedSubtitle = const MovieSubtitle();

  @observable
  SubtitleController subtitleController = SubtitleController(
    subtitleUrl: "",
    subtitleDecoder: SubtitleDecoder.utf8,
    subtitleType: SubtitleType.webvtt,
  );

  @observable
  ObservableList<MovieSubtitle> subtitles = ObservableList.of([
    const MovieSubtitle(
      language: "off",
      name: "",
      url: "https://pastebin.com/raw/Axt47CKa",
    ),
    const MovieSubtitle(
      language: "en",
      name: "English",
      url: "https://pastebin.com/raw/W5rF45tN",
    ),
    const MovieSubtitle(
      language: "es",
      name: "Spanish",
      url: "https://pastebin.com/raw/tsT3qtHf",
    ),
    const MovieSubtitle(
      language: "nl",
      name: "Dutch",
      url: "https://pastebin.com/raw/L0qEE0cA",
    ),
  ]);

  @action
  updateSubtitleUrl({
    required MovieSubtitle subtitleLanguage,
  }) {
    selectedSubtitle = subtitleLanguage;
    subtitleController.updateSubtitleUrl(
      url: subtitleLanguage.url,
    );
  }
}
