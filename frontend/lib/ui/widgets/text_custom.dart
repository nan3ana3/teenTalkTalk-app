part of 'widgets.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isTitle;
  final FontWeight fontWeight;
  final Color color;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final double? letterSpacing;
  final double? height;
  final TextDecoration decoration;

  const TextCustom(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.maxLines = 1,
      this.overflow = TextOverflow.visible,
      this.textAlign = TextAlign.left,
      this.letterSpacing,
      this.isTitle = false,
      this.height,
      this.decoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: 'NanumSquareRound',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    ).copyWith(
      decorationThickness: 2.0,
      decorationColor: Colors.red,
    );

    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
