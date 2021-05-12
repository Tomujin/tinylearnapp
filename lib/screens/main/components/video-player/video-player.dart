import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TinyVideoPlayer extends StatefulWidget {
  final String videoPath;

  TinyVideoPlayer({Key key, @required this.videoPath}) : super(key: key);

  @override
  _TinyVideoPlayerWidgetState createState() => _TinyVideoPlayerWidgetState();
}

class _TinyVideoPlayerWidgetState extends State<TinyVideoPlayer> {
  VideoPlayerController _controller;
  Icon iconSound = Icon(Icons.mic_rounded);
  Icon iconVideo = Icon(Icons.pause);

  Future<void> setupVideo() async {
    _controller = VideoPlayerController.network(widget.videoPath);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.setVolume(50);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void initState() {
    super.initState();
    setupVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(children: [
          _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          Positioned(
              bottom: 1,
              right: 1,
              child: IconButton(
                icon: iconSound,
                onPressed: () {
                  setState(() {
                    _controller.value.volume == 0
                        ? _controller.setVolume(50)
                        : _controller.setVolume(0);
                  });
                },
              )),
          Positioned(
              bottom: 1,
              left: 1,
              child: IconButton(
                icon: iconVideo,
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
