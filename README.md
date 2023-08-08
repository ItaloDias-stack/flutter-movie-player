# Playrer de Vídeo com legenda

Documentação do player de vídeo usado no projeto de untold

### Bibliotecas utilizadas

- [video_player](https://pub.dev/packages/video_player)
- [flick_video_player](https://pub.dev/packages/flick_video_player)
- [subtitle_wrapper_package](https://pub.dev/packages/subtitle_wrapper_package)

### Implementação do player
Se você deseja criar um player de vídeo em Flutter semelhante ao da Netflix, com suporte a legendas e a capacidade de personalizar os widgets exibidos na tela, a melhor opção que encontrei foi utilizar a biblioteca [flick_video_player](https://pub.dev/packages/flick_video_player).

### Hello World

Um exemplo de "Hello World" para usar essa biblioteca é o seguinte:

```dart
class HelloWorldScreen extends StatefulWidget {
  static const routeName = "hello_world_screen";
  const HelloWorldScreen({super.key});

  @override
  State<HelloWorldScreen> createState() => _HelloWorldScreenState();
}

class _HelloWorldScreenState extends State<HelloWorldScreen> {
  late FlickManager flickManager;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: const FlickVideoWithControls(
          closedCaptionTextStyle: TextStyle(fontSize: 8),
          controls: FlickPortraitControls(),
        ),
        flickVideoWithControlsFullscreen: const FlickVideoWithControls(
          controls: FlickLandscapeControls(),
        ),
      ),
    );
  }
}
```

O resultado é esse: 

![0eb0dcaa-57b4-4590-a894-d3d9547ab905](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/85481847-c301-4231-bc5d-d773e838bf67)

## Player customizado com legenda

Para implementar o video player, é necessário iniciar o objeto ***FlickManager*** com o link do vídeo, como mostrado abaixo:

```dart
flickManager = FlickManager(
  videoPlayerController: VideoPlayerController.networkUrl(
    Uri.parse(
      "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/9th_may_compressed.mp4?raw=true",
    ),
  ),
);
```

A partir daí, a tela do player é montada da seguinte forma:

```dart
Scaffold(
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
```
O widget usado para construir o player é o **FlickVideoPlayer**, ao qual é passado o gerenciador (manager), a orientação do dispositivo em que o vídeo será exibido e, para exibir os widgets acima do vídeo, é necessário usar o parâmetro *flickVideoWithControls*. Caso você deseje adicionar legendas, é necessário usar o widget *SubtitleWrapper* e dentro dele chamar o *FlickVideoWithControls* para ter a liberdade de personalizar os widgets que aparecerão na tela acima do vídeo.

## Widgets sobrepostos ao vídeo

Se você deseja mostrar widgets sobrepostos ao vídeo, é necessário usar o *FlickVideoWithControls*, que pode ser usado dentro do *SubtitleWrapper* (quando as legendas são necessárias) ou diretamente no parâmetro *flickVideoWithControls* do widget *FlickVideoPlayer*. Assim, você tem várias opções e widgets que a biblioteca [flick_video_player](https://pub.dev/packages/flick_video_player) fornece. Você pode personalizar os controles para criar um layout como o exemplo abaixo:

![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/d3ecd306-63b1-4337-89f7-5bd48bfdecc2)

Para personalizar esses controles, é necessário criar um widget personalizado, que terá os widgets desejados. Um exemplo desse widget personalizado é mostrado abaixo:

```dart
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
```
Os widges representados nessa classe são: 
- Botão de avançar/voltar o vídeo 
- Botão de play/pause
- Botão de voltar e título do vídeo
- Botão para selecionar a legenda
- Barra de progresso


Para os dois primeiros componentes é necessário usar o *FlickShowControlsAction* e dentro dele usar *FlickSeekVideoAction* que vai possuir esses dois componentes nativamente, mas também é possível realizar customizações como as do exemplo acima, que os ícones foram trocados e algumas funcionalidades padrões foram trocadas, pois nativamente para avançar/voltar o vídeo é necessário dar dois cliques na tela, então nesse exemplo eu removi essa funcionalidade com esses parâmetros: 

```dart
seekForward: () {},
seekBackward: () {},
forwardSeekIcon: const SizedBox.shrink(),
backwardSeekIcon: const SizedBox.shrink(),
```


### Legendas

Para implementar legendas, é necessário utilizar um objeto chamado *SubtitleController* na store e passá-lo para o widget *SubtitleWrapper*, como mostrado abaixo:

```dart
@observable
SubtitleController subtitleController = SubtitleController(
  subtitleUrl: "",
  subtitleDecoder: SubtitleDecoder.utf8,
  subtitleType: SubtitleType.webvtt,
);

@action
updateSubtitleUrl({
  required MovieSubtitle subtitleLanguage,
}) {
  selectedSubtitle = subtitleLanguage;
  subtitleController.updateSubtitleUrl(
    url: subtitleLanguage.url,
  );
}
```

Caso queira trocar o tipo de legenda, a biblioteca suporta os tipos webvtt e srt. Para trocar a legenda, chame a função updateSubtitleUrl. Dentro do SubtitleWrapper, é possível configurar o estilo da legenda usando subtitleStyle.

Nota: Caso deseje desativar as legendas temporariamente, não deixe o controlador de legenda vazio, pois isso pode gerar erros no console. Você pode usar um arquivo de legenda como exemplo [aqui](https://pastebin.com/raw/Axt47CKa).

Um exemplo de tela que troca as legendas é mostrado abaixo:

```dart
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
```

Nota: nesse repositório é encontrado todos os códigos usados
- Versão do flutter 3.10.5
