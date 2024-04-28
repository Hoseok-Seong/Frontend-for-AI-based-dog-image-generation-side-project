import 'package:flutter/material.dart';
import 'package:puppicasso/components/custom_surfix_icon.dart';
import 'package:puppicasso/components/form_error.dart';
import 'package:puppicasso/constants.dart';
import 'package:dio/dio.dart';
import 'package:puppicasso/screens/sign_up_success/sign_up_success_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirm_password;
  bool remember = false;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<bool> join(String? username, String? password) async {
    Dio dio = Dio();

    final String apiUrl = "http://192.168.84.233:8080/join";
    final Map<String, dynamic> loginData = {
      "username": username,
      "password": password
    };

    try {
      // POST 요청을 보냅니다.
      // Response response = await dio.post(apiUrl, data: loginData);
      //
      // if (response.statusCode == 200) {
      //   // 로그인 성공 처리
      //   print("로그인 성공: ${response.data}");
      //   return true;
      // } else {
      //   // 서버 오류 처리
      //   print("서버 오류: ${response.statusCode}");
      //   return false;
      // }
      return true;
    } on DioException catch (e) {
      // Dio 오류 처리 (요청 실패, 타임아웃 등)
      print("Dio 오류: ${e.message}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kEmailNullError);
                } else if (emailValidatorRegExp.hasMatch(value)) {
                  removeError(error: kInvalidEmailError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kEmailNullError);
                  return "";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  addError(error: kInvalidEmailError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "이메일을 입력해주세요",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => password = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kPassNullError);
                } else if (value.length >= 8) {
                  removeError(error: kShortPassError);
                }
                password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kPassNullError);
                  return "";
                } else if (value.length < 8) {
                  addError(error: kShortPassError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "password",
                hintText: "비밀번호를 입력해주세요",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => confirm_password = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kPassNullError);
                } else if (value.isNotEmpty && password == confirm_password) {
                  removeError(error: kMatchPassError);
                }
                confirm_password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kPassNullError);
                  return "";
                } else if ((password != value)) {
                  addError(error: kMatchPassError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Confirm password",
                hintText: "비밀번호를 다시 입력해주세요",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            ),
            FormError(errors: errors),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    bool joinSuccess = await join(email, password);

                    // 로그인 성공 시 다음 화면으로 이동
                    if (joinSuccess) {
                      Navigator.pushNamed(context, SignUpSuccessScreen.routeName);
                    } else {
                      // 로그인 실패 시 사용자에게 알림, 예를 들면 Snackbar 사용
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("회원가입에 실패하였습니다")),
                      );
                    }
                  }
                },
                child: const Text("Continue")),
          ],
        ));
  }
}
