import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/catmodel.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shopstate.dart';

class CatLayout extends   StatelessWidget {
  const CatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopLayoutCubit.get(context);
        return cubit.model!=null? ListView.separated(
            itemBuilder: (context, index) => item(ShopLayoutCubit.get(context).model!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount:ShopLayoutCubit.get(context).model!.data!.data.length
        ):const Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget item(DataModel model)=>Row(
    children: [
      SizedBox(
          width: 100,
          height: 100,
          child: Image.network('${model.image}')),
      const SizedBox(
        width: 15,
      ),

       Text('${model.name}',
        style: const TextStyle(
          fontSize: 25,

          color: Colors.black,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 25,

      ),
    ],
  );
}
