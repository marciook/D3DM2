class Temperatura {
  final String latitude;
  final String longitude;
  final num temperaturaAtual;
  final num umidade;


  Temperatura({
    required this.latitude,
    required this.longitude,
    required this.temperaturaAtual,
    required this.umidade,

  });

  // Método para converter um Map em um objeto Temperatura
  factory Temperatura.fromJson(Map<String, dynamic> json) {
    return Temperatura(
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      temperaturaAtual: json['current']['temperature_2m'],
      umidade: json['current']['relative_humidity_2m']
    );
  }
}