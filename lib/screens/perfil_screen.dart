import 'package:flutter/material.dart';
import 'package:knowyourfan/widgets/animated_page.dart';
import 'package:knowyourfan/widgets/background_container.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/qr_service.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final social = userProvider.social;
    final validacao = userProvider.validacaoIA;

    if (user == null || social == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: const Center(child: Text('Dados do usuário incompletos.')),
      );
    }

    final dadosQRCode = '''
FanID
Nome: ${user.nome}
CPF: ${user.cpf}
Interesses: ${user.interesses}
Twitter: ${social.twitter}
Discord: ${social.discord}
Twitch: ${social.twitch}
Instagram: ${social.instagram}
    ''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Perfil FanID'),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        child: AnimatedPage(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.person, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Dados Pessoais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Nome: ${user.nome}', style: const TextStyle(fontSize: 18)),
                        Text('Endereço: ${user.endereco}', style: const TextStyle(fontSize: 18)),
                        Text('CPF: ${user.cpf}', style: const TextStyle(fontSize: 18)),
                        Text('Interesses: ${user.interesses}', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.public, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Redes Sociais', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Twitter: ${social.twitter}', style: const TextStyle(fontSize: 18)),
                        Text('Discord: ${social.discord}', style: const TextStyle(fontSize: 18)),
                        Text('Twitch: ${social.twitch}', style: const TextStyle(fontSize: 18)),
                        Text('Instagram: ${social.instagram}', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.verified_user, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Validação AI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(validacao ?? 'Validação não realizada.', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Seu QR Code:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Center(
                  child: QRService.gerarQRCode(dadosQRCode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
