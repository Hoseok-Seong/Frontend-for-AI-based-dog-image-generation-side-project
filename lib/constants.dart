import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF448AFF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "이메일을 입력해주세요";
const String kInvalidEmailError = "유효한 이메일 형식이 아니에요";
const String kPassNullError = "비밀번호를 입력해주세요";
const String kShortPassError = "비밀번호는 8자 이상으로 해주세요";
const String kMatchPassError = "비밀번호가 틀렸어요";
const String kNameNullError = "이름을 입력해주세요";
const String kPhoneNumberNullError = "핸드폰 번호를 입력해주세요";
const String kAddressNullError = "이메일을 입력해주세요";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}