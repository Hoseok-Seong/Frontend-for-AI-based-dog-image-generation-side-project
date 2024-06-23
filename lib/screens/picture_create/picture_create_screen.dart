import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:puppicasso/screens/picture_download/picture_download_screen.dart';
import 'package:puppicasso/viewmodels/picture_create_view_model.dart';
import 'package:puppicasso/models/picture_create_resp.dart';

class PictureCreateScreen extends ConsumerStatefulWidget {
  static String routeName = "/picture_create";

  const PictureCreateScreen({super.key});

  @override
  _PictureCreateScreenState createState() => _PictureCreateScreenState();
}

class _PictureCreateScreenState extends ConsumerState<PictureCreateScreen> {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pictureCreateViewModelProvider.notifier).fetchData();
    });
  }

  String? _selectedBreed;
  String? _selectedSize;
  String? _selectedCoatLength;
  String? _selectedFurTexture;
  String? _selectedEyeColor;
  String? _selectedEarShape;
  String? _selectedNoseShape;
  String? _selectedFaceShape;
  String? _selectedTailShape;
  String? _selectedExpression;
  String? _selectedPose;
  String? _selectedCoatColor;

  Widget buildDropdown(String label, List<Attribute> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: selectedItem,
      items: items.map((attribute) {
        return DropdownMenuItem<String>(
          value: attribute.value,
          child: Center(child: Text(attribute.name)),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true, // Dropdown을 더 넓게 만들어줍니다.
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pictureCreateViewModelProvider);

    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    }

    final attributes = state.data;

    if (attributes == null) {
      return Center(child: Text('No data available'));
    }

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
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 8), // 원하는 간격 크기로 설정
                                ),
                                TextSpan(
                                  text: '0/1',
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
                      buildDropdown('견종', attributes.breeds, _selectedBreed, (value) {
                        setState(() {
                          _selectedBreed = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('크기', attributes.sizes, _selectedSize, (value) {
                        setState(() {
                          _selectedSize = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('털 길이', attributes.coatLengths, _selectedCoatLength, (value) {
                        setState(() {
                          _selectedCoatLength = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('털 텍스처', attributes.furTextures, _selectedFurTexture, (value) {
                        setState(() {
                          _selectedFurTexture = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('눈 색깔', attributes.eyeColors, _selectedEyeColor, (value) {
                        setState(() {
                          _selectedEyeColor = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('귀 모양', attributes.earShapes, _selectedEarShape, (value) {
                        setState(() {
                          _selectedEarShape = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('코 모양', attributes.noseShapes, _selectedNoseShape, (value) {
                        setState(() {
                          _selectedNoseShape = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('얼굴 모양', attributes.faceShapes, _selectedFaceShape, (value) {
                        setState(() {
                          _selectedFaceShape = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('꼬리 모양', attributes.tailShapes, _selectedTailShape, (value) {
                        setState(() {
                          _selectedTailShape = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('표정', attributes.expressions, _selectedExpression, (value) {
                        setState(() {
                          _selectedExpression = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('자세', attributes.poses, _selectedPose, (value) {
                        setState(() {
                          _selectedPose = value;
                        });
                      }),
                      const SizedBox(height: 10),
                      buildDropdown('털 색깔', attributes.coatColors, _selectedCoatColor, (value) {
                        setState(() {
                          _selectedCoatColor = value;
                        });
                      }),
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
        ),
      ),
    );
  }
}
