import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/cachehelper.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shopstate.dart';

import 'login.dart';

class Setting extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        if (cubit.settingModel.data != null) {
          name.text = cubit.settingModel.data!.name!;
          email.text = cubit.settingModel.data!.email!;
          phone.text = cubit.settingModel.data!.phone!;
        }
        return cubit.settingModel.data == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              )
            : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is UpdateLoadingState)
                        const LinearProgressIndicator(
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                      newFormField(
                        label: 'name',
                        controller: name,
                        iconData: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newFormField(
                        label: 'email',
                        controller: email,
                        iconData: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      newFormField(
                        label: 'phone',
                        controller: phone,
                        iconData: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.deepOrange,
                        width: double.infinity,
                        child: MaterialButton(
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              CacheHelper.removeData(key: 'token').then((value) {
                                if (value) {
                                  goTo(
                                    context: context,
                                    widget: Login(),
                                  );
                                  cubit.settingModel.data=null;
                                  cubit.getSettingData();
                                }
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.deepOrange,
                        width: double.infinity,
                        child: MaterialButton(
                            child: const Text(
                              'update',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              cubit.updateSettingData(
                                email: email.text,
                                name: name.text,
                                phone: phone.text,
                              );
                            }),
                      )
                    ],
                  ),
                ),
            );
      },
    );
  }
}
