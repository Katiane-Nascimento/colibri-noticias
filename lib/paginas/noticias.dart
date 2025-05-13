import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/cartao_noticia.dart';
import 'package:colibri_noticias/main.dart';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:colibri_noticias/servicos/gerenciador_login.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:flutter/material.dart';
import 'cadastrar_noticia.dart';

List<Noticia> listaNoticias = [
  Noticia(
    imagem:
        "https://midias.agazeta.com.br/2025/02/21/3-edicao-do-santo-boteco-acontece-entre-28-de-fevereiro-e-4-de-marco-2620184-article.png",
    fonte: "AGAZETA",
    titulo:
        "Santa Teresa terá carnaval gastronômico com pratos a partir de R\$15",
    resumo:
        "3ª edição do Santo Boteco acontece entre os dias 28 de fevereiro e 4 de março. Programação musical contempla desde marchinhas de carnaval até MPB",
    link: Uri.parse(
      "https://www.agazeta.com.br/hz/gastronomia/santa-teresa-tera-carnaval-gastronomico-com-pratos-a-partir-de-r-15-0225",
    ),
    colaborador: listaColaboradores[1],
    dataHoraPublicacao: DateTime.parse("2025-02-21 14:34:00"),
    dataHoraAdicao: DateTime.parse("2025-02-22 14:00:00"),
  ),
  Noticia(
    imagem:
        "https://cors-anywhere.herokuapp.com/https://santateresa.ifes.edu.br/images/stories/2025/Mulheres_em_Perspectiva/Mulheres_em_Perspectiva_banner_rotativo.png",
    fonte: "IFES - Campus Santa Teresa",
    titulo:
        "Ifes Santa Teresa promove ciclo de palestras \"Mulheres em Perspectiva\"",
    resumo:
        "O Ifes Campus Santa Teresa, por meio do Núcleo de Estudos e Pesquisas em Educação e Sexualidades (NEPGENS), realizará, ao longo do mês de março, o Ciclo de Palestras \"Mulheres em Perspectiva\". O evento contará com palestras de especialistas, sessões de cinema temático e apresentações artísticas, promovendo reflexões sobre a equidade de gênero e o papel da mulher na sociedade.",
    link: Uri.parse(
      "https://santateresa.ifes.edu.br/noticias/18371-ifes-santa-teresa-promove-ciclo-de-palestras-mulheres-em-perspectiva",
    ),
    colaborador: listaColaboradores[0],
    dataHoraPublicacao: DateTime.parse("2025-03-07 07:36:00"),
    dataHoraAdicao: DateTime.parse("2025-03-07 19:30:00"),
  ),
  Noticia(
    imagem:
        "https://midias.agazeta.com.br/2025/03/05/rodrigo-britto-ivana-e-kleber-medici-e--2636287-article.jpeg",
    fonte: "AGAZETA",
    titulo: "Veja como foi o carnaval de marchinhas e boa mesa em Santa Teresa",
    resumo:
        "O secretário de Turismo e Cultura Rodrigo Brito, a primeira-dama de de Santa Teresa Ivana Médici, o prefeito de Santa Teresa Kleber Médici e o secretário de Governo João Paulo Angeli: folia na Terra dos Colibris. Crédito: Prefeitura de Santa Teresa",
    link: Uri.parse(
      "https://www.agazeta.com.br/hz/social/veja-como-foi-o-carnaval-de-marchinhas-e-boa-mesa-em-santa-teresa-0325",
    ),
    colaborador: listaColaboradores[1],
    dataHoraPublicacao: DateTime.parse("2025-03-06 03:00:00"),
    dataHoraAdicao: DateTime.parse("2025-03-06 19:30:00"),
  ),
  Noticia(
    imagem:
        "https://cors-anywhere.herokuapp.com/https://aquinoticias.com/wp-content/uploads/2025/03/WhatsApp-Image-2025-02-28-at-15.29.03-1.jpeg",
    fonte: "aquinoticias.com",
    titulo: "Parceria une forças e distribuem 500 mil mudas no Estado; entenda",
    resumo:
        "A iniciativa integra o Plano de Desenvolvimento Florestal do Espírito Santo, reforçando políticas públicas de incentivo à produção sustentável e ao manejo responsável de recursos naturais.",
    link: Uri.parse(
      "https://aquinoticias.com/2025/03/parceria-une-forcas-e-distribuem-500-mil-mudas-no-estado-entenda/",
    ),
    colaborador: listaColaboradores[0],
    dataHoraPublicacao: DateTime.parse("2025-03-01 14:53:00"),
    dataHoraAdicao: DateTime.parse("2025-03-02 13:30:00"),
  ),
];

class Noticias extends StatefulWidget {
  const Noticias({super.key});

  @override
  State<Noticias> createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  @override
  void initState() {
    super.initState();
    carregarNoticias();
  }

  void carregarNoticias() async {
    try {
      List<Noticia> noticias = await GerenciadorNoticia.carregarNoticias();
      setState(() {
        // Filtra notícias que ainda não estão na lista pelo link (para evitar duplicação)
        List<Noticia> novasNoticias =
            noticias
                .where(
                  (noticia) =>
                      !listaNoticias.any(
                        (n) => n.link.toString() == noticia.link.toString(),
                      ),
                )
                .toList();

        // Atualiza a lista original com as novas notícias
        listaNoticias = [...listaNoticias, ...novasNoticias];

        // Ordena por data de adição
        listaNoticias.sort(
          (a, b) => b.dataHoraAdicao.compareTo(a.dataHoraAdicao),
        );
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao carregar notícias: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notícias"),
      body: SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        minimum: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: ListView.builder(
          padding: GerenciadorLogin.isLogado() ? EdgeInsets.only(bottom: kBottomNavigationBarHeight + 70) : EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          itemCount: listaNoticias.length,
          itemBuilder: (context, index) {
            return CartaoNoticia(
              imagem: listaNoticias[index].imagem,
              fonte: listaNoticias[index].fonte,
              titulo: listaNoticias[index].titulo,
              resumo: listaNoticias[index].resumo,
              link: listaNoticias[index].link,
              dataHoraPublicacao: listaNoticias[index].dataHoraPublicacao,
              nomeColaborador: listaNoticias[index].colaborador.primeiroNome(),
              dataHoraAdicao: listaNoticias[index].dataHoraAdicao,
            );
          },
        ),
      ),
      floatingActionButton:
          GerenciadorLogin.isLogado()
              ? Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: FloatingActionButton(
                  onPressed: () async {
                    // Aguarda o retorno da tela de cadastro
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroNoticias(),
                      ),
                    );
                    // Recarrega as notícias após o retorno
                    carregarNoticias();
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.add,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              )
              : null,
    );
  }
}
