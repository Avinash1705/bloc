import 'package:blocPlants/features/login/bloc/login_bloc.dart';
import 'package:blocPlants/features/login/bloc/login_event.dart';
import 'package:blocPlants/features/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../home/bloc/home_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  late AnimationController _lottieAnimationController;
  bool _idleRunning = true;
  bool isLoading = false;
  late final LoginBloc _loginBloc;


  void _login() {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    // Dummy login logic
    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => isLoading = false);
  //add event 
      _loginBloc.add(LoginRedirectionToHomeEvent());
     
    });
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _lottieAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _playIdleEyes();
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        _playHideEyes();
      } else {
        _playIdleEyes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Builder(builder: (context) => BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (pre,curr) => curr is LoginActionState,
        buildWhen: (pre,curr) => curr is !LoginActionState,
        listener: (context, state) {
          if(state is LoginRedirectionToHomeState){
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeView()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFe0f2f1), Color(0xFFffffff)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          /// 🐍 LOTTIE
                          Hero(
                            tag: "walkingTransition",
                            child: SizedBox(
                              height: 180,
                              child: Lottie.asset(
                                'assets/lottie/Searching.json',
                                controller: _lottieAnimationController,
                                repeat: false,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// TITLE
                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          const SizedBox(height: 28),

                          /// PHONE
                          _buildInputField(
                            controller: phoneController,
                            label: "Mobile Number",
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 16),

                          /// PASSWORD
                          _buildInputField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            label: "Password",
                            icon: Icons.lock,
                            obscureText: true,
                          ),

                          const SizedBox(height: 28),

                          /// LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                elevation: 6,
                                shadowColor: Colors.teal.withOpacity(0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                                  : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          /// FOOTER
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.teal.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ))
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    FocusNode? focusNode,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.teal, width: 1.5),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lottieAnimationController.dispose();
    _idleRunning = false;
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _stopIdleEyes() {
    _idleRunning = false;
    _lottieAnimationController.stop();
  }

  void _playHideEyes() {
    _stopIdleEyes();

    _lottieAnimationController
      ..stop()
      ..value = 0.5; // hide-eyes pose instantly
  }

  Future<void> _playIdleEyes() async {
    _idleRunning = true;

    while (_idleRunning) {
      // 👀 Look left
      _lottieAnimationController
        ..stop()
        ..value = 0.0;

      await _lottieAnimationController.animateTo(
        0.2,
        duration: const Duration(seconds: 2), // 🐢 slow
        curve: Curves.easeOut,
      );

      if (!_idleRunning) break;

      // 👀 Look right
      _lottieAnimationController
        ..stop()
        ..value = 0.6;

      await _lottieAnimationController.animateTo(
        1.0,
        duration: const Duration(seconds: 2), // 🐢 slow
        curve: Curves.easeOut,
      );
    }
  }
}
