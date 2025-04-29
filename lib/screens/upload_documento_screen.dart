import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourfan/widgets/animated_page.dart';
import 'package:knowyourfan/widgets/background_container.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/ai_service.dart';
import '../widgets/loading_indicator.dart';

class UploadDocumentoScreen extends StatefulWidget {
  const UploadDocumentoScreen({super.key});

  @override
  State<UploadDocumentoScreen> createState() => _UploadDocumentoScreenState();
}

class _UploadDocumentoScreenState extends State<UploadDocumentoScreen> {
  File? _documento;
  bool _validando = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _documento = File(pickedFile.path);
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null) {
        final updatedUser = userProvider.user!.copyWith(documentoPath: pickedFile.path);
        userProvider.cadastrarUsuario(updatedUser);
      }
    }
  }

  Future<void> _validarDocumento() async {
    if (_documento == null) return;

    setState(() {
      _validando = true;
    });

    final resultado = await AIService.validarTextoComAI("Valide a autenticidade de um documento de identificação.");

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.salvarValidacaoIA(resultado);

    setState(() {
      _validando = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resultado)));

    context.go('/redes');
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documento'),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        child: AnimatedPage(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                            Icon(Icons.file_copy, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Selecione um Documento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _documento == null
                            ? const Text('Nenhuma imagem selecionada.', textAlign: TextAlign.center)
                            : Image.file(_documento!, height: 250),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image_search),
                          label: const Text('Escolher Documento'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: (_documento != null && !_validando) ? _validarDocumento : null,
                    icon: const Icon(Icons.verified_user),
                    label: _validando
                        ? const LoadingIndicator()
                        : const Text('Validar Documento com IA'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
