import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorDetailPage extends StatefulWidget {
  final Map<String, dynamic> author;

  const AuthorDetailPage({super.key, required this.author});

  @override
  State<AuthorDetailPage> createState() => _AuthorDetailPageState();
}

class _AuthorDetailPageState extends State<AuthorDetailPage> {
  final supabase = Supabase.instance.client;

  late Future<List<Map<String, dynamic>>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = fetchBooks();
  }

  Future<List<Map<String, dynamic>>> fetchBooks() async {
    final data = await supabase
        .from('books')
        .select()
        .eq('author_id', widget.author['id']);
        print("AUTHOR ID: ${widget.author['id']}");

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.author;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authors"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // IMAGE
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(author['image_url'] ?? ''),
            ),

             SizedBox(height: size.height*0.01),

            const Text("Novelist", style: TextStyle(color: Colors.grey)),

            SizedBox(height: size.height*0.01),

            Text(
              author['name'] ?? '',
              style:AppTextStyles.des20bw
            ),

            SizedBox(height: size.height*0.04),

            // ABOUT
             Align(
              alignment: Alignment.centerLeft,
              child: Text("About",
                  style:AppTextStyles.des20bw),
            ),

             SizedBox(height: size.height*0.02),

            Text(author['description'] ?? '',style: AppTextStyles.text16b,),

            SizedBox(height: size.height*0.02),

            // PRODUCTS
             

            

           
            ],
        ),
      ),
    );
  }
}