import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart'; // For mobile/desktop
import 'package:shared_preferences/shared_preferences.dart'; // For web
import 'package:gbook/home_page.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  if (kIsWeb) {
    
    // ignore: unused_local_variable
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    
  } else {
    
    await Hive.initFlutter();
   
  }

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Reader App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(), 
    );
  }
}
