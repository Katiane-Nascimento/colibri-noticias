import 'package:brasil_fields/brasil_fields.dart';
import 'package:colibri_noticias/componentes/app_bar.dart';
import 'package:colibri_noticias/componentes/campo_formulario.dart';
import 'package:colibri_noticias/modelos/noticia.dart';
import 'package:colibri_noticias/servicos/gerenciador_login.dart';
import 'package:colibri_noticias/servicos/gerenciador_noticia.dart';
import 'package:colibri_noticias/utilitarios/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroNoticias extends StatefulWidget {
  const CadastroNoticias({super.key});

  @override
  State<CadastroNoticias> createState() => _CadastroNoticiasState();
}

class _CadastroNoticiasState extends State<CadastroNoticias> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController imagemController;
  late TextEditingController fonteController;
  late TextEditingController linkController;
  late TextEditingController tituloController;
  late TextEditingController resumoController;
  late TextEditingController dataHoraPublicacaoController;

  late FocusNode imagemFocus;
  late FocusNode fonteFocus;
  late FocusNode linkFocus;
  late FocusNode tituloFocus;
  late FocusNode resumoFocus;
  late FocusNode dataHoraPublicacaoFocus;

  @override
  void initState() {
    super.initState();
    imagemController = TextEditingController();
    fonteController = TextEditingController();
    linkController = TextEditingController();
    tituloController = TextEditingController();
    resumoController = TextEditingController();
    dataHoraPublicacaoController = TextEditingController();

    imagemFocus = FocusNode();
    fonteFocus = FocusNode();
    linkFocus = FocusNode();
    tituloFocus = FocusNode();
    resumoFocus = FocusNode();
    dataHoraPublicacaoFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double responsiveWidth = width * 0.95;

    return Scaffold(
      appBar: CustomAppBar(title: "Cadastro de Notícias"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Cadastrar Notícia',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: responsiveWidth,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CampoFormulario(
                        controller: imagemController,
                        focusNode: imagemFocus,
                        label: 'Imagem',
                        placeholder: 'Coloque a URL da imagem',
                        prefixIcon: const Icon(Icons.image),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: fonteController,
                        focusNode: fonteFocus,
                        label: 'Fonte',
                        placeholder: 'Coloque o nome da fonte da notícia',
                        prefixIcon: const Icon(Icons.newspaper),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: linkController,
                        focusNode: linkFocus,
                        label: 'Link',
                        placeholder: 'Coloque a URL da fonte da notícia',
                        prefixIcon: const Icon(Icons.link),
                        validator: validarUrl,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: tituloController,
                        focusNode: tituloFocus,
                        label: 'Título',
                        placeholder: 'Coloque o título da notícia',
                        prefixIcon: const Icon(Icons.title),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: resumoController,
                        focusNode: resumoFocus,
                        label: 'Resumo',
                        placeholder: 'Coloque o resumo da notícia',
                        prefixIcon: const Icon(Icons.text_snippet),
                        validator: validarCampoTexto,
                        inputFormatters: [],
                      ),
                      CampoFormulario(
                        controller: dataHoraPublicacaoController,
                        focusNode: dataHoraPublicacaoFocus,
                        label: 'Data e Hora de Publicação',
                        placeholder: 'DD/MM/AAAA HH:MM',
                        prefixIcon: const Icon(Icons.calendar_today),
                        validator: validarDataHora,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        isDateField: true,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            Noticia novaNoticia = Noticia(
                              imagem: imagemController.text,
                              fonte: fonteController.text,
                              link: Uri.parse(linkController.text),
                              titulo: tituloController.text,
                              resumo: resumoController.text,
                              dataHoraPublicacao: UtilData.obterDateTimeHora(
                                dataHoraPublicacaoController.text,
                              ),
                              colaborador: GerenciadorLogin.colaboradorLogado!,
                            );
                            try {
                              // Adiciona a nova notícia
                              await GerenciadorNoticia.adicionarNoticia(
                                novaNoticia,
                              );
                              if (context.mounted) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Notícia adicionada com sucesso!",
                                    ),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                              setState(() {
                                imagemController.clear();
                                fonteController.clear();
                                linkController.clear();
                                tituloController.clear();
                                resumoController.clear();
                                dataHoraPublicacaoController.clear();
                              });
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ), // Texto em branco para contraste
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior:
                                        SnackBarBehavior
                                            .floating, // Define o fundo da SnackBar como vermelho
                                  ),
                                );
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Preencha todos os campos corretamente!",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ), // Texto em branco para contraste
                                ),
                                backgroundColor: Colors.red,
                                behavior:
                                    SnackBarBehavior
                                        .floating, // Define o fundo da SnackBar como vermelho
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    imagemController.dispose();
    fonteController.dispose();
    linkController.dispose();
    tituloController.dispose();
    resumoController.dispose();
    dataHoraPublicacaoController.dispose();

    imagemFocus.dispose();
    fonteFocus.dispose();
    linkFocus.dispose();
    tituloFocus.dispose();
    resumoFocus.dispose();
    dataHoraPublicacaoFocus.dispose();

    super.dispose();
  }
}
