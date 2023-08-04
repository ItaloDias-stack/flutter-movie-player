# Playrer de Vídeo com legenda

Documentação do player de vídeo usado no projeto de untold

### Bibliotecas utilizadas

- [video_player](https://pub.dev/packages/video_player)
- [flick_video_player](https://pub.dev/packages/flick_video_player)
- [subtitle_wrapper_package](https://pub.dev/packages/subtitle_wrapper_package)

### Implementação do player

Para implementar o *video player* é necessário iniciar o objeto ***FlickManager*** com o link do vídeo, como na imagem abaixo: 

![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/ae3cd39d-6a7a-4268-adb3-8658b9c12210)

Logo após isso é necessário usar um *PostFrameCallback* para realizar o adiantamento de tempo no início do vídeo: 

![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/ecb6e083-f14a-4fc3-afb7-e44b6aeb1057)

Além disso se lembre de remover os overlays da tela do player e de trocar a orientação do app e se fizer isso se lembre de desfazer a mudança no dispose()

Dentro do build o widget utilizado é esse:

![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/c525d1d7-bfb6-424d-827f-d4366b427f51)

Nesse widget é necessário passar a horientação do vídeo na tela, caso queira deixar a tela em full screen, no *child* desse widget você precisa passar o *FlickVideoWithControls* para você ter a liberdade de customizar os widgets que aparecerão na tela acima do vídeo como esses: 
![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/d3ecd306-63b1-4337-89f7-5bd48bfdecc2)

Mas, caso você queira mostrar legendas no vídeo é necessário que antes do *FlickVideoWithControls* tenha um widget chamado de *SubtitleWrapper*, em que você passa os estilo da legenda, o controller da legenda e o controller do vídeo.

### Implementação dos controles

Dentro do *FlickVideoWithControls* é necessário que você crie um widget com o nome que você desejar e passe ele para a propriedade *controls* dentro de *FlickVideoWithControls*

Para fazer os controles é necessário que se use uma Stack, para organizar melhor os widgets dentro da tela. A biblioteca [flick_video_player](https://pub.dev/packages/flick_video_player) oferece muitos componentes prontos, como botão de play/pause, adiantar e voltar no tempo do vídeo, fullscreen, barra de progresso e muitos outros, mas é possível fazer eles do zero usando um componente que a lib oferece chamado de ***FlickAutoHideChild***, que faz o comportamento de mostrar os componentes ao clicar na tela e fazer eles "sumirem". Mas, como nem tudo são flores a funcionalidade de avançar/voltar dessa lib não tem um comportamento muito bom, então normalmente eu sobrescrevo a funcionalidade nativa da seguinte forma:

![image](https://github.com/ItaloDias-stack/flutter-movie-player/assets/56097945/e9f27d79-82bd-4df5-954d-06d8930164cc)

Em resumo eu deixo as funções nativas desativadas e encolho os ícones usando o *SizedBox.shrink()* ai no child eu centralizo os componentes e alinho os componentes usando a uma ***Row*** e oculto eles usando ***FlickAutoHideChild***. 

### Trocar as legendas

Caso você deseje implementar as legendas é necessário de um objeto chamado de ***SubtitleController***


