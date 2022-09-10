import 'package:firebase/firebase/fb_auth_controoler.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              FbAuthController().singOut();
              Navigator.pushReplacementNamed(context, '/login_screen');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
