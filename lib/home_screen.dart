import 'package:flutter/material.dart';
import 'package:vertical_list/list_screen.dart';
import 'package:vertical_list/logic/item_bloc.dart';

import 'dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final itemBLoC = ItemBLoC();

  @override
  void dispose() {
    itemBLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              FadeTransition(
            opacity: animation,
            child: ItemProvider(itemBLoC: itemBLoC, child: const ListScreen()),
          ),
        ),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 1.0, end: 0.0),
                curve: Curves.ease,
                builder: (context, value, child) {
                  return Positioned(
                    height: 250,
                    left: 0,
                    right: 0,
                    top: size.height * 0.05 + (size.height / 2 * value),
                    child: Transform.scale(
                      scale: 0.5,
                      child: Hero(
                        tag: items[0].image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            items[0].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.ease,
              builder: (context, value, child) => Positioned(
                height: 300,
                left: 0,
                right: 0,
                top: size.height * 0.2 + (size.height / 3 * value),
                child: Transform.scale(
                  scale: 0.75,
                  child: Hero(
                    tag: items[1].image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        items[1].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 1.0, end: 0.0),
                curve: Curves.ease,
                builder: (context, value, child) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: size.height * 0.4 + (size.height / 4 * value),
                    child: Transform.scale(
                      scale: 0.95,
                      child: Hero(
                        tag: items[2].image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            items[2].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.7,
              child: Transform.scale(
                scale: 1.5,
                child: Hero(
                  tag: items[3].image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      items[3].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
