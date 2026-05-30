import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'initial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      userController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    setState(() {
      isLoading = true;
    });

    try {

      final success =
          await AuthService.instance.login(
        username: userController.text,
        password: passwordController.text,
      );

      if (!mounted) return;

      if (success) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const InitialScreen(),
          ),
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Usuário ou senha inválidos',
            ),
          ),
        );
      }

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Erro na conexão'),
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E1B4B),
              Color(0xFF312E81),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            child: Padding(
              padding:
                  const EdgeInsets.all(24),

              child: Container(

                padding:
                    const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  color: Colors.white
                      // ignore: deprecated_member_use
                      .withOpacity(0.08),

                  borderRadius:
                      BorderRadius.circular(24),

                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),

                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    Icon(
                      Icons.shopping_bag,
                      size: 80,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'USEDEV',

                      style:
                          GoogleFonts.orbitron(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Faça login para continuar',

                      style:
                          GoogleFonts.poppins(
                        color:
                            Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextField(
                      controller:
                          userController,

                      style: const TextStyle(
                        color: Colors.white,
                      ),

                      decoration:
                          InputDecoration(

                        hintText: 'Usuário',

                        hintStyle:
                            const TextStyle(
                          color:
                              Colors.white54,
                        ),

                        prefixIcon:
                            const Icon(
                          Icons.person,
                          color:
                              Colors.white70,
                        ),

                        filled: true,

                        fillColor:
                            Colors.white10,

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(16),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          passwordController,

                      obscureText: true,

                      style: const TextStyle(
                        color: Colors.white,
                      ),

                      decoration:
                          InputDecoration(

                        hintText: 'Senha',

                        hintStyle:
                            const TextStyle(
                          color:
                              Colors.white54,
                        ),

                        prefixIcon:
                            const Icon(
                          Icons.lock,
                          color:
                              Colors.white70,
                        ),

                        filled: true,

                        fillColor:
                            Colors.white10,

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(16),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : SizedBox(

                            width:
                                double.infinity,

                            height: 55,

                            child: ElevatedButton(

                              onPressed:
                                  login,

                              style:
                                  ElevatedButton
                                      .styleFrom(

                                backgroundColor:
                                    Colors.white,

                                foregroundColor:
                                    Colors.deepPurple,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              16),
                                ),
                              ),

                              child: Text(
                                'ENTRAR',

                                style:
                                    GoogleFonts
                                        .orbitron(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
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
  }
}