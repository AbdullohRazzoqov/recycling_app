import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class WMainButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final TextStyle styles;
  const WMainButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.buttonColor,
      this.isLoading = false,
      this.padding =
          const EdgeInsets.only(top: 5, bottom: 10, left: 16, right: 16),
      this.borderRadius = 20,
      this.margin,
      this.styles = const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: 'Nunito')})
      : super(key: key);

  @override
  _WMainButtonState createState() => _WMainButtonState();
}

class _WMainButtonState extends State<WMainButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {});
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {});
    _controller.reverse();
    if (!widget.isLoading) {
      widget.onPressed();
    }
  }

  void _onTapCancel() {
    setState(() {});
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: widget.margin,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  splashColor: AppColors.white,
                  highlightColor: AppColors.white,
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  child: Padding(
                    padding: widget.padding,
                    child: widget.isLoading
                        ? SizedBox(
                            height: 52,
                            child: Center(
                              child: Transform.scale(
                                scale: .9,
                                child: const CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 4,
                                ),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.text, style: widget.styles),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
