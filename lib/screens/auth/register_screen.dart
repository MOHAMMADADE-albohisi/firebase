import 'package:firebase/firebase/fb_auth_controoler.dart';
import 'package:firebase/models/fb_response.dart';
import 'package:firebase/screens/widget/showSnack.dart';
import 'package:firebase/screens/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class RegesterScreen extends StatefulWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  State<RegesterScreen> createState() => _RegesterScreenState();
}

// ignore: camel_case_types
class _RegesterScreenState extends State<RegesterScreen> with Helpers {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;
  late bool showpasssword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regester'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Required Data',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter info below',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15),
            page_textfilde_widget(
              hint: 'Name',
              showpasssword: false,
              prefixIcon: Icons.person_outlined,
              keporderTybe: TextInputType.name,
              controller: _name,
            ),
            const SizedBox(height: 10),
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
              hint: 'password',
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
              onPressed: () => registerperform(),
              child: Text(
                'Regester',
                style: GoogleFonts.cairo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerperform() async {
    if (_checData()) {
      await _register();
    }
  }

  bool _checData() {
    if (_email.text.isNotEmpty &&
        _name.text.isNotEmpty &&
        _password.text.isNotEmpty) {
      return true;
    }
    ShowSnakBar(context, message: 'Enter Required Data', error: true);
    return false;
  }

  Future<void> _register() async {
    FpResponse fpResponse = await FbAuthController()
        .createAccount(_email.text, _password.text, _name.text);
    if (fpResponse.success) {
      Navigator.pop(context);
    }
    ShowSnakBar(context,
        message: fpResponse.message, error: !fpResponse.success);
  }
}
