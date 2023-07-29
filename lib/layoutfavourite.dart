import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/favoritedatamodel.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shopstate.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        var cubit=ShopLayoutCubit.get(context);
        return  state is LayoutFavModel1State&&cubit.favDataModel!.data!.data.isEmpty? const Center(child: CircularProgressIndicator(color: Colors.deepOrange,)):ListView.separated
          (itemBuilder: (context, index) => item(cubit.favDataModel!.data!.data[index].products!,context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: cubit.favDataModel!.data!.data.length,
        );
      },
    );
  }
  Widget item(Products model,context)=> Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      height: 100,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 190,
                  child: Image.network('${model.image}'),
                  width: double.infinity,),
                if(model.discount!=0)
                  Container(
                    color: Colors.red,
                    child: const Text(
                      'discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SizedBox(
                  height: 35,
                  child: Padding(
                    padding:  const EdgeInsets.all(3.0),
                    child: Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:  const TextStyle(
                        color: Colors.black,
                        height: 1,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                       Text(
                        '${model.price}',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      if(model.discount!=0)
                         Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopLayoutCubit.get(context).changeFavorite(model.id!);
                          //ShopLayoutCubit.get(context).getFavData;
                        },
                        icon:  CircleAvatar(
                          radius: 15,
                          backgroundColor:ShopLayoutCubit.get(context).productFavorite[model.id]==true? Colors.red:Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
