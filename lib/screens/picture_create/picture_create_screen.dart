import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:puppicasso/screens/picture_download/picture_download_screen.dart';

class PictureCreateScreen extends StatefulWidget {
  static String routeName = "/picture_create";

  const PictureCreateScreen({super.key});

  @override
  _PictureCreateScreenState createState() => _PictureCreateScreenState();
}

class _PictureCreateScreenState extends State<PictureCreateScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  Future<void> pickImage() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  String? _selectedItem;
  final List<String> _items = ['얼굴만 보이게', '전면', '후면', '측면'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <InlineSpan>[
                                TextSpan(
                                  text: '선택한 사진',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 8), // 원하는 간격 크기로 설정
                                ),
                                TextSpan(
                                  text: '8/10',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.8,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 80,
                        child: _images.isEmpty
                            ? Center(
                              child: Text(
                                '사진을 선택해주세요.',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                            : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        _images[index],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () => removeImage(index),
                                      child: Icon(Icons.close, color: Colors.red, size: 24),
                                    ),
                                  ),
                                ],
                              );
                            },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: pickImage,
                        child: Text("사진 선택하기"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "스튜디오 컨셉",
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.8
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedItem,
                        hint: Text('선택해주세요'),
                        items: _items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "분위기",
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.8
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedItem,
                        hint: Text('선택해주세요'),
                        items: _items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "사진 구도",
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.8
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedItem,
                        hint: Text('선택해주세요'),
                        items: _items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pink.shade300),
                        ),
                        onPressed: () {
                          // TODO: 생성하기 버튼이 클릭되었을 때 수행할 작업
                          Navigator.pushNamed(context, PictureDownloadScreen.routeName);
                        },
                        child: Text("AI 사진 생성하기"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
