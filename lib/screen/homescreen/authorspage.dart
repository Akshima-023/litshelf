import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/authordetailpage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  final supabase = Supabase.instance.client;

  late Future<List<Map<String, dynamic>>> authorpageFuture;

  @override
  void initState() {
    super.initState();
    authorpageFuture = fetchAuthorpage();
  }

  Future<List<Map<String, dynamic>>> fetchAuthorpage() async {
    try {
      final data = await supabase
          .from('authorpage')
          .select()
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print("ERROR: $e");
      return [];
    }
  }

  @override
Widget build(BuildContext context) {
   final Size size = MediaQuery.of(context).size;
  return Scaffold(
    appBar: AppBar(
      title: const Text("Authors"),
      centerTitle: true,

      // 🔍 SEARCH ICON
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
          
          },
        ),
      ],
    ),

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        
         Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            "Check the authors",
            style: AppTextStyles.text14g
          ),
        ),

        // 🔹 "Authors" heading
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Authors",
            style: AppTextStyles.text18bg
          ),
        ),

         SizedBox(height: size.height*0.02),

        // 🔥 LIST FROM SUPABASE
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: authorpageFuture,
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final authors = snapshot.data ?? [];

              if (authors.isEmpty) {
                return const Center(child: Text("No Authors Found"));
              }

              return ListView.builder(
  itemCount: authors.length,
  itemBuilder: (context, index) {
    final author = authors[index];

    return ListTile(
      contentPadding: const EdgeInsets.all(12),

      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(
          author['image_url'] ?? '',
        ),
      ),

      title: Text(author['name'] ?? ''),

      subtitle: Text(
        author['description'] ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  },
);},
          ),
        ),
      ],
    ),
  );
}}