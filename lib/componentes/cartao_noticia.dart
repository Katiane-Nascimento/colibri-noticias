import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CartaoNoticia extends StatelessWidget {
  final String imagem;
  final String titulo;
  final String resumo;
  final String fonte;
  final Uri link;
  final DateTime dataHoraPublicacao;
  final String nomeColaborador;
  final DateTime dataHoraAdicao;

  const CartaoNoticia({
    super.key,
    required this.imagem,
    required this.titulo,
    required this.resumo,
    required this.fonte,
    required this.link,
    required this.dataHoraPublicacao,
    required this.nomeColaborador,
    required this.dataHoraAdicao,
  });

  String tempoAdicao() {
    final now = DateTime.now();
    final difference = now.difference(dataHoraAdicao);
    if (UtilData.obterDataDDMMAAAA(now) == UtilData.obterDataDDMMAAAA(dataHoraAdicao)) {
      return 'Hoje';
    } else if (difference.inDays == 1) {
      return 'Ontem';
    } else if (difference.inDays < 7) {
      return 'Há ${difference.inDays} dias';
    } else if (difference.inDays < 30) {
      return 'Há uma semana';
    } else if (difference.inDays < 365) {
      return 'Há ${difference.inDays ~/ 30} mês(es)';
    } else {
      return 'Há ${difference.inDays ~/ 365} ano(s)';
    }
  }

  Future<void> _abrirURL(Uri url, BuildContext context) async {
    if (kIsWeb) {
      await launchUrl(url, webOnlyWindowName: '_blank');
    } else {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${UtilData.obterDataDDMMAAAA(dataHoraPublicacao)} '
              '${UtilData.obterHoraHHMM(dataHoraPublicacao) != "00:00" ? UtilData.obterHoraHHMM(dataHoraPublicacao) : ""}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              _abrirURL(link, context);
            },
            child: Stack(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(imagem),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.of(context).size.width * 3 / 4,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withValues(alpha: 0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        fonte,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          resumo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  children: [
                    const TextSpan(text: 'Adicionada por '),
                    TextSpan(
                      text: nomeColaborador,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                tempoAdicao(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}