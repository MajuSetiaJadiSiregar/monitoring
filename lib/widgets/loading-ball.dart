part of 'widgets.dart';

class LoadingBalls extends StatefulWidget {
  final String color;
  const LoadingBalls({Key? key, required this.color}) : super(key: key);


  @override
  _LoadingBallsState createState() =>
      _LoadingBallsState();
}

class _LoadingBallsState extends State<LoadingBalls> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin :0.8, end : 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor(widget.color), // Gunakan HexColor
            ),
          ),
        );
      },
    );
  }
}