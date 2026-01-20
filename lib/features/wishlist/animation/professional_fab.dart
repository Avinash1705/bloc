import 'package:flutter/material.dart';

class ProfessionalFab extends StatefulWidget {
  final VoidCallback onPressed;

  const ProfessionalFab({
    super.key,
    required this.onPressed,
  });

  @override
  State<ProfessionalFab> createState() => _ProfessionalFabState();
}

class _ProfessionalFabState extends State<ProfessionalFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 120),
    );

    _scale = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _controller.forward();
    await _controller.reverse();

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FloatingActionButton(
        backgroundColor: Colors.teal,
        elevation: 6,
        highlightElevation: 2,
        onPressed: _handleTap,
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}
