import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/authorspage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorsWidget extends StatelessWidget {
  

  AuthorsWidget({
    super.key,
    
  });
  final supabase = Supabase.instance.client;

Future<List<dynamic>> fetchAuthors() async {
  final response = await supabase
      .from('authors')
      .select('name, image');

  return response;
}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
   return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    GestureDetector(onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  AuthorsPage()),
    );
  },
      child: Text(
        "Authors",
        style: AppTextStyles.des18bb,
      ),
    ),
    SizedBox(height: size.height * 0.02),
    SizedBox(
      height: size.height * 0.28, 
      child: FutureBuilder(
        future: fetchAuthors(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final authors = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: authors.length,
            itemBuilder: (context, index) {
              final item = authors[index];
              return Container(
                margin: EdgeInsets.only(right: size.width * 0.08),
                child: Column(
                  children: [                 
                    Container(
                      width: size.width * 0.25,  
                      height: size.width * 0.25,  
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(item['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),               
                    SizedBox(
                      width: size.width * 0.25,
                      child: Text(
                        item['name'],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                       
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    ),
  ],
);}
}