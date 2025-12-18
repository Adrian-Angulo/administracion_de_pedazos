import 'package:administracion_de_pedazos/widgets/font.dart';
import 'package:administracion_de_pedazos/widgets/info_card.dart';
import 'package:administracion_de_pedazos/widgets/primary_action_button.dart';
import 'package:administracion_de_pedazos/widgets/secundary_action_button.dart';
import 'package:flutter/material.dart';

class DasboardScreen extends StatefulWidget {
  const DasboardScreen({super.key});

  @override
  State<DasboardScreen> createState() => _DasboardScreenState();
}

class _DasboardScreenState extends State<DasboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titlePrimary("Dasboard"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 10,
              children: [
                InfoCard(
                  icon: Icons.app_registration_outlined,
                  value: "12",
                  label: "Total de pedazos registrados",
                ),
                InfoCard(
                  icon: Icons.monetization_on,
                  value: "20000",
                  label: "Total dinero acumulado",
                ),
              ],
            ),

            Text(
              "Acciones Rapidas",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            PrimaryActionButton(
              label: "Registrar Pedazo",
              icon: Icons.add,
              onPressed: () {},
            ),

            Row(
              spacing: 10,
              children: [
                SecundaryActionButton(
                  label: "Ver Pedazos",
                  icon: Icons.search,
                  onPressed: () {},
                ),
                SecundaryActionButton(
                  label: "Ver Historial",
                  icon: Icons.history,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                SizedBox(width: 10),
                Text(
                  "almancenamineto interno",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
