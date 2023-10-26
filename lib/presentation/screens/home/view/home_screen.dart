import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _savePermissionStatusToSharedPreferences(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('hasSeenInitialPrompt', value);
}

Future<bool> _loadFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasSeenInitialPrompt') ?? false;
}

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
      print(Permission.photos.isDenied);
      PermissionStatus permissionStatus = await Permission.photos.request();

      if (await _shouldPromptUserForPermission(permissionStatus) == true) {
        _showPermissionErrorDialog();
        return;
      } else {
        final ImagePicker picker = ImagePicker();
        final List<XFile> pickedFileList = await picker.pickMultiImage();
        setState(() {
          _mediaFileList = pickedFileList;
          _savePermissionStatusToSharedPreferences(true);
        });
      }
    }
  }

  Future<bool> _shouldPromptUserForPermission(
      PermissionStatus permissionStatus) async {
    bool isPermissionDenied() =>
        !permissionStatus.isGranted && !permissionStatus.isLimited;
    bool hasSeenInitialPrompt = await _loadFromSharedPreferences();
    print("Is permission denied: ${await isPermissionDenied()}");
    print("Has seen Initial Prompt: $hasSeenInitialPrompt");

    if (await isPermissionDenied() == true && hasSeenInitialPrompt == true) {
      return true;
    } else {
      return false;
    }
  }

  void _showPermissionErrorDialog() {
    Platform.isIOS || Platform.isMacOS
        ? showCupertinoDialog<String>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Alert'),
              content: const Text(
                  'You have not granted permission for this feature to be used.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('Dismiss'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: const Text('Settings'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    AppSettings.openAppSettings();
                  },
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: const Text('Alert'),
                content: const Text(
                    'You have not granted permission for this feature to be used.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Dismiss'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('Settings'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      AppSettings.openAppSettings();
                    },
                  ),
                ]),
          );
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
