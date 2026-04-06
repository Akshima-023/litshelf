import 'package:flutter/material.dart';
import 'package:litshelf/screen/provider/authorbooksprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:provider/provider.dart';


class AuthorDetailPage extends StatefulWidget {
  final Map<String, dynamic> author;

  const AuthorDetailPage({super.key, required this.author});

  @override
  State<AuthorDetailPage> createState() => _AuthorDetailPageState();
}

class _AuthorDetailPageState extends State<AuthorDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AuthorBooksProvider>(context, listen: false)
          .fetchBooks(widget.author['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.author;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:  Text("Authors",style: AppTextStyles.des24bb,),
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(author['image_url'] ?? ''),
            ),

            SizedBox(height: size.height * 0.01),

             Text("Novelist", style: AppTextStyles.text16g),

            SizedBox(height: size.height * 0.0),

            Text(
              author['name'] ?? '',
              style: AppTextStyles.des20bw,
            ),

            SizedBox(height: size.height * 0.04),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("About", style: AppTextStyles.des18bb),
            ),

            SizedBox(height: size.height * 0.02),

            Text(
              author['description'] ?? '',
              style: AppTextStyles.text16g,
            ),

            SizedBox(height: size.height * 0.02),

            // BOOKS SECTION
           

            ],
        ),
      ),
    );
  }
}