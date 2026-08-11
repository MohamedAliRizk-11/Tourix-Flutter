import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';

class PlaceHeroMedia extends StatefulWidget {
  final String imageUrl;
  final String? videoUrl;

  const PlaceHeroMedia({super.key, required this.imageUrl, this.videoUrl});

  @override
  State<PlaceHeroMedia> createState() => _PlaceHeroMediaState();
}

class _PlaceHeroMediaState extends State<PlaceHeroMedia> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
            ..initialize().then((_) {
              if (!mounted) return;
              setState(() {});
              _controller!
                ..setLooping(true)
                ..setVolume(0)
                ..play();
            });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && _controller!.value.isInitialized) {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorWidget: (_, __, ___) => Container(color: AppColors.surface),
    );
  }
}
