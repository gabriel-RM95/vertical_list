class Item {
  String name;
  String image;
  double price;

  Item({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _names = [
  'First picture',
  'Second picture',
  'Third picture',
  'Fourth picture',
  'Fifth picture',
  'Sixth picture',
  'Seventh picture',
  'Eighth picture',
];

final _prices = [5.25, 7.36, 6.15, 5.12, 1.02, 3.98, 3.25, 7.52];

final items = List.generate(
    _names.length,
    (index) => Item(
          name: _names[index],
          image: 'assets/$index.jpg',
          price: _prices[index],
        ));
