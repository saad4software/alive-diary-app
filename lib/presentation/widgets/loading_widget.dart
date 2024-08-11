import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoadingWidget extends HookWidget {

  final Color color;
  const LoadingWidget({
    super.key,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: color, backgroundColor: Colors.transparent,),
      ),
    );
  }
}
