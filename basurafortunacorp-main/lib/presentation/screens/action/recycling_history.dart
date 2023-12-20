import 'package:basura_fortuna_corp/core/constant.dart';
import 'package:basura_fortuna_corp/infraestructure/models/history/request_history.dart';
import 'package:basura_fortuna_corp/presentation/screens/screens.dart';
import 'package:basura_fortuna_corp/presentation/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RecyclingHistory extends StatefulWidget {
  const RecyclingHistory({super.key});

  @override
  State<RecyclingHistory> createState() => _RecyclingHistoryState();
}

class _RecyclingHistoryState extends State<RecyclingHistory> {
  @override
  void initState() {
    super.initState();
    getHistoryRequest();
  }

  static final Logger _logger = Logger();
  bool isLoading = true;
  List<RequestHistory>? historyList = [];

  // Obtener listado de solicitudes
  Future<void> getHistoryRequest() async {
    try {
      final historyResponse = await Dio().get(pymeRequestHistoryUrl);

      if (historyResponse.statusCode == 200) {
        List<dynamic> historyData = historyResponse.data;

        List<RequestHistory> historyToList = historyData.map((pymeValue) {
          return RequestHistory.fromJson(pymeValue);
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
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Usuario: ${itemHistory!.recyclingRequestDetail.user.name} ${itemHistory.recyclingRequestDetail.user.lastname}'),
                        Text(
                            'Estado: ${itemHistory.recyclingRequestDetail.state}'),
                        Text('Descripción: ${itemHistory.description}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
