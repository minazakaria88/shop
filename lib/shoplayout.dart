import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/layoutsearch.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shopstate.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()..getCatData()..getFavData()..getSettingData()..getHomeData(),
      child: BlocConsumer<ShopLayoutCubit,ShopLayoutState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit=ShopLayoutCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,

              elevation: 0,
              actions: [
               IconButton(
                   onPressed: ()
                   {
                     Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>  Search(),)
                     );
                   },
                   icon: const Icon(
                     Icons.search,
                     color: Colors.black,
                   ),
               ),
              ],
              title: const Text('Salla',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
              ),
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Setting',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
