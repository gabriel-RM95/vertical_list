import 'package:flutter/material.dart';

import 'dummy_data.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cases_outlined),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: item.name,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Hero(
                    tag: item.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        item.image,
                        fit: BoxFit.fill,
                        height: 180,
                      ),
                    ),
                  ),
                ),
                TweenAnimationBuilder<double>(
                  curve: Curves.ease,
                  tween: Tween(begin: -50.0, end: 50.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Positioned(
                      top: 0,
                      right: value,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder<double>(
                  curve: Curves.ease,
                  tween: Tween(begin: -50.0, end: 50.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Positioned(
                      bottom: 0,
                      left: value,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: Text(
                          '\$${item.price}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          TweenAnimationBuilder<double>(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 1.0, end: 0.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0.0, 300 * value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Column(
                        children: const [
                          Icon(Icons.photo_size_select_actual_outlined),
                          Text(
                            'S',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.photo_size_select_actual_rounded,
                            size: 40,
                          ),
                          Text(
                            'M',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.photo_size_select_actual_outlined,
                            size: 60,
                          ),
                          Text(
                            'L',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          TweenAnimationBuilder<double>(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, 300 * value),
                  child: const Center(
                    child: Text('Hot / Warm'),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
