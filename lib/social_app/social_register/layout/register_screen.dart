import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Global_uses/reg_exp.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/social_app/social_login/layout/social_login_screen.dart';
import 'package:social_app/social_app/social_register/cubit/register_cubit.dart';
import 'package:social_app/social_app/social_register/cubit/register_states.dart';
class SocialRegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  SocialRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context)=>registerCubit(),
      child: BlocConsumer<registerCubit,registerState>(
          listener: (context, state) {
            if (state is RegisterCreateUserSuccessState) {
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) {
            _validateDate(){
              if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && phoneController.text.isNotEmpty && nameController.text.isNotEmpty){
                registerCubit.get(context).userRegister(email: emailController.text, password: passwordController.text,phone: phoneController.text, name: nameController.text,);

              }else  if(emailController.text.isEmpty && passwordController.text.isEmpty || phoneController.text.isEmpty && nameController.text.isEmpty){
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
              body: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Register now to communicate with friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextForm(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value ) {
                              if(value!.isEmpty) return 'required';
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value ) {
                              if(!emailRegex.hasMatch(value!)) return 'Email Address Not Matching';
                              return null;
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
                            suffix: registerCubit.get(context).suffix,
                            onSubmit: (value) {},
                            isPassword:
                            registerCubit.get(context).password,
                            redEye: () {
                              registerCubit.get(context)
                                  .changeSuffix();
                            },
                            validate: (String? value ) {
                              if(value!.length <6) return 'Password Must have at least 6 characters';
                              return null;                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value ) {
                              if(value!.length <= 10) return 'Phone Number must have at least 11 numbers';
                              return null;                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          state is! registerGetLoadingCircularState?defaultButton(
                            pressed: () {
                              _validateDate();
                              // if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
                              //   registerCubit.get(context).userRegister(
                              //     // name: nameController.text,
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //     // phone: phoneController.text,
                              //   );
                            },
                            text: 'register',
                            isUpperCase: true,
                          ):const Center(child: CircularProgressIndicator()),
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
  }
}