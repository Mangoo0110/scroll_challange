part of '../home_view.dart';

class _DarazRefreshIndicator extends StatelessWidget {
  const _DarazRefreshIndicator({required this.mode, required this.progress});

  final RefreshIndicatorMode mode;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final bool isRefreshing = mode == RefreshIndicatorMode.refresh;
    final bool isArmed = mode == RefreshIndicatorMode.armed;
    final bgColor = const Color(0xFFF5EEE8);

    String text;
    if (isRefreshing) {
      text = 'Refreshing...';
    } else if (isArmed) {
      text = 'Release to refresh';
    } else {
      text = 'Pull to refresh';
    }

    return Container(
      color: bgColor,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: (progress * 1.25).clamp(0.0, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: isRefreshing
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      isArmed
                          ? Icons.keyboard_double_arrow_down_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF8C8C8C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DarazIndicator extends Decoration {
  const DarazIndicator({
    required this.progress,
    this.color = Colors.orange,
    this.thickness = 3,
    this.horizontalInset = 8,
  });

  final double progress; // 0 => unpinned bubble, 1 => pinned underline
  final Color color;
  final double thickness;
  final double horizontalInset;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DarazIndicatorPainter(this);
  }
}

class _DarazIndicatorPainter extends BoxPainter {
  _DarazIndicatorPainter(this.decoration);
  final DarazIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final size = cfg.size;
    if (size == null) return;

    final p = decoration.progress.clamp(0.0, 1.0);

    final leftX = offset.dx + decoration.horizontalInset;
    final rightX = offset.dx + size.width - decoration.horizontalInset;
    final bottomY = offset.dy + size.height;
    final topY =
        offset.dy + lerpDouble(8, bottomY - 4 - decoration.thickness, p)!;

    // Unpinned bubble shape (with bottom notch-ish edges).
    final notchishIndicatorPath = Path()
      ..addRect(
        Rect.fromPoints(Offset(-10000, bottomY - 8), Offset(10000, bottomY)),
      )
      ..moveTo(leftX - 20, bottomY - 8)
      ..arcToPoint(
        Offset(leftX - 10, bottomY - 16),
        radius: const Radius.circular(16),
        clockwise: false,
      )
      ..lineTo(leftX, topY + 8)
      ..arcToPoint(
        Offset(leftX + 8, topY),
        radius: const Radius.circular(16),
        clockwise: true,
      )
      ..lineTo(rightX - 8, topY)
      ..arcToPoint(
        Offset(rightX, topY + 8),
        radius: const Radius.circular(16),
        clockwise: true,
      )
      ..lineTo(rightX + 10, bottomY - 16)
      ..arcToPoint(
        Offset(rightX + 20, bottomY - 8),
        radius: const Radius.circular(16),
        clockwise: false,
      );

    final bubblePaint = Paint()
      ..color = Colors.white.withValues(alpha: 1.0 - p)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Pinned slim underline.
    final lineY = bottomY - 2;
    final underlinePath = Path()
      ..moveTo(leftX + 2, lineY)
      ..lineTo(rightX - 2, lineY);

    final underlinePaint = Paint()
      ..color = decoration.color.withValues(alpha: p)
      ..style = PaintingStyle.stroke
      ..strokeWidth = lerpDouble(2.0, decoration.thickness, p)!
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    canvas.drawPath(notchishIndicatorPath, bubblePaint);
    canvas.drawPath(underlinePath, underlinePaint);
  }
}

