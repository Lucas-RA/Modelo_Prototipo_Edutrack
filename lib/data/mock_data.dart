import '../models/badge_item.dart';
import '../models/certificate.dart';
import '../models/class_session.dart';
import '../models/content_trail.dart';
import '../models/journey_event.dart';
import '../models/mission.dart';
import '../models/partner.dart';
import '../models/quiz_question.dart';
import '../models/quiz_set.dart';
import '../models/student.dart';
import '../models/vocational_question.dart';
import '../models/vocational_result.dart';

class MockData {
  MockData._();

  static const partners = <Partner>[
    Partner(id: 'senai', name: 'SENAI', category: 'Indústria', emoji: '🏭'),
    Partner(id: 'senac', name: 'SENAC', category: 'Comércio', emoji: '🛍️'),
    Partner(id: 'alicerce', name: 'Alicerce', category: 'Reforço escolar', emoji: '📘'),
    Partner(id: 'eurofarma', name: 'Instituto Eurofarma', category: 'Farmacêutico', emoji: '💊'),
  ];

  static const student = Student(
    name: 'Lucas Rodrigues',
    firstName: 'Lucas',
    partner: 'Instituto Eurofarma',
    level: 7,
    levelTitle: 'Explorador',
    currentXp: 1240,
    nextLevelXp: 2000,
  );

  static const vocationalQuestions = <VocationalQuestion>[
    VocationalQuestion(
      eyebrow: 'Em uma tarde livre, o que mais te empolga?',
      question: 'Qual atividade você escolheria?',
      options: [
        VocationalOption(letter: 'A', text: 'Liderar um projeto e organizar a equipe', profile: 'Perfil: Empreendedor'),
        VocationalOption(letter: 'B', text: 'Resolver um problema lógico ou de cálculo', profile: 'Perfil: Investigativo'),
        VocationalOption(letter: 'C', text: 'Criar um conteúdo ou ilustração', profile: 'Perfil: Artístico'),
        VocationalOption(letter: 'D', text: 'Cuidar e orientar outras pessoas', profile: 'Perfil: Social'),
      ],
    ),
    VocationalQuestion(
      eyebrow: 'No laboratório da escola técnica, você prefere…',
      question: 'Qual tarefa te chama mais atenção?',
      options: [
        VocationalOption(letter: 'A', text: 'Seguir o protocolo com precisão', profile: 'Perfil: Convencional'),
        VocationalOption(letter: 'B', text: 'Testar uma hipótese nova', profile: 'Perfil: Investigativo'),
        VocationalOption(letter: 'C', text: 'Explicar o experimento pros colegas', profile: 'Perfil: Social'),
        VocationalOption(letter: 'D', text: 'Montar o equipamento do zero', profile: 'Perfil: Realista'),
      ],
    ),
    VocationalQuestion(
      eyebrow: 'Um projeto em grupo está travado.',
      question: 'O que você faz primeiro?',
      options: [
        VocationalOption(letter: 'A', text: 'Reorganizo as tarefas do time', profile: 'Perfil: Empreendedor'),
        VocationalOption(letter: 'B', text: 'Ouço cada um pra entender o impasse', profile: 'Perfil: Social'),
        VocationalOption(letter: 'C', text: 'Analiso os dados do que deu errado', profile: 'Perfil: Investigativo'),
        VocationalOption(letter: 'D', text: 'Coloco a mão na massa e conserto', profile: 'Perfil: Realista'),
      ],
    ),
    VocationalQuestion(
      eyebrow: 'Escolhendo uma disciplina eletiva.',
      question: 'Qual delas você escolheria sem pensar duas vezes?',
      options: [
        VocationalOption(letter: 'A', text: 'Introdução à Farmacotécnica', profile: 'Perfil: Investigativo'),
        VocationalOption(letter: 'B', text: 'Oficina de comunicação', profile: 'Perfil: Social'),
        VocationalOption(letter: 'C', text: 'Gestão de processos e qualidade', profile: 'Perfil: Convencional'),
        VocationalOption(letter: 'D', text: 'Empreendedorismo aplicado', profile: 'Perfil: Empreendedor'),
      ],
    ),
  ];

  static const todayClass = ClassSession(
    id: 'cls-001',
    subject: 'Boas Práticas de Fabricação',
    partner: 'Instituto Eurofarma',
    time: '14h–16h',
    instructor: 'Profa. Renata Souza',
    presenceConfirmed: true,
    description:
        'Aula prática sobre normas de BPF (Boas Práticas de Fabricação) aplicadas à '
        'produção farmacêutica: paramentação, controle de contaminação cruzada e '
        'registro de desvios em linha de produção.',
    topics: [
      'Paramentação e fluxo de pessoal em área limpa',
      'Controle de contaminação cruzada',
      'Registro e tratamento de desvios',
      'Estudo de caso: lote em quarentena',
    ],
  );

  static const missions = <Mission>[
    Mission(
      id: 'mis-checkin',
      title: 'Check-in emocional',
      subtitle: 'Concluída · ontem',
      xpReward: 50,
      status: MissionStatus.done,
      progress: 1.0,
    ),
    Mission(
      id: 'mis-quiz',
      title: 'Faça 3 quizzes',
      subtitle: '2 de 3 concluídos',
      xpReward: 150,
      status: MissionStatus.pending,
      progress: 0.66,
    ),
    Mission(
      id: 'mis-video',
      title: 'Assista 2 aulas completas',
      subtitle: '1 de 2 concluídas',
      xpReward: 100,
      status: MissionStatus.pending,
      progress: 0.5,
    ),
  ];

  static const trails = <ContentTrail>[
    ContentTrail(
      id: 'trail-bpf',
      category: 'Qualidade',
      title: 'Boas Práticas de Fabricação',
      moduleInfo: 'Módulo 3 de 5',
      progress: 0.58,
      remainingLessons: 4,
      description:
          'Trilha completa sobre normas de qualidade e fabricação farmacêutica, '
          'da paramentação ao registro de desvios, com aulas síncronas e quizzes.',
    ),
    ContentTrail(
      id: 'trail-excel',
      category: 'Carreira',
      title: 'Excel Avançado para o Chão de Fábrica',
      moduleInfo: 'Módulo 1 de 3',
      progress: 0.20,
      remainingLessons: 6,
      description:
          'Planilhas de controle de produção, fórmulas de indicadores e '
          'dashboards simples para acompanhar metas de turno.',
    ),
    ContentTrail(
      id: 'trail-soft',
      category: 'Soft skills',
      title: 'Comunicação em Equipes de Produção',
      moduleInfo: 'Módulo 2 de 4',
      progress: 0.35,
      remainingLessons: 5,
      description:
          'Como reportar desvios, dar feedback ao turno seguinte e se comunicar '
          'com clareza em ambientes regulados.',
    ),
  ];

  static const quizSets = <QuizSet>[
    QuizSet(
      id: 'quiz-qualidade',
      title: 'Boas Práticas de Fabricação',
      category: 'Qualidade',
      questions: [
        QuizQuestion(
          trailTag: 'Qualidade básica',
          questionNumber: 1,
          totalQuestions: 4,
          xpReward: 30,
          question: 'Em um lote com desvio identificado, qual é o primeiro passo correto?',
          options: [
            QuizOption(letter: 'A', text: 'Registrar o desvio e isolar o lote'),
            QuizOption(letter: 'B', text: 'Descartar o lote imediatamente'),
            QuizOption(letter: 'C', text: 'Liberar o lote e registrar depois'),
            QuizOption(letter: 'D', text: 'Ignorar, pois é um desvio pequeno'),
          ],
          correctLetter: 'A',
        ),
        QuizQuestion(
          trailTag: 'Qualidade básica',
          questionNumber: 2,
          totalQuestions: 4,
          xpReward: 30,
          question: 'Qual paramentação é obrigatória antes de entrar na área de produção?',
          options: [
            QuizOption(letter: 'A', text: 'Apenas jaleco'),
            QuizOption(letter: 'B', text: 'Touca, luvas, jaleco e propés'),
            QuizOption(letter: 'C', text: 'Nenhuma, se a visita for rápida'),
            QuizOption(letter: 'D', text: 'Só luvas'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Qualidade básica',
          questionNumber: 3,
          totalQuestions: 4,
          xpReward: 30,
          question: 'O que caracteriza contaminação cruzada na produção farmacêutica?',
          options: [
            QuizOption(letter: 'A', text: 'Erro apenas de digitação em relatório'),
            QuizOption(letter: 'B', text: 'Transferência indevida de material entre produtos'),
            QuizOption(letter: 'C', text: 'Atraso na entrega do lote'),
            QuizOption(letter: 'D', text: 'Falta de assinatura no formulário'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Qualidade básica',
          questionNumber: 4,
          totalQuestions: 4,
          xpReward: 30,
          question: 'Quem deve ser notificado imediatamente após um desvio crítico?',
          options: [
            QuizOption(letter: 'A', text: 'Ninguém, resolve-se no próximo turno'),
            QuizOption(letter: 'B', text: 'Apenas o colega ao lado'),
            QuizOption(letter: 'C', text: 'O responsável pela qualidade'),
            QuizOption(letter: 'D', text: 'Só o RH'),
          ],
          correctLetter: 'C',
        ),
      ],
    ),
    QuizSet(
      id: 'quiz-excel',
      title: 'Excel para o Chão de Fábrica',
      category: 'Carreira',
      questions: [
        QuizQuestion(
          trailTag: 'Excel básico',
          questionNumber: 1,
          totalQuestions: 4,
          xpReward: 25,
          question: 'Qual fórmula soma automaticamente os valores de A1 até A10?',
          options: [
            QuizOption(letter: 'A', text: '=SOMA(A1:A10)'),
            QuizOption(letter: 'B', text: '=TOTAL(A1-A10)'),
            QuizOption(letter: 'C', text: '=A1+A10'),
            QuizOption(letter: 'D', text: '=MEDIA(A1:A10)'),
          ],
          correctLetter: 'A',
        ),
        QuizQuestion(
          trailTag: 'Excel básico',
          questionNumber: 2,
          totalQuestions: 4,
          xpReward: 25,
          question: 'Para destacar automaticamente células com produção abaixo da meta, qual recurso usar?',
          options: [
            QuizOption(letter: 'A', text: 'Congelar painéis'),
            QuizOption(letter: 'B', text: 'Formatação condicional'),
            QuizOption(letter: 'C', text: 'Validação de dados'),
            QuizOption(letter: 'D', text: 'Classificar e filtrar'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Excel básico',
          questionNumber: 3,
          totalQuestions: 4,
          xpReward: 25,
          question: 'A função PROCV serve principalmente para:',
          options: [
            QuizOption(letter: 'A', text: 'Formatar números como moeda'),
            QuizOption(letter: 'B', text: 'Buscar um valor em outra tabela a partir de uma referência'),
            QuizOption(letter: 'C', text: 'Criar gráficos automaticamente'),
            QuizOption(letter: 'D', text: 'Proteger a planilha com senha'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Excel básico',
          questionNumber: 4,
          totalQuestions: 4,
          xpReward: 25,
          question: 'Qual gráfico é mais indicado para comparar a produção de 5 turnos diferentes?',
          options: [
            QuizOption(letter: 'A', text: 'Gráfico de pizza'),
            QuizOption(letter: 'B', text: 'Gráfico de dispersão'),
            QuizOption(letter: 'C', text: 'Gráfico de barras'),
            QuizOption(letter: 'D', text: 'Nenhum, tabela é suficiente'),
          ],
          correctLetter: 'C',
        ),
      ],
    ),
    QuizSet(
      id: 'quiz-comunicacao',
      title: 'Comunicação em Equipes de Produção',
      category: 'Soft skills',
      questions: [
        QuizQuestion(
          trailTag: 'Comunicação',
          questionNumber: 1,
          totalQuestions: 4,
          xpReward: 20,
          question: 'Ao passar o turno para o próximo colega, o mais importante é:',
          options: [
            QuizOption(letter: 'A', text: 'Falar rápido para não atrasar a saída'),
            QuizOption(letter: 'B', text: 'Registrar e comunicar pendências com clareza'),
            QuizOption(letter: 'C', text: 'Deixar só o supervisor explicar depois'),
            QuizOption(letter: 'D', text: 'Não mencionar problemas para não gerar conflito'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Comunicação',
          questionNumber: 2,
          totalQuestions: 4,
          xpReward: 20,
          question: 'Um feedback construtivo deve ser, acima de tudo:',
          options: [
            QuizOption(letter: 'A', text: 'Genérico, para não constranger ninguém'),
            QuizOption(letter: 'B', text: 'Específico, respeitoso e focado em melhorar algo'),
            QuizOption(letter: 'C', text: 'Dado só quando algo dá muito errado'),
            QuizOption(letter: 'D', text: 'Feito publicamente, na frente de todos'),
          ],
          correctLetter: 'B',
        ),
        QuizQuestion(
          trailTag: 'Comunicação',
          questionNumber: 3,
          totalQuestions: 4,
          xpReward: 20,
          question: 'Ao reportar um desvio ao tutor, o que ajuda mais a resolver rápido?',
          options: [
            QuizOption(letter: 'A', text: 'Descrever o que aconteceu, quando e o impacto observado'),
            QuizOption(letter: 'B', text: 'Só dizer "deu problema na linha"'),
            QuizOption(letter: 'C', text: 'Esperar alguém perceber sozinho'),
            QuizOption(letter: 'D', text: 'Enviar uma mensagem sem contexto'),
          ],
          correctLetter: 'A',
        ),
        QuizQuestion(
          trailTag: 'Comunicação',
          questionNumber: 4,
          totalQuestions: 4,
          xpReward: 20,
          question: 'Durante um desentendimento com um colega de turno, a melhor atitude é:',
          options: [
            QuizOption(letter: 'A', text: 'Evitar o assunto para sempre'),
            QuizOption(letter: 'B', text: 'Ouvir o outro lado antes de responder'),
            QuizOption(letter: 'C', text: 'Levar direto para o RH sem conversar'),
            QuizOption(letter: 'D', text: 'Comentar com outros colegas primeiro'),
          ],
          correctLetter: 'B',
        ),
      ],
    ),
  ];

  static const badges = <BadgeItem>[
    BadgeItem(id: 'b1', name: 'Presença Perfeita', detail: '30 dias', emoji: '🎯', unlocked: true),
    BadgeItem(id: 'b2', name: 'Quiz Master', detail: '+90% de acerto', emoji: '🧠', unlocked: true),
    BadgeItem(id: 'b3', name: 'Primeira Trilha', detail: 'Concluída', emoji: '🏁', unlocked: true),
    BadgeItem(id: 'b4', name: 'Engajado', detail: '15 dias seguidos', emoji: '🔥', unlocked: false),
    BadgeItem(id: 'b5', name: 'Mentor', detail: 'Ajude 3 colegas', emoji: '🤝', unlocked: false),
    BadgeItem(id: 'b6', name: 'Vocação Definida', detail: 'Teste Holland', emoji: '🧭', unlocked: false),
  ];

  static const certificates = <Certificate>[
    Certificate(id: 'c1', title: 'Boas Práticas de Fabricação', issuer: 'Eurofarma', date: 'jun 2026', workload: '40h'),
    Certificate(id: 'c2', title: 'Excel Avançado', issuer: 'Eurofarma', date: 'mar 2026', workload: '20h'),
  ];

  static const vocationalResults = <VocationalResult>[
    VocationalResult(trait: 'Realista', value: 0.70, deltaPercent: 25),
    VocationalResult(trait: 'Investigativo', value: 0.55, deltaPercent: 15),
    VocationalResult(trait: 'Social', value: 0.30, deltaPercent: -10),
  ];

  static const journey = <JourneyEvent>[
    JourneyEvent(title: 'Onboarding', subtitle: 'jan 2024 · teste Holland inicial'),
    JourneyEvent(title: '1ª trilha concluída', subtitle: 'ago 2024 · Fundamentos de Qualidade'),
    JourneyEvent(title: 'Certificado emitido', subtitle: 'mar 2026 · Excel Avançado'),
  ];
}
