
import 'package:bloclogin/login_bloc.dart';
import 'package:bloclogin/registerpage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc  = Provider.of<LoginBloc>(context,listen: false);
    return Scaffold(
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
                  Text("LogIn",style: Theme.of(context).textTheme.headlineLarge,),
                  SizedBox(height: 20,),
                  StreamBuilder(
                    stream: bloc.loginEmail,
                    builder: (context,AsyncSnapshot<dynamic> snapshot)=>
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        label: Text("Email"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value)=>bloc.changeEmail,
                    ),
                  ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                    stream: bloc.loginpassword,
                    builder: (context,snapshot)=>
                     TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        label: Text("Password"),
                        errorText: snapshot.error.toString(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value)=>bloc.changePassword,
                    ),
                  ),
                  SizedBox(height: 20,),
                  _buildButton(),
                  SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Need An Account?",style: TextStyle(color: Colors.black)),
                        WidgetSpan(child: SizedBox(width: 2,)),
                        TextSpan(text: "Register",style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()..onTap =(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage()));
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
    final bloc = Provider.of<LoginBloc>(context,listen: false);
    return StreamBuilder<Object>(
      stream: bloc.isValid,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasError || !snapshot.hasData ? null: (){
            bloc.submit();
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color:snapshot.hasError? Colors.grey: Colors.amber,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        );
      }
    );
  }
}