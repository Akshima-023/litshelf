import 'package:flutter/material.dart' hide Notification;
import 'package:litshelf/screen/homescreen/notification.dart';
import 'package:litshelf/screen/homescreen/search.dart';
import 'package:litshelf/screen/service/api.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/author.dart';
import 'package:litshelf/widget/topofweek.dart';
import 'package:litshelf/widget/vendors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = BookApi.fetchBooks();
  }
  Map<String, String> authorImages = {
  "J.K. Rowling": "https://upload.wikimedia.org/wikipedia/commons/5/5d/J._K._Rowling_2010.jpg",
  "George Orwell": "https://upload.wikimedia.org/wikipedia/commons/c/c3/George_Orwell_press_photo.jpg",
  "Stephen King": "https://upload.wikimedia.org/wikipedia/commons/e/e3/Stephen_King%2C_Comicon.jpg"

};

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
                      Image.network(
                        "https://picsum.photos/100",
                        height: 100,
                      ),
                    ],
                  ),
                ),
               SizedBox(height: size.height * 0.03),
                TopOfWeekWidget(booksFuture: booksFuture),
               SizedBox(height: size.height * 0.03),                      
              const VendorsWidget(),
              SizedBox(height: size.height * 0.02),   
              AuthorsWidget(
              booksFuture: booksFuture,
              authorImages: authorImages,
              ),           
              SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
 }