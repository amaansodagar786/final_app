import 'dart:typed_data';

import 'package:final_app/pages/home_page.dart';
// import 'package:final_app/pages/users.dart';
import 'package:final_app/pages/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {

Uint8List? _image;


void selectImage()async{
  Uint8List img = await pickImage(ImageSource.gallery); 
  setState(() {
  _image = img;
    
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          },
        ),
        title: const Text('Edit User Profile'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _image != null ? 
              const CircleAvatar(
                radius: 65,
                // backgroundColor:,
              )
              :
               const CircleAvatar (
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'),
              ),
              Positioned(
                  child:IconButton(
                      onPressed:selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      ),
                      bottom: -10,
                      left: 80,
                      )
            ],
          )
        ],
      ),
    );
  }
}
