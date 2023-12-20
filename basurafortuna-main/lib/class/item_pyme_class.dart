class ItemPymeClass {
  ItemPymeClass({
    required this.pymeId,
    required this.pymeName,
    required this.recyclingType,
    required this.imagePath,
    this.description,
  });
  int pymeId;
  String pymeName;
  String recyclingType;
  String imagePath;
  String? description;
}