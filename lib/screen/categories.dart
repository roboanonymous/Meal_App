import 'package:flutter/material.dart';
import 'package:meal_app/Model/category.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import 'package:meal_app/screen/meals.dart';

class CategoriesScreen extends StatelessWidget{

const CategoriesScreen({super.key});

void _selectcategory(BuildContext context, Category category){
   final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

  Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
    )
  );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Category"),

        ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          ) , 
        children: [
          for(final category in availableCategories)
          CategoryGridItem(category: category,onselectcategory: (){_selectcategory(context, category);
          },)
        ],
        ),
    );
  }

}