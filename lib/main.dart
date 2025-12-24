import 'package:administracion_de_pedazos/providers/pageProvider.dart';
import 'package:administracion_de_pedazos/screens/home_page.dart';
import 'package:administracion_de_pedazos/settings/theme/them_data.dart';
import 'package:administracion_de_pedazos/providers/PedazosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // Configuración del Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PedazosProvider()),
        ChangeNotifierProvider(create: (context) => Pageprovider()),
      ],
      child: MaterialApp(
        title: 'Administración de Pedazos',
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
