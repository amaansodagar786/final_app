import 'dart:typed_data';

// import 'package:final_app/pages/cart.dart';
// import 'package:final_app/pages/edit_profile.dart';
// import 'package:final_app/pages/home_page.dart';
// import 'package:final_app/pages/scannercode.dart';
import 'package:final_app/pages/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  final user = FirebaseAuth.instance.currentUser!;

  Future<void>logout()async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }


  Uint8List? _image;


void selectImage()async{
  Uint8List img = await pickImage(ImageSource.gallery); 
  setState(() {
  _image = img;
    
  });
}
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      // backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              
              const SizedBox(height: 40,),
              Stack(
                children: [
                _image != null ? 
                const CircleAvatar(
                  radius: 80,
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
              ),
              const SizedBox(height: 10,),
              RichText(
                text: const TextSpan(text: 'Hey ! ',
                style:TextStyle(
                  color: Colors.cyan,
                  fontSize:27 ,
                  fontWeight: FontWeight.bold,
                ) ,
                children: <TextSpan>[
                  TextSpan(
                    text: 'There ',
                    style:TextStyle(
                  color: Colors.cyan,
                  fontSize:27 ,
                  fontWeight: FontWeight.bold,
                ) ,
                  )
                ],
                ),
                
                ),
              // SizedBox(height: 30,),
              Text   (
                'Email:  '
                + user.email!,
                style:const  TextStyle(
                  color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                ),
                ),
              const SizedBox(height: 10,),
              const Divider(
                thickness: 2,
              ),
              
              
              
              // ignore: prefer_interpolation_to_compose_strings
              
              //  SizedBox(height: 30,),
             const SizedBox(height: 10,),
            //  ListTile(
            //     title:const  Text(
            //         'Edit Profile',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           ),
            //     ),
            //     onTap: () {
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const EditUserProfile()));
            //     },
            //     leading:const Icon(IconlyLight.edit),
            //     trailing:const  Icon(IconlyLight.arrowRightCircle),
            //   ),
               
               ListTile(
                title:const  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ),
                ),
                onTap: () {
                    logout();
                    FirebaseAuth.instance.signOut();
                    signUserOut();
                },
                leading: Icon(IconlyLight.logout),
                trailing: Icon(IconlyLight.arrowRightCircle),
              ),
              // _listTiles(
              //   title: 'Log out',
              //   icon: IconlyBold.activity,
                
              //   onPressed: (){
              //     FirebaseAuth.instance.signOut();
              //   }
              //   ),
                const SizedBox(height: 50),
              
            ],
          ),
        ),
      ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // ignore: prefer_interpolation_to_compose_strings
    //         Text('signed in as:'+ user.email!),
    //         MaterialButton(onPressed: (){
    //           FirebaseAuth.instance.signOut();
    //         },
    //         color: Colors.deepPurple,
    //         child: Text('sign out'),
    //         )
    //       ],
    //       ),
    // )

    );
  }
  // Widget _listTiles ({
  //   required String title ,
  //   required IconData icon ,
  //   // required Function onTap ,
  //   required Function onPressed,
  //    }){
  //   return   ListTile(
  //             title: Text(
  //               title,
  //               style:const  TextStyle(fontSize:20,),
  //               ),
  //               trailing: const Icon(IconlyLight.arrowRight2),
  //               onPressed: (){
  //                 onPressed();
                  
  //               },
  //           );
  // }
}