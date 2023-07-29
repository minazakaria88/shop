import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/searchcubit.dart';
import 'package:shop.png/searchmodel.dart';
import 'package:shop.png/searchstate.dart';

class Search extends StatelessWidget {

  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
      listener: (context, state) {

      },
        builder: (context, state) {
        var cubit=SearchCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading:  Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  onPressed: (){
                      Navigator.pop(context);
                  },
                  icon:const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  newFormField(
                    iconData: Icons.search,
                    controller: search,
                    label: 'search',
                    function: (h)
                      {
                        cubit.search(text: h.toString());
                      }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(state is SearchLoadState)
                    const LinearProgressIndicator(),
                 cubit.searchModel==null?Container(): Expanded(
                   child: ListView.separated(
                        itemBuilder: (context, index) => item(cubit.searchModel!.data!.data[index],context),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        itemCount: cubit.searchModel!.data!.data.length
                    ),
                 ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget item(Products1 model,context)=> Padding(
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
                          '${model.oldPrice ?? ' '}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
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
