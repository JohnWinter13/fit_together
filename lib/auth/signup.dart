import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/auth/login.dart';
import 'package:flutter/material.dart';


class Signup extends StatefulWidget{
  @override
  State createState() => new SignupState();
}

class SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign up"),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: new Form(key: _formKey, child:       new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            new Text("Create your account.",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),
            new Padding(
            padding: const EdgeInsets.all(20), 
            child: new TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Email field is empty';
                }
              },             
              decoration: new InputDecoration(labelText: "Enter Email", filled: true),
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              onSaved: (input) => _email = input,
            ),),
            new Padding(
            padding: const EdgeInsets.all(20), 
            child: new TextFormField(
              validator: (input) {
                if(input.length < 8){
                  return 'Your password must be at least 8 digits long.';
                }
              },
              decoration: new InputDecoration(labelText: "Enter Password", filled: true),
              autofocus: true,
              obscureText: true,
              onSaved: (input) => _password = input,
              keyboardType: TextInputType.text,
            ),),
            new MaterialButton(
              height: 40,
              minWidth: 180,
              color: Colors.blue,
              splashColor: Colors.white,
              textColor: Colors.white,
              child: new Text('Sign up'),
              onPressed: signUp,
              ),
          ],)
        ],
      ),)
    );
  }

void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
