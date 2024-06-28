import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmoneky/cubits/food_cubit/food_cubit.dart';
import 'package:mealmoneky/model/food.dart';
import 'package:mealmoneky/pages/detail_page.dart';
import 'package:mealmoneky/utility/constants.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(28),
          ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10,),
            Image.asset('lib/assets/icons/search-gray.png',width: 20,height: 20,),
            const SizedBox(width: 10,),
            const Text('Serach Food',style: TextStyle(color:  Color(0xffB6B7B7),fontWeight: FontWeight.w700,))
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {
              query = '';
            },
            child: const Icon(Icons.cancel_rounded)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new_outlined));
  }


  @override
  Widget buildResults(BuildContext context) {
    List<Food> foods = context
        .read<FoodCubit>()
        .foods;

    List<Food> matchQuery = [];
    for (var item in foods) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailPage(food: foods[index]),));
            },
            child: ListTile(title: Text(matchQuery[index].title),));
      },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Food> foods = context
        .read<FoodCubit>()
        .foods;

    List<Food> matchQuery = [];
    for (var item in foods) {
      if (item.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailPage(food: foods[index]),));
            },
            child: ListTile(title: Text(matchQuery[index].title),));
      },);
  }
}

