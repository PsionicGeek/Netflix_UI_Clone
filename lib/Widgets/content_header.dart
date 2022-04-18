import 'package:flutter/material.dart';
import 'package:netflix_clone/Widgets/widgets.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredHeader;
  const ContentHeader({Key? key, required this.featuredHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredHeader: featuredHeader),
        desktop: _ContentHeaderDesktop(featuredHeader: featuredHeader));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredHeader;
  const _ContentHeaderMobile({Key? key, required this.featuredHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredHeader.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredHeader.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'List',
                onTap: () => print('My list'),
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () => print('info'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredHeader;
  const _ContentHeaderDesktop({Key? key, required this.featuredHeader})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredHeader.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredHeader.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredHeader.titleImageUrl),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredHeader.description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(
                            2.0,
                            4.0,
                          ),
                          blurRadius: 6.0,
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(
                      width: 16.0,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.fromLTRB(
                        25.0,
                        10.0,
                        30.0,
                        10.0,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        size: 30.0,
                      ),
                      label: const Text(
                        'More Info',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                        }),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(
              15.0,
              5.0,
              20.0,
              5.0,
            )
          : const EdgeInsets.fromLTRB(
              25.0,
              10.0,
              30.0,
              10.0,
            ),
      color: Colors.white,
      onPressed: () => print('play'),
      icon: Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
