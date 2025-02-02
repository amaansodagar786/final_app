import 'package:final_app/components/my_button.dart';
import 'package:final_app/components/my_textfield.dart';
import 'package:final_app/components/square_title.dart';
import 'package:final_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
final Function()? onTap;

  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  Future signUserUp() async{
    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      });

    //try creating user 
    try{
      //check if password is confirmed
      if (passwordController.text.trim() == confirmPasswordController.text.trim()){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
      );
      }else {
        //show error message , password don't match
        showErrorMessage("Password don't match!");
      }

      //pop the loding circle
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }

      
  }

void showErrorMessage(String message){
  showDialog(
    context: context, 
    builder: (context){
    return  AlertDialog(
      backgroundColor: Colors.grey[300],
      title:Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
    },
    );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
      
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
      
                const SizedBox(height: 50),
      
                // welcome back, you've been missed!
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 50),
      
                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
      
                const SizedBox(height: 10),
      
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // Confirm  password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: ' Confirm Password',
                  obscureText: true,
                ),
      
                const SizedBox(height: 10),
      
               
      
                const SizedBox(height: 25),
      
                // sign in button
                MyButton(
                  text: 'Sign Up', 
                  onTap: signUserUp,
                ),
      
                const SizedBox(height: 50),
      
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
      
                const SizedBox(height: 20),
      
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png'),
      
                    SizedBox(width: 25),
      
                    // apple button
                    // SquareTile(
                    //   onTap: () => AuthService().signInWithGoogle(),
                    //   imagePath: 'assets/images/apple.png')
                  ],
                ),
      
                const SizedBox(height: 50),
      
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap:widget.onTap ,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
