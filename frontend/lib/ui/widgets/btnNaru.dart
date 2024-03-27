part of 'widgets.dart';

class BtnNaru extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double border;
  final Color colorText;
  final Color backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const BtnNaru(
      {Key? key,
      required this.text,
      required this.width,
      this.onPressed,
      this.height = 60,
      this.border = 30.0,
      this.colorText = Colors.white,
      this.fontSize = 21,
      this.fontWeight = FontWeight.w400,
      this.backgroundColor = ThemeColors.primary,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border),
            )),
        onPressed: onPressed,
        child: TextCustom(
          text: text,
          color: colorText,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
