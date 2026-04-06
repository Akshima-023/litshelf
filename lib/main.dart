import 'package:flutter/material.dart';
import 'package:litshelf/screen/onbroading%20and%20splash/splash.dart';
import 'package:litshelf/screen/provider/authorbooksprovider.dart';
import 'package:litshelf/screen/provider/authorsprovider.dart';
import 'package:litshelf/screen/provider/authprovider.dart';
import 'package:litshelf/screen/provider/cartprovider.dart';
import 'package:litshelf/screen/provider/favourite.dart';
import 'package:litshelf/screen/provider/feedbackprovider.dart';
import 'package:litshelf/screen/provider/forgetpasswordprovider.dart';
import 'package:litshelf/screen/provider/homeprovider.dart';
import 'package:litshelf/screen/provider/locationprovider.dart';
import 'package:litshelf/screen/provider/orderprovider.dart';
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
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => AuthorBooksProvider()),
        ChangeNotifierProvider(create: (_) => AuthorsProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider(),),
       ChangeNotifierProvider(create: (_) => FeedbackProvider(),
        ),
         ChangeNotifierProvider(create: (_) => Forgetpasswordprovider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
           ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage()
    );
  }
}