import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/cachehelper.dart';
import 'package:shop.png/registercubit.dart';
import 'package:shop.png/registerstate.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/shoplayout.dart';

class Register extends StatelessWidget {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController password=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit,AppRegisterState>(
       listener: (context, state) {
         if (state is RegisterSuccess)
           {
             if(AppRegisterCubit.get(context).loginModel.status)
               {
                 token=AppRegisterCubit.get(context).loginModel.data!.token!;
                 CacheHelper.saveData(
                   key: 'token',
                   value: AppRegisterCubit.get(context).loginModel.data!.token,
                 ).then((value) {

                   toast(
                     state: ToastState.success,
                     message: AppRegisterCubit.get(context).loginModel.message,
                   );
                   goTo(
                     context: context,
                     widget: const ShopLayout(),
                   );
                 });
               }
             else{
               toast(
                 state: ToastState.error,
                 message: AppRegisterCubit.get(context).loginModel.message,
               );
             }
           }
       },
        builder: (context, state) {
         var cubit=AppRegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,

                          ),
                        ),

                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0,bottom: 10),
                        child: Text(
                          'Register now to browse hot offers',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,

                          ),
                        ),

                      ),
                      newFormField(
                        iconData: Icons.person,
                        controller: name,
                        label: 'name',
                      ),
                      const SizedBox(height: 10,),
                      newFormField(
                        iconData: Icons.phone,
                        controller: phone,
                        label: 'phone',
                      ),

                      const SizedBox(height: 10,),
                      newFormField(
                        iconData: Icons.password,
                        controller: password,
                        label: 'password',
                      ),

                      const SizedBox(height: 10,),
                      newFormField(
                        iconData: Icons.email,
                        controller: email,
                        label: 'email',
                      ),

                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.deepOrange,
                          child: MaterialButton(
                            child: state is LoadingRegister?const Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )):const Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.registerPostData(
                                  password: password.text,
                                  email: email.text,
                                  phone: phone.text,
                                  name: name.text,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
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
