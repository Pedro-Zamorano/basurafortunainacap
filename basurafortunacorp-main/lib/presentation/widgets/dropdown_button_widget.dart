import 'package:flutter/material.dart';

class DropdownButtonWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemToString;
  final String? Function(T?)? validator;

  const DropdownButtonWidget({
    super.key,
    required this.items,
    required this.value,
    this.hintText,
    required this.onChanged,
    this.itemToString,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      dropdownColor: const Color(0xFF021024),
      validator: validator,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF79747E)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF79747E)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        hintText ?? '',
        style: const TextStyle(
          color: Color(0xFFC1E8FF),
          fontSize: 20,
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<T>>(
        (T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: SizedBox(
              width:
                  282, // Ajusta el tamaño del contenido del Dropdown para evitar overflowed
              child: Text(
                itemToString != null ? itemToString!(item) : item.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF7DA0CA),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
