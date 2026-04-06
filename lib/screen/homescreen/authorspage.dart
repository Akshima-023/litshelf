import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/authordetailpage.dart';
import 'package:litshelf/screen/provider/authorsprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AuthorsPage extends StatefulWidget {
  const AuthorsPage({super.key});

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AuthorsProvider>(context, listen: false)
          .fetchAuthors();
    });
  }

  Widget buildSkeletonList(Size size) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: const CircleAvatar(radius: 28, backgroundColor: Colors.grey),
            title: Container(
              height: 12,
              width: double.infinity,
              color: Colors.grey,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 10,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authors"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              "Check the authors",
              style: AppTextStyles.text14g,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Authors",
              style: AppTextStyles.text18bg,
            ),
          ),
          SizedBox(height: size.height * 0.02),

          Expanded(
            child: Consumer<AuthorsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return buildSkeletonList(size);
                }

                if (provider.authors.isEmpty) {
                  return const Center(child: Text("No Authors Found"));
                }

                return ListView.builder(
                  itemCount: provider.authors.length,
                  itemBuilder: (context, index) {
                    final author = provider.authors[index];

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
                      trailing:
                          const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AuthorDetailPage(author: author),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}