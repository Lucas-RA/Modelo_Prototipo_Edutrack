# Estado operacional

### 2026-09-20 — codex — T-001 — EM_ANDAMENTO
- Objetivo: reconciliar a base e ajustar a gestão T08–T12 ao documento fornecido.
- Inspeção: cinco telas já existem; não há histórico .ai nem revisão cruzada pendente.
- Achados: teste usa MyApp inexistente; presença combina color/decoration; mocks locais, parceiros financeiros e exposição emocional individual divergem do pedido.
- Validação: leitura dos arquivos; build e testes ainda não executados.
- Próximo: restaurar base, centralizar dados, unificar shell e validar as cinco telas; revisão por Claude ficará pendente.

### 2026-09-20 — codex — T-001 — EM_ANDAMENTO
- Objetivo: centralizar entidades e mocks da gestão, com tokens e componentes de apresentação.
- Arquivos: lib/models/management.dart, lib/data/management_mock_data.dart, desktop_theme.dart e desktop_widgets.dart.
- Validação: dart format executado; build ainda pendente enquanto consumidores são adaptados. Mocks: 28 alunos, 28 presenças, 342 pontos institucionais, fatores prontos e check-in agregado.
- Próximo: adaptar shell e cinco telas ao módulo comum; não retomar a execução da UI antes desse bloco terminar.

### 2026-09-20 — codex — T-001 — EM_ANDAMENTO
- Objetivo: adaptar shell e T08–T12 para desktop estático, com navegação por perfil DEMO.
- Arquivos: desktop_flow.dart, desktop_charts.dart, cinco screens da gestão e atalho HomeScreen (Navigator raiz para sair da moldura do aluno).
- Validação: dart format; teste antigo e validação de execução ainda pendentes. pub get resolveu dependências mas retornou erro de symlink Windows; tentar Web com --no-pub.
- Próximo: análise, testes de navegação/layout e consistência numérica, build e inspeção visual. C6: opção conservadora de identificadores fictícios enquanto não houver resposta.

### 2026-09-20 — codex — T-001 — EM_ANDAMENTO
- Objetivo: verificar navegação e restaurar o teste quebrado; empacotar fontes existentes para demonstração sem download de fontes.
- Arquivos: test/widget_test.dart; assets/fonts/ com licenças OFL; pubspec.yaml; mocks. SDK ajustou pubspec.lock (4 dependências transitivas) e exclusões de build em analysis_options.yaml.
- Validação: flutter test --no-pub — 3 testes passaram; flutter build web --no-pub — passou antes da inclusão das fontes locais. Analyze: sem erros de produção; avisos preexistentes nas telas do aluno/apresentação.
- Próximo: repetir build após fontes/dados, verificar navegador e concluir documentação; revisão cruzada por Claude pendente.

### 2026-09-20 — codex — T-001 — EM_ANDAMENTO
- Objetivo: revisão visual em navegador 1280×800 e correções finais.
- Arquivos: gráficos, ESG, pipeline, períodos estáticos, formatação de percentuais; README e teste de regressão da barra ESG.
- Validação: navegação real Home → gestão, cinco telas inspecionadas; corrigidas altura da barra ESG e setas sem glifo; flutter test --no-pub — 3 testes passaram novamente. dart analyze em gestão/modelos/dados — sem problemas.
- Próximo: build final e reinspeção das duas correções; atualizar índice central e deixar T-001 aguardando Claude.

### 2026-09-20 — claude — T-001 — APROVADA_COM_RESSALVAS
- Reconciliação: registro parou em EM_ANDAMENTO, mas os arquivos mostram a entrega concluída (README 13:38, cinco telas, mocks, testes). Base verificada por execução, não por leitura.
- Validação própria: flutter analyze --no-pub (38 infos/warnings pré-existentes fora da gestão); flutter test --no-pub 3/3; flutter build web --no-pub exit 0; conferência numérica independente dos KPIs de T08–T11 — coerentes com a massa.
- Revisão: .ai/reviews/T-001-r1-claude.md — sem achado crítico/alto; 2 MEDIO (rótulo de variação do ESG; ranking de T10 com identificador em vez de nome), 2 BAIXO, 1 SUGESTAO.
- Pendência: decisão do usuário sobre C6 × nome no ranking de T10 (pergunta aberta desde o Codex).
- Próximo: T-002 aplica as correções aceitas (ESG, barra do check-in, pareamento por id, mono em T12) e fica aguardando validação cruzada do Codex.

### 2026-09-20 — claude — T-002 — AUTOVALIDADA · AGUARDANDO_VALIDACAO_CRUZADA
- Objetivo: aplicar as ressalvas de T-001-r1 (exceto a do ranking, fechada por decisão do usuário: manter identificador fictício).
- Arquivos: management_mock_data.dart (rótulos ESG sem "+" enganoso; moodPeak; technicalSettings), painel_turma_screen.dart (barra do check-in escalada pelo pico real), presenca_screen.dart (presença pareada por studentId), integracao_moodle_screen.dart (mono nas 3 linhas técnicas).
- Validação: dart analyze em gestão/dados/modelos — sem problemas; flutter analyze 38 issues (mesmo total de antes, todos pré-existentes fora da gestão); flutter test --no-pub 3/3; flutter build web --no-pub exit 0; inspeção no navegador 1280×800 das cinco telas (T08 pareamento correto, T09 barras íntegras, T11 rótulos coerentes com o gráfico, T12 mono aplicada).
- Próximo: validação cruzada pelo Codex (T-002). Nenhuma pendência de implementação aberta em T08–T12.

### 2026-09-20 — claude — T-003 — AUTOVALIDADA · AGUARDANDO_VALIDACAO_CRUZADA
- Objetivo: mover o ponto de entrada da gestão para a barra superior do site, ao lado de Login, e retirá-lo do acesso do aluno (pedido do usuário; diverge da seção 2 do prompt original, que pedia o botão na Home do aluno).
- Arquivos: web_showcase_frame.dart (botão outlined "Interface Gestor" antes do Login + callback onGestor), home_screen.dart (atalho e import removidos), desktop_flow.dart ("Voltar ao site", fallback para AppRoutes.webLanding), test/widget_test.dart (novo teste do ponto de entrada no site; teste de navegação passa a abrir a rota direto), README.md.
- Validação: dart analyze lib — só avisos pré-existentes; flutter test --no-pub 4/4; flutter build web --no-pub exit 0; clique real no navegador: página inicial → gestão em um clique, sidebar com "Voltar ao site".
- Próximo: validação cruzada pelo codex (T-002 e T-003).

### 2026-09-20 — claude — T-004 — AUTOVALIDADA · AGUARDANDO_VALIDACAO_CRUZADA
- Objetivo: criar as telas restantes do educador (Painel, Relatórios, Alertas, Check-ins, Mensagens), antes apenas itens desabilitados no menu.
- Arquivos: models/management.dart (+EducatorAlert, ReportItem, CheckinParticipation, Conversation); data/management_mock_data.dart (mocks das 5 telas, 2ª turma T05 Tarde, participação, alertas, conversas); 5 telas novas em web/desktop/screens; desktop_nav.dart (enum ampliado); desktop_flow.dart (menu do educador ativo, badges 5/4, painel como tela inicial, marca da sidebar com FittedBox); test/widget_test.dart.
- Decisão C4: a tela de Check-ins mostra participação por aluno (quando respondeu) e o conteúdo emocional apenas no agregado. A descrição do pedido ("emoji/cor por aluno") violaria C4 e foi substituída por flag derivada "sinal de bem-estar: atenção".
- Correções de layout encontradas na validação: overflow de 54px na marca da sidebar (pré-existente, só visível em teste) e altura infinita no card de alerta (CrossAxisAlignment.stretch sem IntrinsicHeight).
- Validação: dart analyze lib/web/desktop lib/data lib/models — sem problemas; flutter test --no-pub 4/4 (navegação cobre as 5 telas novas + C4 na camada de dados); flutter build web --no-pub exit 0; inspeção no navegador das cinco telas.
- Próximo: validação cruzada pelo codex (T-002, T-003, T-004). Eventual tela de conversa aberta em Mensagens não foi feita (era opcional no pedido).
