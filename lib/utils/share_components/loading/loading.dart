import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/configs/palette.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.size = 40}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        size: size,
        color: Palette.primary,
      ),
    );
  }
}
