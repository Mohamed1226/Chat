import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) pickedFn;

  UserImagePicker(this.pickedFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final ImagePicker picker = ImagePicker();

  void _getImage(ImageSource src) async {
   // PermissionStatus permissionResult =
     //   await SimplePermissions.requestPermission(
       //     Permission.WriteExternalStorage);
   // if (permissionResult == PermissionStatus.authorized) {
      // code of read or write file in external storage (SD card)
      final pickedFile = await picker.getImage(
          source: src, imageQuality: 80, maxWidth: 200, maxHeight: 200);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        widget.pickedFn(_image);
      } else {
        print('No image selected.');
      }
   // } else {
     // Toast.show(
       //   src == ImageSource.gallery
         //     ? "please give permission for gallery"
           //   : "please give permission for camera",
          //cxt,
         // duration: 4);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: _image != null ? FileImage(_image) : null,
            backgroundColor: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: Icon(Icons.photo_camera_outlined),
                  label: Text(
                    " from camera",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                  )),
              SizedBox(
                width: 10.0,
              ),
              FlatButton.icon(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: Icon(Icons.image_outlined),
                  label: Text(
                    "from gallery",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                    softWrap: false,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
