import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hasfirebase/view_model/auth_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(6.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: Provider.of<AuthModelView>(context,listen: true).image != null ? FileImage(Provider.of<AuthModelView>(context).image) : null,
            backgroundColor: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    Provider.of<AuthModelView>(context,listen: false).getImage(ImageSource.camera);
                  },
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
                onPressed: ()async => Provider.of<AuthModelView>(context,listen: false)
                    .getImage(ImageSource.gallery),
                icon: Icon(Icons.image_outlined),
                label: Text(
                  "from gallery",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
