part of 'widgets.dart';

class TextFieldNaru extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final double fontSize;
  final FocusNode? focusNode;
  // final bool enableInteractiveSelection; // 텍스트 선택 및 편집 활성화 여부

  const TextFieldNaru({
    Key? key,
    required this.controller,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.errorText,
    this.fontSize = 18,
    this.focusNode,
    // this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // readOnly: true,
      focusNode: focusNode,
      style: TextStyle(
        fontFamily: 'NanumSquareRound',
        fontSize: fontSize,
      ),
      // style: GoogleFonts.getFont('Roboto', fontSize: 18),
      cursorColor: ThemeColors.secondary,
      obscureText: isPassword,
      keyboardType: keyboardType,
      // enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primary),
        ),
        hintText: hintText,
        errorText: errorText,
      ),
      validator: validator,
    );
  }
}
