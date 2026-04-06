import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:litshelf/screen/provider/homeprovider.dart';

class PromoSection extends StatefulWidget {
  const PromoSection({super.key, required List<String> images});

  @override
  State<PromoSection> createState() => _PromoSectionState();
}

class _PromoSectionState extends State<PromoSection> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    /// Auto scroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final provider = Provider.of<HomeProvider>(context, listen: false);

      if (provider.promotionImages.isNotEmpty) {
        currentPage++;

        if (currentPage >= provider.promotionImages.length) {
          currentPage = 0;
        }

        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<HomeProvider>(
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

        return Column(
          children: [
            /// IMAGE CAROUSEL
            SizedBox(
              height: size.height * 0.2,
              child: PageView.builder(
                controller: _pageController,
                itemCount: provider.promotionImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      provider.promotionImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                provider.promotionImages.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 10 : 6,
                    height: currentPage == index ? 10 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index
                          ? Colors.purple
                          : Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}