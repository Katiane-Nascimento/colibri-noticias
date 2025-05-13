import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/botao_social.dart';
import 'package:colibri_noticias/componentes/cartao_colaborador.dart';
import 'package:colibri_noticias/main.dart';
import 'package:colibri_noticias/paginas/noticias.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  void initState() {
    super.initState();
  }

  int _contagemPublicacoes(String cpf) {
  return listaNoticias
      .map((noticia) => noticia.colaborador.cpf == cpf ? 1 : 0)
      .reduce((soma, valor) => soma + valor);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sobre"),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "O Aplicativo",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Nosso aplicativo de notícias foi criado para trazer informações relevantes e positivas da sua cidade. Com uma interface intuitiva e de fácil acesso, buscamos manter você sempre atualizado com conteúdos de qualidade. Nosso objetivo é fornecer notícias que impactam a comunidade de maneira construtiva, destacando histórias inspiradoras, iniciativas locais e acontecimentos que fazem a diferença.",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                "Colaboradores",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CartaoColaborador(
                imagem: listaColaboradores[0].imagem,
                nomeCompleto: listaColaboradores[0].nomeCompleto(),
                numPublicacoes: _contagemPublicacoes(listaColaboradores[0].cpf),
                botoesSociais: [
                  BotaoSocial(
                    link: Uri.parse("https://www.github.com/PedroLoriato"),
                    nomeBotao: "GitHub",
                    primeiraCorGradiente: Color.fromARGB(255, 30, 30, 30),
                    segundaCorGradiente: Color.fromARGB(255, 60, 60, 60),
                  ),
                  BotaoSocial(
                    link: Uri.parse(
                      "https://www.linkedin.com/in/pedroloriato/",
                    ),
                    nomeBotao: "Linkedin",
                    primeiraCorGradiente: Color.fromARGB(255, 0, 90, 234),
                    segundaCorGradiente: Color.fromARGB(255, 0, 108, 224),
                  ),
                  BotaoSocial(
                    link: Uri.parse("https://www.instagram.com/pedroloriato"),
                    nomeBotao: "Instagram",
                    primeiraCorGradiente: Color.fromARGB(255, 158, 0, 97),
                    segundaCorGradiente: Color.fromARGB(255, 107, 0, 207),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CartaoColaborador(
                imagem: listaColaboradores[1].imagem,
                nomeCompleto: listaColaboradores[1].nomeCompleto(),
                numPublicacoes: _contagemPublicacoes(listaColaboradores[1].cpf),
                botoesSociais: [
                  BotaoSocial(
                    link: Uri.parse(
                      "https://www.github.com/katiane-nascimento",
                    ),
                    nomeBotao: "GitHub",
                    primeiraCorGradiente: Color.fromARGB(255, 30, 30, 30),
                    segundaCorGradiente: Color.fromARGB(255, 60, 60, 60),
                  ),
                  BotaoSocial(
                    link: Uri.parse(
                      "https://www.linkedin.com/in/katiane-maciel-do-nascimento-a26951260/",
                    ),
                    nomeBotao: "Linkedin",
                    primeiraCorGradiente: Color.fromARGB(255, 0, 90, 234),
                    segundaCorGradiente: Color.fromARGB(255, 0, 108, 224),
                  ),
                  BotaoSocial(
                    link: Uri.parse(
                      "https://www.instagram.com/katiane.maciel.nascimento/",
                    ),
                    nomeBotao: "Instagram",
                    primeiraCorGradiente: Color.fromARGB(255, 158, 0, 97),
                    segundaCorGradiente: Color.fromARGB(255, 107, 0, 207),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Faça Parte desse Projeto!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Ajude a manter a população de Santa Teresa sempre bem informada! Nosso aplicativo reúne todas as notícias da região em um só lugar, centralizando as principais fontes de informação para que ninguém fique de fora dos acontecimentos. Seja um colaborador e contribua para levar informação de qualidade à nossa comunidade!",
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Entre em contato conosco pelo nosso WhatsApp!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    fixedSize: Size(150, 50),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Essa funcionalidade estará disponível em breve!",
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 24,
                        color: Colors.white,
                      ),
                      Text(
                        "WhatsApp",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
