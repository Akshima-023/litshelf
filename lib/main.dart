import 'package:flutter/material.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/splash.dart';
import 'package:litshelf/screen/signin%20and%20signup/authprovider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wtatapphrkkgcaykqehb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0YXRhcHBocmtrZ2NheWtxZWhiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzMTUwNTYsImV4cCI6MjA4OTg5MTA1Nn0.-GqFna45m3Gp9aIz2JnVpdoVC-kDlDzTMahQFwNxRKs',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage()
    );
  }
}