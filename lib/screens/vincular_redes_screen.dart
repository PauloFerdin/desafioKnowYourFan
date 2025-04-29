import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knowyourfan/widgets/animated_page.dart';
import 'package:knowyourfan/widgets/background_container.dart';
import 'package:provider/provider.dart';
import '../models/social_model.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_textfield.dart';

class VincularRedesScreen extends StatefulWidget {
  const VincularRedesScreen({super.key});

  @override
  State<VincularRedesScreen> createState() => _VincularRedesScreenState();
}

class _VincularRedesScreenState extends State<VincularRedesScreen> {
  final _formKey = GlobalKey<FormState>();

  final _twitterController = TextEditingController();
  final _discordController = TextEditingController();
  final _twitchController = TextEditingController();
  final _instagramController = TextEditingController();

  @override
  void dispose() {
    _twitterController.dispose();
    _discordController.dispose();
    _twitchController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  void _salvarRedesSociais() {
    if (_formKey.currentState!.validate()) {
      final social = SocialModel(
        twitter: _twitterController.text.trim(),
        discord: _discordController.text.trim(),
        twitch: _twitchController.text.trim(),
        instagram: _instagramController.text.trim(),
      );

      Provider.of<UserProvider>(context, listen: false).cadastrarRedes(social);

      context.go('/validar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Redes Sociais'),
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
                    CustomTextField(
                      label: 'Twitter (link ou username)',
                      controller: _twitterController,
                      validator: (value) => value == null || value.isEmpty ? 'Informe seu Twitter' : null,
                    ),
                    CustomTextField(
                      label: 'Discord (username ou link)',
                      controller: _discordController,
                      validator: (value) => value == null || value.isEmpty ? 'Informe seu Discord' : null,
                    ),
                    CustomTextField(
                      label: 'Twitch (link ou username)',
                      controller: _twitchController,
                      validator: (value) => value == null || value.isEmpty ? 'Informe sua Twitch' : null,
                    ),
                    CustomTextField(
                      label: 'Instagram (link ou username)',
                      controller: _instagramController,
                      validator: (value) => value == null || value.isEmpty ? 'Informe seu Instagram' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _salvarRedesSociais,
                      icon: const Icon(Icons.save_alt),
                      label: const Text('Próximo: Validar Perfil com IA'),
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
