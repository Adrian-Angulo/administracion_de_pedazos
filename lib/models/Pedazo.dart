class Pedazo {
  final int id;
  final String para;
  final String de;
  final double valor;
  final String numero;


  Pedazo({
    required this.id,
    required this.para,
    required this.de,
    required this.valor,
    required this.numero,
  });

  factory Pedazo.fromJson(Map<String, dynamic> json) {
    return Pedazo(
      id: json['id'],
      para: json['para'],
      de: json['de'],
      valor: json['valor'],
      numero: json['numero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'para': para,
      'de': de,
      'valor': valor,
      'numero': numero,
    };
  }

  @override
  String toString() {
    return 'Pedazo(id: $id, para: $para, de: $de, valor: $valor, numero: $numero)';
  }

}
