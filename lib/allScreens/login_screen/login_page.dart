import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/allProvider/auth_provider.dart';
import 'package:untitled9/allScreens/home_screen/home_page.dart';
import 'package:untitled9/allScreens/reg_screen/reg_page.dart';
import 'package:untitled9/splash_page/splash_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvder=Provider.of<AuthProvider>(context);
    final emailField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return ("Enter Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Enter Valid Email");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.alternate_email_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
      ),
    );
    final passwordField = TextFormField(
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6}$');
        if (value!.isEmpty) {
          return ('Enter PassWord');
        }
        if (!regExp.hasMatch(value)) {
          return ('Enter min 6 character');
        }
      },
      autofocus: false,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "password",
      ),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Pattern Success.png"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    emailField,
                    SizedBox(
                      height: 45,
                    ),
                    passwordField,
                    SizedBox(
                      height: 45,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have account"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                            },
                            child: Text("sign up"))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "LogIn with",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: ()async {
                          bool isSuccess=await authProvder.handleSignIn();
                          if(isSuccess){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/google-icon.svg",
                          height: 50,
                          width: 50,
                        ),),
                    Positioned(child: authProvder.status==Status.authenticating?HomePage():SizedBox.shrink())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "Login Success"),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()))
              }).catchError((e){
                Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
