import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickers extends ChangeNotifier{
    File image;
    bool isSelected = false;
    File file;


    UploadAudio() async{
    FilePickerResult result = await FilePicker.platform.pickFiles();
if(result != null) {
   file = File(result.files.single.path);
}
   notifyListeners();
     }


    UploadImage() async{
    FilePickerResult result = await FilePicker.platform.pickFiles();
if(result != null) {
   image = File(result.files.single.path);
}
   notifyListeners();
}
}