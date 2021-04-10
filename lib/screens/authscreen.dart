import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/providers/providergooglesigin.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final username = FocusNode();
  final password = FocusNode();
  var __isLoading = false;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = "test@test.com";
  String _username = "tester23";
  String _userPassword = "tester23";
  // File _userImageFile;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.yellow, Colors.white]),
        ),
        child: Center(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(20.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
              height: !_isLogin ? 500 : 300,
              constraints: BoxConstraints(
                minHeight: !_isLogin ? 500 : 300,
              ),
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // if (!_isLogin)
                      //   FadeTransition(
                      //     opacity: _opacityAnimation,
                      //     child: SlideTransition(
                      //       position: _slideAnimation,
                      //       child: UserImagePicker(_pickImage),
                      //     ),
                      //   ),
                      TextFormField(
                        key: ValueKey("email"),
                        onSaved: (newValue) => _userEmail = newValue!,
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              !value.toString().contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        initialValue: _userEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => _isLogin
                            ? FocusScope.of(context).requestFocus(password)
                            : FocusScope.of(context).requestFocus(username),
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        constraints: BoxConstraints(
                          maxHeight: !_isLogin ? 120 : 0,
                          minHeight: !_isLogin ? 60 : 0,
                        ),
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: TextFormField(
                              initialValue: _username,
                              key: ValueKey("username"),
                              onSaved: (newValue) => _username = newValue!,
                              validator: (value) {
                                if (!_isLogin &&
                                    (value.toString().isEmpty ||
                                        value.toString().length < 8)) {
                                  return "username must be at least 8 characters";
                                }
                                return null;
                              },
                              focusNode: username,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context).requestFocus(password),
                              decoration:
                                  InputDecoration(labelText: "Username"),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _userPassword,
                        key: ValueKey("password"),
                        onSaved: (newValue) => _userPassword = newValue!,
                        validator: (value) {
                          if (value.toString().isEmpty ||
                              value.toString().length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                        focusNode: password,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (__isLoading)
                        CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      if (!__isLoading)
                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              if (_formKey.currentState!.validate())
                                _formKey.currentState!.save();
                              _submitAuthForm(
                                  _userEmail.trim(),
                                  _userPassword.trim(),
                                  _username.trim(),
                                  _isLogin,
                                  context);
                            },
                            child: Text(_isLogin ? "Login" : "Sign Up")),
                      if (!__isLoading)
                        RaisedButton.icon(
                          onPressed: () {
                            var googleprovider =
                                Provider.of<ProviderGoogleSignin>(context,
                                    listen: false);
                            googleprovider.login();
                          },
                          shape: StadiumBorder(),
                          label: Text("Login with google"),
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                        ),
                      if (!__isLoading)
                        FlatButton(
                          child: Text(_isLogin
                              ? "Create new account"
                              : "Already have an account"),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _switchAuthMode,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _switchAuthMode() {
    if (_isLogin) {
      setState(() {
        _isLogin = false;
      });
      _controller.forward();
    } else {
      setState(() {
        _isLogin = true;
      });
      _controller.reverse();
    }
  }

  void _submitAuthForm(
    String email,
    String password,
    String username,
    // File userimagefile,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authresult;
    try {
      setState(() {
        __isLoading = true;
      });
      if (isLogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on Exception catch (_) {
      var message = "An error occrred. Check your cred";

      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        __isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        __isLoading = false;
      });
    }
  }
}
