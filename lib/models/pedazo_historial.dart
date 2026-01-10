class Pedazohistorial {
  final String id;
  final String remitente;
  final String destinatario;
  final double valor;
  final String numero;
  final String hora;
  final String estado;
  
  final bool isCompleted;

  Pedazohistorial(
    this.id, {
    required this.remitente,
    required this.destinatario,
    required this.valor,
    required this.numero,
    required this.hora,
    required this.estado,
    required this.isCompleted,
  });

  factory Pedazohistorial.fromJson(Map<String, dynamic> json) {
    return Pedazohistorial(
      json['id'],
      remitente: json['remitente'],
      destinatario: json['destinatario'],
      valor: json['valor'],
      numero: json['numero'],
      hora: json['hora'],
      estado: json['estado'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'remitente': remitente,
      'destinatario': destinatario,
      'valor': valor,
      'numero': numero,
      'hora': hora,
      'estado': estado,
      
      'isCompleted': isCompleted,
    };
  }

  @override
  String toString() {
    return 'Pedazohistorial(id: $id, remitente: $remitente, destinatario: $destinatario, valor: $valor, numero: $numero, hora: $hora, estado: $estado, isCompleted: $isCompleted)';
  }
}
