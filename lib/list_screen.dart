import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vertical_list/details_screen.dart';
import 'package:vertical_list/logic/item_bloc.dart';

import 'dummy_data.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = ItemProvider.of(context)?.itemBLoC;
    bloc?.init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemBLoC = ItemProvider.of(context)?.itemBLoC;
    return Scaffold(
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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            // bottom: -size.height * 0.2,
            bottom: -100,
            left: 0,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal,
                    spreadRadius: 500,
                    blurRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.ease,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, -value * 100),
                  child: SizedBox(
                    height: 50,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: itemBLoC?.namePageController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: items[index].name,
                          child: Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                items[index].name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
          ValueListenableBuilder<double>(
              valueListenable: itemBLoC!.nameCurrentPage,
              builder: (context, nameCurrentPage, _) {
                return TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 1.0, end: 0.0),
                    curve: Curves.ease,
                    builder: (context, value, child) {
                      return Positioned(
                        top: 50 - (value * 100),
                        left: 0,
                        right: 0,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            '\$${items[(nameCurrentPage + 0.5).toInt()].price.toString()}',
                            key:
                                Key((nameCurrentPage + 0.5).toInt().toString()),
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ),
                      );
                    });
              }),
          Transform(
            transform: Matrix4.identity()
              ..translate(0.0, size.height * -0.25)
              ..scale(1.75),
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: ValueListenableBuilder<double>(
                  valueListenable: itemBLoC.imageCurrentPage,
                  builder: (context, imageCurrentPage, _) {
                    return PageView.builder(
                      clipBehavior: Clip.none,
                      controller: itemBLoC.imagePageController,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) {
                        itemBLoC.namePageController.animateToPage(
                          value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      itemCount: items.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox.shrink();
                        }

                        final item = items[index - 1];
                        final value = imageCurrentPage - index + 1;
                        final result = (-0.4 * value + 1).clamp(0.0, 1.0);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 800),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 800),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FadeTransition(
                                  opacity: animation,
                                  child: DetailsScreen(
                                    item: item,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..translate(0.0, (1 - result) * size.height / 1.9)
                              ..scale(result / 2),
                            child: Hero(
                              tag: item.image,
                              child: Opacity(
                                opacity: result,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          item.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: (1 - result) * 10,
                                          sigmaY: (1 - result) * 10,
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
