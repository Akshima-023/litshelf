import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/vendorsgrid.dart';
import 'package:litshelf/widget/vendorstab.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

class VendorListPage extends StatefulWidget {
  const VendorListPage({super.key});

  @override
  State<VendorListPage> createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  final supabase = Supabase.instance.client;

  List vendors = [];
  bool isLoading = true;

  final tabs = ["All", "Books", "Poems", "Special"];
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    fetchVendors();
  }

  Future<void> fetchVendors() async {
    setState(() => isLoading = true);

    final selectedType = tabs[selectedTab];

    final data = selectedType == "All"
        ? await supabase.from('vendorsitem').select()
        : await supabase
            .from('vendorsitem')
            .select()
            .eq('type', selectedType);

    setState(() {
      vendors = data;
      isLoading = false;
    });
  }

  void onTabChanged(int index) {
    setState(() => selectedTab = index);
    fetchVendors();
  }

  Widget buildSkeletonGrid(Size size) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text("Vendors", style: AppTextStyles.des24bb),
        ),
        actions: [
          const Icon(Icons.search, color: Colors.black),
          SizedBox(width: size.width * 0.07),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VendorTabs(
            tabs: tabs,
            selectedIndex: selectedTab,
            onChanged: onTabChanged,
          ),
          SizedBox(height: size.height * 0.02),

          Expanded(
            child: isLoading
                ? buildSkeletonGrid(size)
                : VendorGrid(vendors: vendors),
          ),
        ],
      ),
    );
  }
}