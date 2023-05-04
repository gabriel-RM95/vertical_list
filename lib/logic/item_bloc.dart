import 'package:flutter/cupertino.dart';
import 'package:vertical_list/dummy_data.dart';

const _initialPage = 2.0;

class ItemBLoC {
  final myItems = items;

  final imagePageController = PageController(
    viewportFraction: 0.333,
    initialPage: _initialPage.toInt(),
  );
  final namePageController = PageController(
    initialPage: _initialPage.toInt(),
  );

  final imageCurrentPage = ValueNotifier<double>(_initialPage);
  final nameCurrentPage = ValueNotifier<double>(_initialPage);

  void init() {
    imageCurrentPage.value = _initialPage;
    nameCurrentPage.value = _initialPage;
    imagePageController.addListener(_imageListener);
    namePageController.addListener(_nameListener);
  }

  void _imageListener() {
    imageCurrentPage.value = imagePageController.page ?? 0.0;
  }

  void _nameListener() {
    nameCurrentPage.value = namePageController.page ?? 0.0;
  }

  void dispose() {
    imagePageController.removeListener(_imageListener);
    namePageController.removeListener(_nameListener);
    imagePageController.dispose();
    namePageController.dispose();
  }
}

class ItemProvider extends InheritedWidget {
  final ItemBLoC? itemBLoC;

  ItemProvider({super.key, required this.itemBLoC, Widget? child})
      : super(child: child!);

  static ItemProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ItemProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
