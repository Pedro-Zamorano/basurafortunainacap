import 'package:flutter/material.dart';

class NotificationsCard extends StatefulWidget {
  const NotificationsCard({super.key});

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  Color color1 = const Color(0xFF021024);
  Color color2 = const Color(0xFF052659);
  Color color3 = const Color(0xFF5483B3);
  Color color4 = const Color(0xFF7DA0CA);
  Color color5 = const Color(0xFFC1E8FF);

  final String username = 'Pablo';
  final String dateOfRequest = '09-10-2023';
  final String recyclingTypeRequest = 'Plastico';
  final String addressRequest = 'En la esquina';
  final double weightOfRequest = 80;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.notification_important_outlined),
          title: const Text('Solicitud de retiro'),
          subtitle: const Text('Cliente: Pablo'),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
          onTap: () {
            openDialog(context);
          },
        ),
      ),
    );
  }

  openDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Detalle de Orden', textAlign: TextAlign.center, style: TextStyle(color: color2, fontSize: 22),),
              const Divider(),
              Text('Nombre: $username'),
              const SizedBox(height: 10),
              Text('Fecha solicitud: $dateOfRequest'),
              const SizedBox(height: 10),
              Text('Tipo de reciclaje: $recyclingTypeRequest'),
              const SizedBox(height: 10),
              Text('Dirección: $addressRequest'),
              const SizedBox(height: 10),
              Text('Peso: ${weightOfRequest}kg'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'Volver',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Rechazar',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {},
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
