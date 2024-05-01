import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:puppicasso/screens/sign_in/sign_in_screen.dart';
import 'package:puppicasso/screens/main/main_screen.dart';
import 'package:puppicasso/screens/picture_download/picture_download_screen.dart';

class PictureCreateScreen extends StatefulWidget {
  static String routeName = "/picture_create";

  const PictureCreateScreen({super.key});

  @override
  _PictureCreateScreenState createState() => _PictureCreateScreenState();
}

class _PictureCreateScreenState extends State<PictureCreateScreen> {
  XFile? _image; // 선택한 이미지를 저장하는 변수

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery); // 이미지 피커로부터 이미지 선택

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const Text(
                "Puppicasso",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Puppicasso, 내 반려견만을 위한 AI 프로필",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                width: 250.0, // 컨테이너의 너비 설정
                height: 250.0, // 컨테이너의 높이 설정
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 컨테이너를 원형으로 만듦
                  color: Colors.grey[200], // 기본 배경색 설정
                ),
                child: _image == null
                    ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.photo, size: 50.0, color: Colors.grey), // 기본 아이콘
                      Text('이미지를 선택해주세요.', textAlign: TextAlign.center),
                    ],
                ) : ClipOval(
                  child: Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 조정
                    width: 250.0, // 이미지의 너비 설정
                    height: 250.0, // 이미지의 높이 설정
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: getImage,
                child: Text('사진 선택하기'),
              ),
              const SizedBox(height: 16),
              // TODO: 이미지 설정 옵션 추가
              ElevatedButton(
                onPressed: () {
                  // TODO: 생성하기 버튼이 클릭되었을 때 수행할 작업
                  Navigator.pushNamed(context, PictureDownloadScreen.routeName);
                },
                child: Text('프로필 사진 생성하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
