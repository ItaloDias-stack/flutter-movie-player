import 'package:mobx/mobx.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
part 'player_store.g.dart';

class PlayerStore = _PlayerStoreBase with _$PlayerStore;

abstract class _PlayerStoreBase with Store {
  @observable
  FlickManager? flickManager;

  @observable
  SubtitleController subtitleController = SubtitleController(
    subtitleUrl: "",
    subtitleDecoder: SubtitleDecoder.utf8,
    subtitleType: SubtitleType.webvtt,
  );
}
