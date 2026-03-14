import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PinchZoomImage extends StatefulWidget {
  final String imageUrl;
  final Widget child;

  const PinchZoomImage({
    Key? key,
    required this.imageUrl,
    required this.child,
  }) : super(key: key);

  @override
  State<PinchZoomImage> createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage> {
  final _controller = PhotoViewController();
  bool _isZooming = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (_) => setState(() => _isZooming = true),
      onScaleEnd: (_) {
        setState(() => _isZooming = false);
        _controller.scale = 1.0;
        _controller.position = Offset.zero;
      },
      child: Stack(
        children: [
          if (_isZooming)
            Positioned.fill(
              child: Container(
                color: Colors.black,
                child: PhotoView(
                  imageProvider: NetworkImage(widget.imageUrl),
                  controller: _controller,
                  backgroundDecoration: const BoxDecoration(color: Colors.black),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  initialScale: PhotoViewComputedScale.contained,
                  basePosition: Alignment.center,
                ),
              ),
            ),
          if (!_isZooming) widget.child,
        ],
      ),
    );
  }
}