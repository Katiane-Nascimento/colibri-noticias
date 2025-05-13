import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:colibri_noticias/modelos/noticia.dart';

class GerenciadorNoticia {
  static const String chaveNoticias = 'listaNoticias';

  // Método para adicionar uma notícia
  static Future<void> adicionarNoticia(Noticia noticia) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noticiasJson = prefs.getStringList(chaveNoticias) ?? [];

    try {
    // Adiciona a notícia na lista
    noticiasJson.add(noticia.toJson());

    // Salva a lista atualizada no SharedPreferences
    await prefs.setStringList(chaveNoticias, noticiasJson);
  } catch (e) {
    throw FormatException("Erro ao adicionar notícia:  ${e.toString()}");
  }
  }

  // Método para carregar as notícias
  static Future<List<Noticia>> carregarNoticias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noticiasJson = prefs.getStringList(chaveNoticias);

    if (noticiasJson == null) return [];

    return noticiasJson.map((json) {
      Map<String, dynamic> map = jsonDecode(json);
      return Noticia.fromMap(map);
    }).toList();
  }
}