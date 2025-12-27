import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/providers/PedazosProvider.dart';
import 'package:administracion_de_pedazos/widgets/card_widget.dart';
import 'package:administracion_de_pedazos/widgets/font.dart';
import 'package:administracion_de_pedazos/widgets/input.dart';
import 'package:administracion_de_pedazos/widgets/minimal_number_input.dart';
import 'package:administracion_de_pedazos/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarScreen extends StatefulWidget {
  const RegistrarScreen({super.key});

  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState();
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  final _formKey = GlobalKey<FormState>();
  final remitenteCtrl = TextEditingController();
  final destinatarioCtrl = TextEditingController();
  final numeroCtrl = TextEditingController();
  final valorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PedazosProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    void limpiar() {
      remitenteCtrl.clear();
      destinatarioCtrl.clear();
      numeroCtrl.clear();
      valorCtrl.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: titlePrimary("Nuevo Pedazo"),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Numero (000-999)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MinimalNumberInput(hint: "000", controller: numeroCtrl),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    CardWidget(
                      children: [
                        Input(
                          icon: Icons.person,
                          label: "De (Remitente)",
                          hint: "Nombre...",
                          controller: remitenteCtrl,
                        ),

                        Divider(
                          height: 1,
                          color: colorScheme.onSurface.withOpacity(0.08),
                        ),

                        Input(
                          icon: Icons.send,
                          label: "Para (Destinatario)",
                          hint: "Nombre...",
                          controller: destinatarioCtrl,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CardWidget(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Valor del Pedazo"),
                                    TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      controller: valorCtrl,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Este campo es obligatorio';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.onSurface
                                            .withOpacity(0.85),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "\$ 0.00",
                                        hintStyle: TextStyle(
                                          color: colorScheme.onSurface
                                              .withOpacity(0.35),
                                          fontSize: 25,
                                        ),
                                        errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(17, 33, 23, 2),
                                child: Icon(
                                  Icons.attach_money_outlined,
                                  color: colorScheme.primary,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    PrimaryActionButton(
                      label: "Registrar Entrega",
                      icon: Icons.check_circle,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Pedazo pedazo = Pedazo(
                            0,
                            remitente: remitenteCtrl.text.toLowerCase(),
                            destinatario: destinatarioCtrl.text.toLowerCase(),
                            valor: double.parse(valorCtrl.text),
                            numero: numeroCtrl.text,
                          );
                          provider.agregarPedazo(pedazo);
                          limpiar();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
