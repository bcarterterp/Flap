import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<XFile>? _mediaFileList;

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      final ImagePicker _picker = ImagePicker();

      final List<XFile> pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _mediaFileList = pickedFileList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page Screen'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _mediaFileList != null && _mediaFileList!.isNotEmpty
                  ? ImageDisplayWidget(imageFile: _mediaFileList!.first)
                  : Container(),
              Semantics(
                label: 'image_picker_example_from_gallery',
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery,
                        context: context);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo),
                ),
              ),
            ]),
      ),
    );
  }
}

class ImageDisplayWidget extends StatelessWidget {
  final XFile imageFile;

  ImageDisplayWidget({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200, height: 200, child: Image.file(File(imageFile.path)));
  }
}
