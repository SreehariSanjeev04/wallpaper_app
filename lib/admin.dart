import 'package:flutter/material.dart';
import 'package:project/uploadimage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _hidePassword = false;

  Future<void> _checkCredentials() async {
    if (_emailController.text == 'hello@gmail.com' &&
        _passwordController.text == 'helloworld') {
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('Email', 'hello@gmail.com');
        sharedPreferences.setString('Password', 'helloworld');
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => UploadImage()));
      } catch (e) {
        print('Error navigating to UploadImage screen: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Email/Password'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('Email') != null &&
        sharedPreferences.getString('Password') != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => UploadImage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              color: Colors.white,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 185, 204, 237)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.3,
              left: 20,
              right: 20,
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email address is required";
                          }
                          if (!value.contains('@') ||
                              !value.contains('.')) {
                            return "Invalid email address";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _checkCredentials();
                            setState(() {
                              _emailController.text = '';
                              _passwordController.text = '';
                            });
                          }
                        },
                        child: const Text('Submit'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
