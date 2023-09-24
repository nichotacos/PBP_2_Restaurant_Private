class ShowBurgers {
  const ShowBurgers(this.burgerName, this.burgerImages);

  final List<String> burgerImages;
  final List<String> burgerName;

  List<String> imagesList() {
    final images = List.of(burgerImages);
    return images;
  }

  List<String> namesList() {
    final names = List.of(burgerName);
    return names;
  }
}
