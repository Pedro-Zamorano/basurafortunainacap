import 'package:basura_fortuna/class/item_pyme_class.dart';
import 'package:flutter/material.dart';

import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:basura_fortuna/presentation/screens/screens.dart';

class PymeDetails extends StatefulWidget {
  const PymeDetails({
    super.key,
    required this.boxItem,
  });

  final ItemPymeClass boxItem;

  @override
  State<PymeDetails> createState() => _PymeDetailsState();
}

class _PymeDetailsState extends State<PymeDetails> {
  @override
  Widget build(BuildContext context) {
    Color color1 = const Color(0xFF021024);
    Color color2 = const Color(0xFF052659);
    // Color color3 = const Color(0xFF5483B3);
    // Color color4 = const Color(0xFF7DA0CA);
    Color color5 = const Color(0xFFC1E8FF);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_bf.png',
          width: 170,
          height: 130,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.01, 0.99],
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: color5,
          ),
        ),
      ),
      body: AppBackground(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        widget: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 150,
                    child: Image.asset(widget.boxItem.imagePath),
                  ),

                  const SizedBox(height: 20),

                  // name
                  Text(
                    widget.boxItem.pymeName,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),

                  // recycling type
                  Text(
                    'Esta Pyme recicla:',
                    style: TextStyle(
                      color: color5,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.boxItem.recyclingType,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // request recycling
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Button(
                        buttonText: 'Solicitar',
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RecyclingRequest(
                                pymeId: widget.boxItem.pymeId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Presiona el boton "Solicitar" para programar \nel retiro de tu reciclaje!',
                    style: TextStyle(
                      color: color2,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
