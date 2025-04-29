import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knowyourfan/widgets/animated_page.dart';
import 'package:knowyourfan/widgets/background_container.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/ai_service.dart';
import '../widgets/loading_indicator.dart';

class ValidarLinksScreen extends StatefulWidget {
  const ValidarLinksScreen({super.key});

  @override
  State<ValidarLinksScreen> createState() => _ValidarLinksScreenState();
}

class _ValidarLinksScreenState extends State<ValidarLinksScreen> {
  final _linkController = TextEditingController();
  String? _resultado;
  bool _validando = false;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _validarLink() async {
    if (_linkController.text.isEmpty) return;

    setState(() {
      _validando = true;
      _resultado = null;
    });

    final prompt = '''
Você é um verificador de perfis de fãs de e-sports.
Analise o seguinte link de perfil ou post: "${_linkController.text}"
Determine se é relacionado a e-sports ou à organização FURIA.
Responda apenas com "Perfil relevante para e-sports" ou "Perfil não relacionado".
    ''';

    try {
      final resposta = await AIService.validarTextoComAI(prompt);

      setState(() {
        _resultado = resposta;
        _validando = false;
      });

      Provider.of<UserProvider>(context, listen: false).salvarValidacaoIA(resposta);

    } catch (e) {
      setState(() {
        _resultado = 'Erro na validação: $e';
        _validando = false;
      });
    }
  }

  void _concluirCadastro() {
    context.go('/perfil');
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Validar Perfil com IA'),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        child: AnimatedPage(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Cole o link abaixo:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _linkController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Link de perfil ou post',
                            filled: true,
                            fillColor: const Color(0xFF1A1A1A),
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            onPressed: _validando ? null : _validarLink,
                            icon: const Icon(Icons.search),
                            label: _validando
                                ? const LoadingIndicator()
                                : const Text('Validar com IA'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_resultado != null)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'Resultado:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _resultado!,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: primaryColor,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: (_resultado != null && !_validando) ? _concluirCadastro : null,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Concluir Cadastro'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
