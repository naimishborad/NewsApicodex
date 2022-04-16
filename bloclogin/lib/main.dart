import 'package:bloclogin/login_bloc.dart';
import 'package:bloclogin/loginpage.dart';
import 'package:bloclogin/register_Bloc.dart';
import 'package:bloclogin/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context)=>LoginBloc()),
        Provider<RegisterBloc>(create: (context)=>RegisterBloc(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: LogInPage()
      ),
    );
  }
}

