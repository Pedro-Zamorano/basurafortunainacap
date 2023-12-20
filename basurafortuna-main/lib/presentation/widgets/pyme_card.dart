import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/screens/screens.dart';
import 'package:basura_fortuna/class/item_pyme_class.dart';

class PymeCard extends StatelessWidget {
  final ItemPymeClass boxItem;
  const PymeCard({
    super.key,
    required this.boxItem,
  });

  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);

    return GestureDetector(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PymeDetails(boxItem: boxItem);
                },
              ),
            );
      },
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: color1.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              boxItem.imagePath,
              width: 50,
              height: 50,
            ),
          ),
          title: Text(boxItem.pymeName),
          subtitle: Text(
            boxItem.recyclingType,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
