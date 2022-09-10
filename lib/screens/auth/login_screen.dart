// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase/firebase/fb_auth_controoler.dart';
import 'package:firebase/models/fb_response.dart';
import 'package:firebase/screens/widget/showSnack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/text_field.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ignore: camel_case_types
class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _email;
  late TextEditingController _password;
  late bool showpasssword = true;
  bool error = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcom Login',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter Email & password',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15),
            page_textfilde_widget(
              hint: 'Email',
              showpasssword: false,
              prefixIcon: Icons.email,
              keporderTybe: TextInputType.emailAddress,
              controller: _email,
            ),
            const SizedBox(height: 10),
            page_textfilde_widget(
              showpasssword: showpasssword,
              hint: 'Password',
              prefixIcon: Icons.lock,
              keporderTybe: TextInputType.text,
              controller: _password,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => showpasssword = !showpasssword);
                },
                icon: const Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () => performlogin(),
              child: Text(
                'Login',
                style: GoogleFonts.cairo(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New Account'),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: const Text('Regester'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void performlogin() {
    if (_checData()) {
      _login();
    }
  }

  bool _checData() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      return true;
    }
    ShowSnakBar(context, message: 'Enter Required Data', error: true);
    return false;
  }

  Future<void> _login() async {
    FpResponse fpResponse =
        await FbAuthController().signIn(_email.text, _password.text);
    if (fpResponse.success) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    ShowSnakBar(context,
        message: fpResponse.message, error: !fpResponse.success);
  }
}
