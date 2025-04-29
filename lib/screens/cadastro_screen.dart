import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knowyourfan/widgets/animated_page.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/background_container.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _interessesController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    _cpfController.dispose();
    _interessesController.dispose();
    super.dispose();
  }

  void _salvarCadastro() {
    if (_formKey.currentState!.validate()) {
      final novoUsuario = UserModel(
        nome: _nomeController.text.trim(),
        endereco: _enderecoController.text.trim(),
        cpf: _cpfController.text.trim(),
        interesses: _interessesController.text.trim(),
        documentoPath: '',
      );

      Provider.of<UserProvider>(context, listen: false).cadastrarUsuario(novoUsuario);
      context.go('/upload');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Fã'),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        child: AnimatedPage(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
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
                                Icon(Icons.person, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Informações Pessoais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(label: 'Nome', controller: _nomeController, validator: (v) => v!.isEmpty ? 'Informe seu nome' : null),
                            CustomTextField(label: 'Endereço', controller: _enderecoController, validator: (v) => v!.isEmpty ? 'Informe seu endereço' : null),
                            CustomTextField(label: 'CPF', controller: _cpfController, validator: (v) => v!.isEmpty ? 'Informe seu CPF' : null),
                            CustomTextField(label: 'Interesses em e-Sports', controller: _interessesController, validator: (v) => v!.isEmpty ? 'Informe seus interesses' : null),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _salvarCadastro,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Próximo: Upload Documento'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
