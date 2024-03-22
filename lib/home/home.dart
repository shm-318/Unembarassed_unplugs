import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unembarassing_unplugs_macos/home/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: _buildHomeBody(),
    );
  }

  AppBar _buildHomeAppBar() {
    return AppBar(
      title: const Text(
          "No more getting embarrassed by accidental headphone unplugs :))"),
    );
  }

  _buildHomeBody() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                    "Current Headphone Status: ${provider.status}"))
          ],
        );
      },
    );
  }
}
