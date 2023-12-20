import 'package:basura_fortuna/class/item_pyme_class.dart';
import 'package:basura_fortuna/core/constant.dart';
import 'package:basura_fortuna/infraestructure/infraestructure.dart';
import 'package:basura_fortuna/presentation/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PymesScreen extends StatefulWidget {
  const PymesScreen({super.key});

  @override
  State<PymesScreen> createState() => _PymesScreenState();
}

class _PymesScreenState extends State<PymesScreen> {
  @override
  void initState() {
    super.initState();
    getPymesInfo();
  }

  Color color1 = const Color(0xFF021024);
  // Color color2 = const Color(0xFF052659);
  // Color color3 = const Color(0xFF5483B3);
  // Color color4 = const Color(0xFF7DA0CA);
  // Color color5 = const Color(0xFFC1E8FF);

  bool isLoading = true;
  List<PymesInfo> pymesInfoList = [];

  static final Logger _logger = Logger();

  Future<void> getPymesInfo() async {
    try {
      final pymeInfoResponse = await Dio().get(pymeInfoUrl);

      List<dynamic> pymeData = pymeInfoResponse.data;

      List<PymesInfo> pymeInfoToList = pymeData.map((pymeValue) {
        return PymesInfo.fromJson(pymeValue);
      }).toList();

      if (pymeInfoToList.isNotEmpty) {
        pymesInfoList = List.from(pymeInfoToList);
      }

    } catch (error) {
      _logger.e(error.toString());
      _logger.d(error.toString());
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // screen title
            Text(
              'Pymes Disponibles',
              style: TextStyle(
                color: color1,
                fontSize: 32,
                fontFamily: 'Assistant',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // pymes list
            isLoading == true
                ? const LoadingWidget()
                : pymesInfoList.isEmpty
                    ? const Text('No hay pymes registradas')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pymesInfoList.length,
                        itemBuilder: (context, index) {
                          final itemPymeInfo = pymesInfoList[index];
                          return PymeCard(
                            boxItem: ItemPymeClass(
                              pymeId: itemPymeInfo.id,
                              pymeName: itemPymeInfo.name,
                              recyclingType:
                                  itemPymeInfo.recyclingType.typeRecycling,
                              imagePath: 'assets/images/user.png',
                            ),
                          );
                        },
                      ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
