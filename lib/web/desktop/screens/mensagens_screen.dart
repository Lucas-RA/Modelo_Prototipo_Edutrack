import 'package:flutter/material.dart';
import '../../../data/management_mock_data.dart';
import '../../../models/management.dart';
import '../../../theme/app_text_styles.dart';
import '../desktop_theme.dart';
import '../desktop_widgets.dart';

class MensagensScreen extends StatelessWidget {
  const MensagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unread =
        ManagementMock.conversations.fold<int>(0, (sum, c) => sum + c.unread);
    return DeskPage(header: ManagementMock.educatorHeaders[4], actions: const [
      DeskButton(label: 'Buscar conversa', icon: Icons.search),
      DeskButton(label: 'Nova mensagem', icon: Icons.edit, primary: true),
    ], children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 8,
            child: DeskSection(
                title: 'Caixa de entrada',
                subtitle:
                    '${ManagementMock.conversations.length} conversas · $unread mensagens não lidas',
                trailing: const DeskButton(
                    label: 'Não lidas', icon: Icons.mark_email_unread_outlined),
                child: Column(children: [
                  for (final chat in ManagementMock.conversations) _row(chat),
                ]))),
        const SizedBox(width: 18),
        Expanded(
            flex: 3,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DeskSection(
                      title: 'Atalhos de contato',
                      subtitle: 'Modelos usados com mais frequência',
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DeskButton(
                                label: 'Aviso de faltas ao responsável',
                                icon: Icons.mail_outline),
                            SizedBox(height: 10),
                            DeskButton(
                                label: 'Lembrete de entrega no Moodle',
                                icon: Icons.school_outlined),
                            SizedBox(height: 10),
                            DeskButton(
                                label: 'Comunicado à turma',
                                icon: Icons.campaign_outlined),
                          ])),
                  const SizedBox(height: 18),
                  DeskSection(
                      title: 'Visibilidade',
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            deskText(
                                'Conversas limitadas aos alunos e responsáveis das turmas do educador, conforme C1.'),
                            const SizedBox(height: 10),
                            deskText(
                                'Nenhum conteúdo de check-in emocional é reproduzido nas mensagens (C4).'),
                          ])),
                ])),
      ]),
      const DeskNotice(ManagementMock.messageNote),
    ]);
  }

  Widget _row(Conversation chat) {
    final unread = chat.unread > 0;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
            color: unread ? DeskColors.green50 : DeskColors.white,
            border: const Border(bottom: BorderSide(color: DeskColors.ink100))),
        child: Row(children: [
          DeskAvatar(initials: chat.initials),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Text(chat.name,
                      style: AppTextStyles.body(
                          size: 13,
                          weight: unread ? FontWeight.w700 : FontWeight.w600,
                          color: DeskColors.ink900)),
                  const SizedBox(width: 8),
                  deskText(chat.role, mono: true, color: DeskColors.ink500),
                ]),
                const SizedBox(height: 5),
                Text(chat.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body(
                        size: 12,
                        weight: unread ? FontWeight.w600 : FontWeight.w400,
                        color: unread ? DeskColors.ink900 : DeskColors.ink500)),
              ])),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            deskText(chat.elapsed, mono: true, color: DeskColors.ink500),
            const SizedBox(height: 6),
            if (unread)
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: DeskColors.green800,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('${chat.unread}',
                      style: AppTextStyles.mono(
                          size: 10, color: DeskColors.white)))
            else
              const Icon(Icons.done_all, size: 15, color: DeskColors.ink300),
          ]),
        ]));
  }
}
