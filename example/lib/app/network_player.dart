import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class NetworkPlayer extends StatefulWidget {
  const NetworkPlayer({super.key, required this.url});

  final String url;

  @override
  State<NetworkPlayer> createState() => _NetworkPlayerState();
}

class _NetworkPlayerState extends State<NetworkPlayer> with AutomaticKeepAliveClientMixin{
  late VideoPlayerController videoController;
  ChewieController? _chewieController;
  int? bufferDelay;
  late ValueNotifier<bool> _initializedNotifier;

  @override
  void initState() {
    super.initState();
    _initializedNotifier = ValueNotifier<bool>(false);
    initializePlayer();
  }

  @override
  void dispose() {
    videoController.dispose();
    _chewieController?.dispose();
    _initializedNotifier.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await videoController.initialize();
    _chewieController = ChewieController(
      showOptions: false,
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay: bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 2),
    );
    _initializedNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ValueListenableBuilder<bool>(
        valueListenable: _initializedNotifier,
        builder: (context, initialized, _) {
          if (initialized) {
            return Chewie(controller: _chewieController!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
