import 'package:basura_fortuna_corp/core/constant.dart';
import 'package:basura_fortuna_corp/infraestructure/models/request_history/recycling_request_item.dart';
import 'package:basura_fortuna_corp/presentation/screens/screens.dart';
import 'package:basura_fortuna_corp/presentation/widgets/loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RecyclingActive extends StatefulWidget {
  const RecyclingActive({super.key});

  @override
  State<RecyclingActive> createState() => _RecyclingActiveState();
}

class _RecyclingActiveState extends State<RecyclingActive> {
  @override
  void initState() {
    super.initState();
    getRequestHistory();
  }

  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);

  static final Logger _logger = Logger();
  bool isLoading = true;
  List<RecyclingRequestItem>? historyList = [];

  Future<void> getRequestHistory() async {
    try {
      final historyResponse = await Dio().get(recyclingRequestHistoryUrl);

      if (historyResponse.statusCode == 200) {
        List<dynamic> historyData = historyResponse.data;

        List<RecyclingRequestItem> historyToList = historyData.map((pymeValue) {
          return RecyclingRequestItem.fromJson(pymeValue);
        }).toList();

        if (historyToList.isNotEmpty) {
          historyList = List.from(historyToList);
        }
      }
    } catch (e) {
      _logger.e(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: isLoading
          ? const LoadingWidget()
          : ListView.builder(
              itemCount: historyList?.length,
              itemBuilder: (context, index) {
                final itemHistory = historyList?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CameraReader(),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Clic en la tarjeta para iniciar reciclaje',
                            style: TextStyle(
                              color: color1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Usuario: ${itemHistory!.user.username}'),
                          Text(
                              'Dirección: ${itemHistory.user.userAddress.additional}'),
                          Text('Peso estimado: ${itemHistory.estimatedWeight}'),
                          Text('Descripción: ${itemHistory.description}'),
                          Text('Estado: ${itemHistory.state}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
