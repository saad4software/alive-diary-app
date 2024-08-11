import 'package:flutter/material.dart';

class UnderlineTextField extends StatefulWidget {
  const UnderlineTextField({
    required this.style,
    this.controller,
    this.maxLines = 3,
    super.key,
  });

  final TextEditingController? controller;
  final int? maxLines;
  final TextStyle style;

  @override
  State<UnderlineTextField> createState() => _UnderlineTextFieldState();
}

class _UnderlineTextFieldState extends State<UnderlineTextField> {
  double maxWidth = 0;
  int numberOfLines = 1;

  @override
  void initState() {
    /// Calculate numberOfLines
    widget.controller?.addListener(() {
      final text = widget.controller?.text ?? '';
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: widget.style),
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: maxWidth);
      setState(() {
        numberOfLines = textPainter.computeLineMetrics().length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = widget.style.fontSize ?? 12;
    final textHeight = fontSize * (widget.style.height ?? 1);

    return LayoutBuilder(
      builder: (_, constrinat) {
        maxWidth = constrinat.maxWidth;
        return Stack(
          children: [
            TextField(
              style: widget.style,
              controller: widget.controller,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              maxLines: widget.maxLines,
            ),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  numberOfLines,
                      (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: textHeight - 1),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}