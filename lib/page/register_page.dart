import 'package:flutter/material.dart';
import 'package:itc_firebase/model/user_model.dart';
import 'package:itc_firebase/page/login_page.dart';
import 'package:itc_firebase/services/login_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _visiblePass = true;
  UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    var warning = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register Menu',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!value.contains('@')) {
                    return 'Email is incorrect';
                  }
                  user.name = value;
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: InkWell(
                    child: Icon(
                        _visiblePass ? Icons.visibility : Icons.visibility_off),
                    onTap: () {
                      _visiblePass = !_visiblePass;
                      setState(() {});
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (value.length < 8) {
                    return 'the password must be at least 8 characters long';
                  }
                  user.pass = value;
                  return null;
                },
                obscureText: _visiblePass,
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!await LoginServices.checkEmail(user)) {
                        LoginServices.register(user);
                        warning.showSnackBar(
                          const SnackBar(content: Text('Data telah dibuat!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
                      } else {
                        warning.showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Email sudah ada dalam server, gunakan email lain!')),
                        );
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
