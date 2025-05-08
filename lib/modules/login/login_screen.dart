import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/layout/mobile_screen.dart';
import 'package:straydogsadmin/layout/web_screen.dart';
import 'package:straydogsadmin/shared/components/components.dart';
import 'package:straydogsadmin/shared/components/constants.dart';
import 'package:straydogsadmin/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget implements PreferredSizeWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainLoginSuccessState) {
          CacheHelper.saveData(
            key: 'userId',
            value: state.loginModel.userId,
          ).then((value) {
            userId = state.loginModel.userId;
            navigateAndFinish(
              context,
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth <= 600) {
                    return const MobileScreen();
                  }
                  return const WebScreen();
                },
              ),
            );
          });
                }
      },
      builder: (BuildContext context, MainStates state) {
        final size = MediaQuery.of(context).size;
        final cubit = MainCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double cardWidth = constraints.maxWidth * 0.85;
                    if (constraints.maxWidth > 900) {
                      cardWidth = 400;
                    }
                    return Container(
                      width: cardWidth,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color:
                                      cubit.isDark
                                          ? Colors.white.withOpacity(0.2)
                                          : Colors.black.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20.0,
                                    sigmaY: 20.0,
                                  ),
                                  child: TextFormField(
                                    autofillHints: const [AutofillHints.email],
                                    controller: emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Email',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color:
                                      cubit.isDark
                                          ? Colors.white.withOpacity(0.2)
                                          : Colors.black.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20.0,
                                    sigmaY: 20.0,
                                  ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password must not be empty';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    obscuringCharacter: '*',
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainer,
                                  foregroundColor:
                                      cubit.isDark
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Login'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
