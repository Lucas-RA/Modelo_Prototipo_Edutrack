# T-001 · revisão cruzada r1 — claude

Escopo: gestão T08–T12 (lib/web/desktop/**, lib/models/management.dart, lib/data/management_mock_data.dart, atalho em lib/screens/home/home_screen.dart, test/widget_test.dart).

Evidência própria executada em 2026-09-20:
- `flutter analyze --no-pub`: 38 issues, todos info/warning pré-existentes em telas do aluno/apresentação; nenhum item em gestão, modelos ou dados.
- `flutter test --no-pub`: 3/3 passaram.
- `flutter build web --no-pub`: exit 0.
- Conferência numérica independente (script temporário, removido): média de frequência da turma 82,8% e média Moodle 76,3% batem com os KPIs de T09; média de frequência do scatter 81,2% bate com o KPI "81%" de T10; 842/1558 = 54% em T11; 257+58+27 = 342; 24 presentes / 4 ausentes / 2 justificadas batem com os KPIs de T08; 3 alunos de risco alto batem com "Em risco 3".

Constraints: C1 banner presente em T08; C2 console com WRN e encaminhamento manual + bloco de configurações em T12; C3 breakdown fixo de fatores, sem função de cálculo de score no código; C4 check-in só agregado e `attentionReason` sem conteúdo emocional (coberto por teste); C5 avisos de retenção/consentimento; C6 menu muda por perfil e dashboards agregados.

## Achados

### MEDIO — rótulo de variação do ESG contradiz a série
Local: lib/data/management_mock_data.dart — `esgKpis` ("+312 vs. 2025", "+298 vs. 2025").
Impacto: 2026 é parcial/projetado (312 formandos, 298 certificados) contra 2025 (486 e 441). O rótulo com sinal "+" lê-se como crescimento, enquanto o valor é o parcial e está abaixo do ano anterior.
Correção: ou trocar por variação real (ex.: "−174 vs. 2025" / "parcial até maio"), ou reescrever o rótulo como "2026 parcial".

### MEDIO — ranking de T10 usa identificador fictício no lugar do nome
Local: lib/web/desktop/screens/dashboard_evasao_screen.dart — `_ranking` ("Aluno A08", avatar "ID").
Impacto: o documento (seção 5, T10) pede "avatar + nome" na tabela; a escolha conservadora atende C6, mas diverge do pedido. Decisão em aberto, registrada pela executora e ainda sem resposta do usuário.
Correção: decisão do usuário. Se optar por nomes, usar os nomes fictícios já existentes no mock.

### BAIXO — altura da barra do check-in com máximo fixo
Local: lib/web/desktop/screens/painel_turma_screen.dart — `height: level.$2 / 9 * 90`.
Impacto: o divisor 9 é o maior valor do mock atual. Qualquer contagem maior estoura a caixa de 90px (overflow de render).
Correção: derivar o máximo de `ManagementMock.mood.levels`.

### BAIXO — presença pareada por índice, não por id
Local: lib/web/desktop/screens/presenca_screen.dart — `ManagementMock.attendance[index]` alinhado a `students[index]`.
Impacto: hoje as duas listas estão na mesma ordem e o resultado é correto; se qualquer uma for reordenada, a linha exibe a presença de outro aluno sem erro visível.
Correção: buscar por `studentId`.

### SUGESTAO — monoespaçada parcial em T12
Local: lib/web/desktop/screens/integracao_moodle_screen.dart — `mono: setting == ManagementMock.settings.first`.
Impacto: token, frequência e escopo são metadados técnicos e, pelo design system, deveriam usar mono; só o endpoint usa.

## Veredito
Sem achado crítico ou alto. **APROVADA_COM_RESSALVAS** — ressalvas: os dois achados MEDIO acima, sendo que o do ranking depende de decisão do usuário.

## Fechamento
- Ranking de T10: usuário decidiu ocultar o nome (2026-09-20). Ressalva encerrada, registrada em DECISIONS.md.
- Demais achados (ESG, barra do check-in, pareamento por id, mono em T12) corrigidos em T-002 pelo claude, que fica aguardando validação cruzada do codex.
