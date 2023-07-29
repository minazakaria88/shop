import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/catmodel.dart';
import 'package:shop.png/homelayoutmodel.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shopstate.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutState>(
        listener: (context, state) {
        },
      builder: (context, state) {
        var cubit=ShopLayoutCubit.get(context);
       return cubit.homeLayoutModel==null ? const
          Center(child: CircularProgressIndicator(color: Colors.orange,)):myItem(cubit.homeLayoutModel!,context);
      },
    );
  }
  Widget myItem(HomeLayoutModel model,context)=>SingleChildScrollView(
    child: Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          CarouselSlider(
              items: model.data.banners.map((e) {
              return     Image(
                  image: NetworkImage(e.image!)
                  ,width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Categories',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child:ShopLayoutCubit.get(context).model!=null? ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => listItem(ShopLayoutCubit.get(context).model!.data!.data[index]),
                      separatorBuilder: (context, index) => Container(
                        width: 10,
                      ),
                      itemCount: ShopLayoutCubit.get(context).model!.data!.data.length):const Center(child: CircularProgressIndicator(color: Colors.orange,)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('New Product',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
             crossAxisSpacing: 0.5,
            mainAxisSpacing: 0.5,
            childAspectRatio: 1/1.7,
            children: List.generate(model.data.products.length, (index){
              return item(model.data.products[index],context);
      }),
          ),
        ],
      ),
    ),
  );
   Widget item(Products model,context)=>Padding(
     padding: const EdgeInsets.all(3.5),
     child: Container(
       decoration: const BoxDecoration(
         color: Colors.white,

       ),
       child: Column(
         children: [
           Stack(
             alignment: AlignmentDirectional.bottomStart,
             children: [
               SizedBox(
                   height: 190,
                   child: Image.network(model.image!,),
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
           const SizedBox(
             height: 5,
           ),
          Column(
            children: [
              Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      height: 1,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
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
                      '${model.old_price}',
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
                                //ShopLayoutCubit.get(context).getFavData();
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
          )
         ],
       ),
     ),
   );

   Widget listItem(DataModel model)=>Stack(
     alignment: AlignmentDirectional.bottomCenter,
     children:  [
        SizedBox(
         width: 100,
         height: 100,
         child: Image(
           fit: BoxFit.cover,
           image: NetworkImage('${model.image}',

           ),
         ),
       ),
       Container(
         width: 100,
         color: Colors.black.withOpacity(0.8),
         child:  Text('${model.name}',
           textAlign: TextAlign.center,
           style: const TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w900,
             color: Colors.white,
           ),
         ),
       ),

     ],
   );
}
