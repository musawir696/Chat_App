

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  const UserImagePicker({super.key,required this.onPickImage,});
  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File ? _pickImageFile;
  void _pickImage() async
  {

   final pickedimage=await ImagePicker().pickImage(


     source: ImageSource.camera,
     imageQuality: 50,
     maxWidth: 150,



   );

    if(pickedimage==null)
      {
        return;
      }
     setState(() {
       _pickImageFile=File(pickedimage.path);
     });

      widget.onPickImage(_pickImageFile!);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
          _pickImageFile!=null ?FileImage(_pickImageFile!):null,


        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),

          ),

        ),


      ],

    );
  }
}

