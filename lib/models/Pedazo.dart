class Pedazo {
  final int id;
  final String remitente;
  final String destinatario;
  final double valor;
  final String numero;

  Pedazo(
    this.id, {
    required this.remitente,
    required this.destinatario,
    required this.valor,
    required this.numero,
  });

  set id(int newId) => id = newId;
  
  

  factory Pedazo.fromJson(Map<String, dynamic> json) {
    return Pedazo(
      json['id'],
      remitente: json['remitente'],
      destinatario: json['destinatario'],
      valor: json['valor'],
      numero: json['numero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remitente': remitente,
      'destinatario': destinatario,
      'valor': valor,
      'numero': numero,
    };
  }

  @override
  String toString() {
    return 'Pedazo(id: $id, remitente: $remitente, destinatario: $destinatario, valor: $valor, numero: $numero)';
  }
}
