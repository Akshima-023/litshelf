import 'dart:async';
import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/notification.dart';
import 'package:litshelf/screen/homescreen/search.dart';
import 'package:litshelf/screen/provider/homeprovider.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/author.dart';
import 'package:litshelf/widget/promo.dart';
import 'package:litshelf/widget/topofweek.dart';
import 'package:litshelf/widget/vendors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.fetchBooks();
      provider.fetchPromotion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Search()),
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
                              builder: (_) => NotificationPage()),
                        );
                      },
                      icon: const Icon(Icons.notifications_outlined),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                /// PROMO SECTION
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoadingPromo &&
                        provider.promotionImages.isEmpty) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                        ),
                      );
                    }

                    if (provider.promotionImages.isEmpty) {
                      return const Center(
                        child: Text("No promotions available"),
                      );
                    }

                    /// Use your PromoCarousel (with dots + autoplay inside it)
                    return PromoSection(
                      images: provider.promotionImages,
                    );
                  },
                ),

                SizedBox(height: size.height * 0.03),

                /// TOP OF WEEK
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return TopOfWeekWidget(
                      booksFuture: Future.value(provider.books),
                    );
                  },
                ),

                const SizedBox(height: 20),

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