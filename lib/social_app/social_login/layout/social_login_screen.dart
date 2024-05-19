import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/shared/remote/local/cache_helper.dart';
import 'package:social_app/social_app/social_lauout/feeds_screen.dart';
import 'package:social_app/social_app/social_lauout/social_layout.dart';
import 'package:social_app/social_app/social_login/shared/cubit/LoginCubit.dart';
import 'package:social_app/social_app/social_login/shared/cubit/loginStates.dart';
import 'package:social_app/social_app/social_register/layout/register_screen.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, loginState>(
        listener: (context, state) {
          if (state is socialGetLoginErrorState) {
            print(state.error);
          }
          if(state is socialGetLoginState)
          {
            uId = CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            );

          }
        },
        builder: (context, state) {
          _validateDate(){
            if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
              LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);

            }else  if(emailController.text.isEmpty || passwordController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:Text('All fields are required',maxLines:1,
                  overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
                behavior:SnackBarBehavior.floating,
                backgroundColor:Color(0xFF801336),
              ));
              const Icon(Icons.info_outline,size: 16,);
            }
          }
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value ) {
                            if( value == null || value.trim()!.isEmpty) return 'required';
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextForm(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: LoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: LoginCubit.get(context).password,

                          validate: (String? value ) {
                            if(value!.isEmpty) return 'required';
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                          state is! socialGetLoginCircularState? defaultButton(
                            pressed: () {
                              _validateDate();
                              // if (formKey.currentState!.validate()) {
                              //   LoginCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //   );

                            },
                            text: 'login'.toUpperCase(),
                          ):const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            MaterialButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child:Text( 'register'.toUpperCase()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }}