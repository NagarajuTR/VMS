import 'package:flutter/material.dart';
import 'package:visitors_management/const/colors_const.dart';

class GradientBackground extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  const GradientBackground({super.key, required this.child, this.colors});

  @override
  State<StatefulWidget> createState() => GradientBackgroundState();
}

class GradientBackgroundState extends State<GradientBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: widget.colors ??
            [ColorsConst.instance.blue, ColorsConst.instance.pink],
      )),
      height: double.infinity,
      width: double.infinity,
      child: widget.child,
    );
  }
}
