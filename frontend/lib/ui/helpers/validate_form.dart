import 'package:form_field_validator/form_field_validator.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: '*이메일을 입력해주세요.'),
  EmailValidator(errorText: '*유효한 이메일을 입력하세요.')
]);

final passwordValidator =
    MultiValidator([MinLengthValidator(8, errorText: '8자 이상 입력해주세요.')]);

// final againpasswordValidator = MultiValidator([
//   RequiredValidator(errorText: '비밀번호가 일치하지 않습니다.'),
// ]);
