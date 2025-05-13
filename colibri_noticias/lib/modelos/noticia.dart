import 'dart:convert';
import 'package:colibri_noticias/modelos/colaborador.dart';

class Noticia {
  final String imagem;
  final String fonte;
  final String titulo;
  final String resumo;
  final Uri link;
  final DateTime dataHoraPublicacao;
  final Colaborador colaborador;
  final DateTime dataHoraAdicao;

  Noticia({
    required this.imagem,
    required this.fonte,
    required this.titulo,
    required this.resumo,
    required this.link,
    required this.colaborador,
    required this.dataHoraPublicacao,
    DateTime? dataHoraAdicao,
  }) : dataHoraAdicao = dataHoraAdicao ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "imagem": imagem,
      "fonte": fonte,
      "titulo": titulo,
      "resumo": resumo,
      "link": link.toString(),
      "dataHoraPublicacao": dataHoraPublicacao.toIso8601String(),
      "colaborador": colaborador.toMap(),
      "dataHoraAdicao": dataHoraAdicao.toIso8601String(),
    };
  }

  // Método para converter o objeto em uma string JSON
  String toJson() {
    return jsonEncode(toMap());
  }

  factory Noticia.fromMap(Map<String, dynamic> map) {
    return Noticia(
      imagem: map['imagem'],
      fonte: map['fonte'],
      titulo: map['titulo'],
      resumo: map['resumo'],
      link: Uri.parse(map['link']),
      dataHoraPublicacao: DateTime.parse(map['dataHoraPublicacao']),
      colaborador: Colaborador.fromMap(map['colaborador']),
      dataHoraAdicao: DateTime.parse(map['dataHoraAdicao']),
    );
  }
}
