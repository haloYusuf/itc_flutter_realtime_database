import 'package:flutter/material.dart';
import 'package:itc_firebase/model/user_model.dart';
import 'package:itc_firebase/page/register_page.dart';
import 'package:itc_firebase/services/login_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _visiblePass = true;
  UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState warning = ScaffoldMessenger.of(context);
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
                'Login Menu',
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
                  }
                  user.pass = value;
                  return null;
                },
                obscureText: _visiblePass,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (await LoginServices.loginUser(user)) {
                            warning.showSnackBar(
                              const SnackBar(content: Text('Data diterima!')),
                            );
                          } else {
                            warning.showSnackBar(
                              const SnackBar(content: Text('Data ditolak!')),
                            );
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
