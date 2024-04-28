import 'package:flutter/material.dart';
import 'package:puppicasso/screens/forgot_password/forgot_password_screen.dart';
import 'package:puppicasso/screens/init_screen.dart';
import 'package:dio/dio.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
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

  Future<bool> login(String? username, String? password) async {
    Dio dio = Dio();

    final String apiUrl = "http://192.168.84.233:8080/login";
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
              hintText: "이메일을 입력해요",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
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
              return;
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
              labelText: "Password",
              hintText: "비밀번호를 입력해요",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("아이디 기억하기"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "비밀번호찾기",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);

                // login 함수 호출, 여기서 username과 password는 로그인에 필요한 사용자 입력값입니다.
                bool loginSuccess = await login(email, password);

                // 로그인 성공 시 다음 화면으로 이동
                if (loginSuccess) {
                  Navigator.pushNamed(context, InitScreen.routeName);
                } else {
                  // 로그인 실패 시 사용자에게 알림, 예를 들면 Snackbar 사용
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("존재하지 않는 아이디입니다")),
                  );
                }
              }
            },
            child: const Text("계속하기"),
          ),
        ],
      ),
    );
  }
}