import 'package:bloclogin/loginpage.dart';
import 'package:bloclogin/register_Bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    final bloc = Provider.of<RegisterBloc>(context,listen: false);
    GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return  Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Registration",style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: 20,),
                  StreamBuilder(
                    stream: bloc.name,
                    builder: (context,snapshot)=>
                     TextField(
                      decoration: InputDecoration(
                        hintText: "Enter name",
                        label: Text("name"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value)=>bloc.ChangeName,
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: bloc.email,
                    builder: (context,snapshot)=>
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        label: Text("Email"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value)=>bloc.ChangeEmail,
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: bloc.phonenumber,
                    builder: (context,snapshot)=>
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Phone number",
                        label: Text("phone number"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: bloc.ChangePhone,
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: bloc.password,
                    builder: (context,snapshot)=>
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        label: Text("Password"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        
                      ),
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (context)=>bloc.ChangePassword,
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: bloc.confirmpassword,
                    builder: (context,snapshot)=>
                     TextField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        label: Text("Confirm Password"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        
                      ),
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value)=>bloc.ChangeConfirmPassword,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 20,),
                  _buildButton(),
                  SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Already have an Account?",style: TextStyle(color: Colors.black)),
                        WidgetSpan(child: SizedBox(width: 2,)),
                        TextSpan(text: "Login",style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer(
                        )..onTap = (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogInPage()));
                        }
                        )
                      ]
                    ),
                  ),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildButton(){
    final bloc = Provider.of<RegisterBloc>(context,listen: false);
    return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap:snapshot.hasError?null: (){},
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: snapshot.hasError? Colors.grey: Colors.amber,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        );
      }
    );
  }
}