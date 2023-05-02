import 'package:flutter/material.dart';
import 'package:meal_app/screen/categories.dart';
import 'package:meal_app/screen/meals.dart';
import '../Model/meal.dart';



class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});


 @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }

}

class _TabsScreenState extends State<TabsScreen>{

   int _selectedPageIndex = 0;
    final List<Meal> _favoriteMeals = [];

    void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
    }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }   

    void _selectedPage(int index){
      setState(() {
        _selectedPageIndex = index;
      });
    }


  @override
  Widget build(BuildContext context) {

    Widget activePage = const CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = const MealsScreen( meals: [], onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal) , label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star) , label: 'Favorites'),
        ],
      ),
    );
  }

}