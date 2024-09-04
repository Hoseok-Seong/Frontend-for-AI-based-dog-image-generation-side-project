import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:puppicasso/apis/ai_image_api.dart';
import 'package:puppicasso/models/ai_image_req.dart';
import 'package:puppicasso/models/ai_image_resp.dart';
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
  File? _image;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pictureCreateViewModelProvider.notifier).fetchData(context);
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
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      value: selectedItem,
      items: items.map((attribute) {
        return DropdownMenuItem<String>(
          value: attribute.value,
          child: Center(child: Text(attribute.name)),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
      style: TextStyle(color: Colors.black),
      iconEnabledColor: Colors.blueAccent,
      dropdownColor: Colors.white,
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
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
                              children: <InlineSpan>[
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
                                  text: _image == null ? '0/1' : '1/1',
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
                        child: _image == null
                            ? Center(
                          child: Text(
                            '사진을 선택해주세요.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                            : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  _image!,
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
                                onTap: removeImage,
                                child: Icon(Icons.close, color: Colors.red, size: 24),
                              ),
                            ),
                          ],
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
                        onPressed: () async {
                          if (_image == null || _selectedBreed == null || _selectedSize == null ||
                              _selectedCoatLength == null || _selectedFurTexture == null ||
                              _selectedEyeColor == null || _selectedEarShape == null ||
                              _selectedNoseShape == null || _selectedFaceShape == null ||
                              _selectedTailShape == null || _selectedExpression == null ||
                              _selectedPose == null || _selectedCoatColor == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("모든 필드를 선택해주세요")),
                            );
                          } else {
                            AIImageReq aiImageReq = AIImageReq(
                              breed: _selectedBreed!,
                              sizeDesc: _selectedSize!,
                              coatLength: _selectedCoatLength!,
                              coatColor: _selectedCoatColor!,
                              furTexture: _selectedFurTexture!,
                              eyeColor: _selectedEyeColor!,
                              earShape: _selectedEarShape!,
                              noseShape: _selectedNoseShape!,
                              faceShape: _selectedFaceShape!,
                              tailShape: _selectedTailShape!,
                              expression: _selectedExpression!,
                              pose: _selectedPose!,
                            );

                            try {
                              AIImageResp response = await AIImageAPI().generateAIImage(context, _image!, aiImageReq);

                              // 응답받은 imageUrl을 다이얼로그로 표시
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('AI 이미지 생성 성공'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.network(response.imageUrl),
                                        Text('이미지 생성에 성공했습니다.'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('닫기'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // 다운로드 로직 추가
                                        },
                                        child: Text('다운로드'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              // 오류 처리
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('오류'),
                                    content: Text('AI 이미지 생성에 실패했습니다.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('닫기'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text("AI 사진 생성하기"),
                      ),
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
