import 'package:flutter/material.dart' hide Notification;

import 'package:litshelf/screen/homescreen/notification.dart';
import 'package:litshelf/screen/homescreen/search.dart';

import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/author.dart' show AuthorsWidget;

import 'package:litshelf/widget/topofweek.dart';
import 'package:litshelf/widget/vendors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
 final supabase = Supabase.instance.client;

Future<List<dynamic>> fetchBooks() async {
  return await supabase
      .from('book_details')
      .select('id, book_image, book_name');
}

  

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Search()
                    ),
                    );
                      },
                      icon: const Icon(Icons.search_outlined),
                    ),
                    Text("Home", style: AppTextStyles.des18bb),
                    IconButton(
                      onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const Notification()
                    ),
                    );
                   },                     
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),                
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Special Offer"),
                             SizedBox(height:size.height*0.001),
                            const Text("Discount 25%"),
                             SizedBox(height: size.height*0.001),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Order Now"),
                            )
                          ],
                        ),
                      ),
                     
                      
                    ],
                  ),
                ),
               SizedBox(height: size.height * 0.03),
                TopOfWeekWidget( booksFuture: Future.value([])),
               SizedBox(height: size.height * 0.0),                      
             VendorsWidget(),
              SizedBox(height: size.height * 0.02),   
             AuthorsWidget(),
              SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
 }