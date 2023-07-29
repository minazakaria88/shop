import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop.png/register.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shoplayout.dart';
import 'package:shop.png/states.dart';


import 'cachehelper.dart';
import 'cubit.dart';

class Login extends StatelessWidget {
   var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider<AppLoginCubit>(create: (context) => AppLoginCubit(),),
        BlocProvider<ShopLayoutCubit>(create: (context) => ShopLayoutCubit()..getSettingData()..getFavData()..getCatData()..getCatData(),)
      ],
      child: BlocConsumer<AppLoginCubit,AppLoginState>(
       listener: (context, state) {
                if(state is LoginSuccess)
                  {
                    if(AppLoginCubit.get(context).loginModel!.status)
                     {
                       token=AppLoginCubit.get(context).loginModel!.data!.token!;
                       CacheHelper.saveData(
                         key: 'token',
                         value: AppLoginCubit.get(context).loginModel!.data!.token,
                       ).then((value) {
                         toast(
                           message: AppLoginCubit.get(context).loginModel!.message,
                           state: ToastState.success,
                         );
                         goTo(
                           context: context,
                           widget: const ShopLayout(),
                         );
                       });

                     }
                    else
                      {
                        toast(
                          message: AppLoginCubit.get(context).loginModel!.message,
                          state: ToastState.error,
                        );
                      }
                  }
       },
        builder: (context, state) {
         print(state);
         var cubit=AppLoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(height: 50,),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 55,

                          ),
                        ),

                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0,bottom: 10),
                        child: Text(
                          'Login now to browse hot offers',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,

                          ),
                        ),

                      ),

                      newFormField(
                        iconData: Icons.email,
                        controller: cubit.controllerEmail,
                        label: 'Email',
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      newFormField(
                        label: 'password',
                          iconData: Icons.password_sharp,
                          iconData2: cubit.x? Icons.remove_red_eye_outlined:Icons.remove_red_eye,
                          ob: cubit.x,
                          buttonFunction: ()
                          {
                            cubit.changePassword();
                          },
                        controller: cubit.controllerPassword,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.deepOrange,
                          height: 50,
                          child:
                          MaterialButton(
                            child: state is LoadingLogin?const Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            )):const Text('Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            onPressed: ()
                            {
                                  if(formKey.currentState!.validate())
                                    {
                                      cubit.loginPostData(
                                         password: cubit.controllerPassword.text,
                                        email: cubit.controllerEmail.text,
                                      );
                                    }
                            },
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>  Register(),)
                                  );
                                },
                                child:const Text(
                                  'register now',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 23,

                                  ),
                                ),
                              ),
                            ),
                          ],
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
