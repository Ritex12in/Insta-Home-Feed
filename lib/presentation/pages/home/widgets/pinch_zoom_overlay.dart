import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _ZoomState {
  final double scale;
  final Offset offset;
  const _ZoomState({required this.scale, required this.offset});
}

class PinchZoomOverlay extends StatefulWidget {
  final Widget child;
  final String? imageUrl;

  const PinchZoomOverlay({
    super.key,
    required this.child,
    this.imageUrl,
  });

  @override
  State<PinchZoomOverlay> createState() => _PinchZoomOverlayState();
}

class _PinchZoomOverlayState extends State<PinchZoomOverlay> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey();
  bool _isZooming = false;
  Offset _focalPoint = Offset.zero;

  // ValueNotifier drives the overlay — no setState needed
  final ValueNotifier<_ZoomState> _zoomNotifier = ValueNotifier(
    const _ZoomState(scale: 1.0, offset: Offset.zero),
  );

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _zoomNotifier.dispose();
    super.dispose();
  }

  void _onScaleStart(ScaleStartDetails details) {
    if (details.pointerCount < 2) return;
    _isZooming = true;
    _focalPoint = details.focalPoint;
    _zoomNotifier.value = const _ZoomState(scale: 1.0, offset: Offset.zero);
    _showOverlay();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (!_isZooming) return;
    _zoomNotifier.value = _ZoomState(
      scale: details.scale.clamp(1.0, 5.0),
      offset: details.focalPoint - _focalPoint,
    );
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (!_isZooming) return;
    _isZooming = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _zoomNotifier.value = const _ZoomState(scale: 1.0, offset: Offset.zero);
  }

  void _showOverlay() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final widgetOffset = renderBox.localToGlobal(Offset.zero);
    final widgetSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (_) => _ZoomOverlayContent(
        imageUrl: widget.imageUrl,
        widgetOffset: widgetOffset,
        widgetSize: widgetSize,
        zoomNotifier: _zoomNotifier,
        child: widget.child,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.translucent,
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: _onScaleEnd,
      child: widget.child,
    );
  }
}

// ─── Overlay content ─────────────────────────────────────────────────────────

class _ZoomOverlayContent extends StatefulWidget {
  final Widget child;
  final String? imageUrl;
  final Offset widgetOffset;
  final Size widgetSize;
  final ValueNotifier<_ZoomState> zoomNotifier;

  const _ZoomOverlayContent({
    required this.child,
    this.imageUrl,
    required this.widgetOffset,
    required this.widgetSize,
    required this.zoomNotifier,
  });

  @override
  State<_ZoomOverlayContent> createState() => _ZoomOverlayContentState();
}

class _ZoomOverlayContentState extends State<_ZoomOverlayContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bgController;
  late final Animation<double> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    _bgAnimation = CurvedAnimation(parent: _bgController, curve: Curves.easeOut);
    _bgController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _bgAnimation,
        builder: (_, _) {
          return Stack(
            children: [
              // Dark scrim
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.85 * _bgAnimation.value),
                  ),
                ),
              ),

              // Zoomed image — driven by ValueNotifier, no setState
              ValueListenableBuilder<_ZoomState>(
                valueListenable: widget.zoomNotifier,
                builder: (_, zoom, _) {
                  final left = (screenSize.width - widget.widgetSize.width) / 2 + zoom.offset.dx;
                  final top = (screenSize.height - widget.widgetSize.height) / 2 + zoom.offset.dy;

                  return Positioned(
                    left: left,
                    top: top,
                    width: widget.widgetSize.width,
                    height: widget.widgetSize.height,
                    child: Transform.scale(
                      scale: zoom.scale,
                      child: widget.imageUrl != null
                          ? CachedNetworkImage(
                        imageUrl: widget.imageUrl!,
                        fit: BoxFit.cover,
                        width: widget.widgetSize.width,
                        height: widget.widgetSize.height,
                      )
                          : widget.child,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}