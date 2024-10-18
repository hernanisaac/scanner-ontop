import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ontop_scanner/screens/qr_reader_screen.dart';

import '../components/error_dialog.dart';
import '../services/storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _code = "";
  String _ci = "";
  bool _isLoading = false;

  Future<void> _login(String code, String ci) async {
    setState(() {
      _isLoading = true;
    });

    // Replace with your actual API endpoint and request body
    final response = await http.post(
      Uri.parse('http://64.23.141.31:4000/activation-code/validate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'activationCode': code,
        'ci': ci,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      // Handle successful login
      final data = jsonDecode(response.body);
      final accessToken = data['accessToken'];
      await saveAccessToken(accessToken);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QrReaderScreen()),
      );
    } else {
      // Handle login failure
      print('Login failed: ${response.statusCode}');
      showErrorDialog(context, 'Error al iniciar sesión. Intente nuevamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Código',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese su código';
                        }
                        return null;
                      },
                      onSaved: (value) => _code = value!,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cédula de identidad',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese su cédula de identidad';
                        }
                        return null;
                      },
                      onSaved: (value) => _ci = value!,
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await _login(_code, _ci);
                          }
                        },
                        child: Text('Iniciar sesión'),
                      ),
                    ),
                  ],
                ),
                if (_isLoading) Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
