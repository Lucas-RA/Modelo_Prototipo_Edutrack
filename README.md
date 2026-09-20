# EduTrack 🎓

**Plataforma de engajamento e prevenção de evasão para educação profissionalizante.**

Projeto acadêmico desenvolvido para a **FIAP — Sprint 3**, tendo como parceiro o **Instituto Eurofarma**.

---

## 👥 Equipe

**Nome da equipe:** `EuroForce`

| Integrante                |     RM |
| ------------------------- | -----: |
| Enzo Grisolia de Souza    | 555706 |
| Gabriel Borges Medeiros   | 556142 |
| Guilherme de Nicola Nesti | 555044 |
| Lucas Rodrigues Alves     | 555377 |
| Matheus Lion Muzzi        | 555764 |

---

## 🎯 Objetivo do aplicativo

O **EduTrack** é uma plataforma criada para apoiar a jornada de aprendizagem de alunos de instituições parceiras de educação profissionalizante.

A solução busca aumentar o engajamento dos estudantes e contribuir para a prevenção da evasão, reunindo em uma única experiência recursos de acompanhamento acadêmico, conteúdos, gamificação e acompanhamento da evolução do aluno.

No aplicativo, o estudante pode:

* acompanhar aulas e trilhas de aprendizagem;
* responder quizzes;
* realizar missões;
* acumular XP;
* conquistar badges;
* acompanhar certificados;
* realizar check-ins periódicos;
* acompanhar sua evolução durante a jornada de aprendizagem.

O EduTrack também possui um **onboarding vocacional baseado no modelo Holland (RIASEC)**, utilizado para simular o mapeamento inicial do perfil vocacional do estudante.

Nesta Sprint foi desenvolvido um **MVP funcional e navegável em Flutter**, utilizando **dados mockados** para representar os principais comportamentos da solução.

Conforme o escopo definido para a Sprint, não são utilizadas integrações com API, Firebase, banco de dados local ou backend.

---

## 🔗 Repositório GitHub

**Repositório do projeto:**

https://github.com/Enzo-Grisolia/edutrack-final-flutter

---

## 🎥 Vídeo de demonstração

O vídeo demonstra o aplicativo em execução e apresenta os principais fluxos desenvolvidos.

**Link do vídeo:**
`https://youtu.be/VGx7gUCMXQo`

### Fluxo apresentado no vídeo

**Login → Onboarding → Home → Detalhes da Aula → Conteúdo → Quiz → Missões → Check-in → Perfil**

---

# 📱 Telas implementadas

O MVP contempla o principal fluxo de utilização do aluno, desde seu primeiro acesso até o acompanhamento de sua evolução.

> **Observação:** todas as imagens abaixo são prints reais do aplicativo em execução. Clique em qualquer imagem para visualizá-la em resolução original.

---

## 1. Login

A tela de login permite que o estudante escolha uma instituição parceira antes de acessar o aplicativo.

As instituições representadas no MVP incluem:

* Instituto Eurofarma;
* SENAI;
* SENAC;
* Alicerce.

O fluxo também demonstra componentes de formulário e interação com o usuário.

<p align="center"> <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Login-01.png"> <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Login-01.png" width="370" alt="Tela de Login do EduTrack"> </a> &nbsp;&nbsp; <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Login-02.png"> <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Login-02.png" width="370" alt="Seleção de instituição no Login"> </a> </p>

---

## 2. Onboarding Vocacional

Após o acesso, o estudante passa por um **onboarding vocacional** baseado no modelo Holland (RIASEC).

O fluxo utiliza perguntas mockadas, etapas sequenciais e barra de progresso para simular o mapeamento inicial do perfil vocacional do aluno.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Onboarding-Vocacional.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Onboarding-Vocacional.png" width="420" alt="Onboarding Vocacional do EduTrack">
  </a>
</p>

---

## 3. Home — Tela do Aluno

A Home funciona como o centro da experiência do estudante.

Nela são apresentadas informações relacionadas à jornada de aprendizagem, como:

* nível atual;
* experiência (XP);
* progresso;
* aula do dia;
* missões;
* atalhos para outras funcionalidades.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Tela-do-Aluno.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Tela-do-Aluno.png" width="420" alt="Tela principal do aluno">
  </a>
</p>

---

## 4. Hub de Aprendizagem

O Hub de Aprendizagem centraliza os conteúdos e trilhas disponíveis para o aluno.

As trilhas utilizam dados mockados relacionados ao contexto de educação profissionalizante e permitem acessar conteúdos e atividades correspondentes.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Hub-De-Aprendizagem.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-Hub-De-Aprendizagem.png" width="420" alt="Hub de Aprendizagem do EduTrack">
  </a>
</p>

---

## 5. Detalhes da Aula

Ao selecionar uma aula, o aplicativo abre uma tela específica contendo suas informações.

Esse fluxo demonstra uma das formas de **passagem de parâmetros entre telas**, utilizando o objeto correspondente à aula selecionada.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-detalhes-da-aula.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-detalhes-da-aula.png" width="420" alt="Detalhes da Aula">
  </a>
</p>

---

## 6. Conquistas e Gamificação

A solução utiliza elementos de gamificação para estimular o engajamento e a continuidade dos estudos.

O estudante pode acompanhar elementos como:

* XP;
* nível;
* badges;
* conquistas desbloqueadas;
* conquistas ainda bloqueadas.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-conquistas.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-conquistas.png" width="420" alt="Conquistas e gamificação do EduTrack">
  </a>
</p>

---

## 7. Check-in

O Check-in permite que o estudante registre informações relacionadas ao seu momento atual durante a jornada de aprendizagem.

O fluxo permite registrar percepções sobre seu estado e carga de tarefas e disponibiliza espaço para observações.

Após a interação, o aplicativo apresenta um retorno visual ao usuário.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-checkin.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-checkin.png" width="420" alt="Check-in do estudante">
  </a>
</p>

---

## 8. Perfil

A tela de Perfil reúne informações relacionadas à evolução do estudante dentro do EduTrack.

Entre as informações apresentadas estão:

* certificados;
* progresso;
* evolução do perfil vocacional;
* informações relacionadas à jornada do aluno.

<p align="center">
  <a href="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-perfil.png">
    <img src="https://raw.githubusercontent.com/Enzo-Grisolia/edutrack-final-flutter/main/prints/Print-perfil.png" width="420" alt="Perfil do estudante">
  </a>
</p>

---

# 🧭 Navegação entre telas

A navegação do projeto foi estruturada utilizando rotas do Flutter, centralizadas em:

```text
lib/routes/app_routes.dart
```

O aplicativo apresenta um fluxo conectado entre suas funcionalidades, evitando telas independentes sem relação entre si.

### Fluxo principal

```text
Login
  ↓
Onboarding Vocacional
  ↓
Home
  ├── Aula do dia → Detalhes da aula
  ├── Conteúdo → Trilha → Detalhes / Quiz
  ├── Missões e Conquistas
  ├── Check-in
  └── Perfil
```

Também é utilizada **passagem de parâmetros entre telas**, por meio de `settings.arguments`.

Entre os exemplos presentes no projeto estão:

* instituição selecionada no Login → Onboarding;
* `ClassSession` → tela de detalhes da aula;
* `ContentTrail` → tela de detalhes da trilha.

Após o onboarding, a navegação principal utiliza uma barra inferior com as áreas:

**Início · Conteúdo · Missões · Perfil**

---

# 🧩 Dados mockados

Nesta Sprint todos os dados utilizados pelo aplicativo são **mockados**, conforme solicitado.

Os principais dados estão centralizados em:

```text
lib/data/mock_data.dart
```

Os modelos utilizados estão organizados em:

```text
lib/models/
```

Entre os dados simulados estão:

* aluno;
* instituições parceiras;
* aula do dia;
* missões;
* trilhas de aprendizagem;
* quizzes;
* perguntas vocacionais;
* badges;
* certificados;
* progresso;
* jornada do estudante.

Os dados foram criados buscando representar situações coerentes com o contexto do projeto e do parceiro.

Entre os conteúdos representados estão, por exemplo:

* **Boas Práticas de Fabricação**;
* **Excel Avançado para o Chão de Fábrica**;
* **Comunicação em Equipes de Produção**.

Também são utilizadas questões relacionadas a cenários profissionais, processos de produção e qualidade.

---

# 🗂️ Arquitetura e organização do código

O projeto foi estruturado separando as responsabilidades em pastas específicas:

```text
lib/
├── main.dart
├── app.dart
│
├── data/
│   └── mock_data.dart
│
├── models/
│   ├── badge_item.dart
│   ├── certificate.dart
│   ├── class_session.dart
│   ├── content_trail.dart
│   ├── journey_event.dart
│   ├── mission.dart
│   ├── partner.dart
│   ├── quiz_question.dart
│   ├── quiz_set.dart
│   ├── student.dart
│   ├── vocational_question.dart
│   └── vocational_result.dart
│
├── routes/
│   └── app_routes.dart
│
├── screens/
│   ├── checkin/
│   ├── content/
│   ├── details/
│   ├── gamification/
│   ├── home/
│   ├── login/
│   ├── onboarding/
│   ├── profile/
│   └── shell/
│
├── theme/
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   └── app_theme.dart
│
├── widgets/
│   ├── app_card.dart
│   ├── eyebrow_label.dart
│   ├── progress_bar_widget.dart
│   └── xp_pill.dart
│
└── web/
```

## Decisões de arquitetura

Para manter o projeto organizado e facilitar sua manutenção, foram adotadas as seguintes práticas:

* separação entre modelos, dados, telas, componentes, tema e rotas;
* dados mockados centralizados;
* utilização de modelos tipados;
* componentes visuais reutilizáveis;
* rotas centralizadas;
* telas separadas por funcionalidade;
* passagem de objetos entre telas;
* utilização de `IndexedStack` para preservar o estado das abas;
* utilização de `StatefulWidget` e `setState` para estados locais.

Para o escopo deste MVP não foi necessária uma biblioteca externa de gerenciamento de estado.

---

# 🎨 Interface e experiência do usuário

O aplicativo utiliza uma identidade visual consistente baseada no Design System desenvolvido para o EduTrack.

Os elementos relacionados ao tema estão centralizados em:

```text
lib/theme/
```

O projeto utiliza componentes reutilizáveis para manter consistência visual entre diferentes telas.

Entre eles estão:

```text
AppCard
ProgressBarWidget
XpPill
EyebrowLabel
```

A interface utiliza principalmente tons de verde, lime, teal e âmbar, mantendo um padrão visual coerente durante a navegação.

---

# ▶️ Como executar o projeto

## Pré-requisitos

Para executar o projeto é necessário possuir:

* Flutter SDK instalado;
* Android Studio ou VS Code;
* Android SDK configurado;
* emulador Android ou dispositivo físico.

Para verificar a configuração do ambiente:

```bash
flutter doctor
```

---

## 1. Clonar o repositório

```bash
git clone https://github.com/Enzo-Grisolia/edutrack-final-flutter.git
```

Acesse a pasta:

```bash
cd edutrack-final-flutter
```

---

## 2. Instalar as dependências

```bash
flutter pub get
```

---

## 3. Verificar os dispositivos disponíveis

```bash
flutter devices
```

---

## 4. Executar o aplicativo

Com um dispositivo conectado ou emulador aberto:

```bash
flutter run
```

Também é possível selecionar o dispositivo pelo Android Studio ou VS Code e executar o aplicativo pela própria IDE.

---

## 🌐 Executar no navegador

Para executar a versão Flutter Web utilizando o Chrome:

```bash
flutter run -d chrome
```

---

# 🧪 Fluxo sugerido para avaliação

Para visualizar as principais funcionalidades implementadas:

1. Abra o aplicativo;
2. Na tela de Login, selecione **Instituto Eurofarma**;
3. Clique em **Entrar**;
4. Responda ao onboarding vocacional;
5. Acesse a Home;
6. Abra os detalhes da aula do dia;
7. Navegue até **Conteúdo**;
8. Selecione uma trilha;
9. Interaja com o quiz;
10. Acesse **Missões/Conquistas**;
11. Realize o **Check-in**;
12. Acesse **Perfil** para visualizar a evolução do estudante.

---

# 🛠️ Tecnologias utilizadas

* **Flutter**
* **Dart**
* **Material Design**
* **Git**
* **GitHub**

---

# 📌 Escopo da Sprint 3

Conforme definido para esta Sprint, o objetivo da entrega é apresentar uma versão funcional e navegável da solução utilizando dados mockados.

Por isso, esta versão **não possui integração com:**

* API;
* Firebase;
* banco de dados local;
* backend.

O foco da entrega está em:

* experiência do usuário;
* navegação entre telas;
* simulação dos principais fluxos;
* dados mockados coerentes;
* organização do código;
* componentização;
* evidências do aplicativo funcionando.

---

## 🎓 FIAP — Sprint 3

**Projeto:** EduTrack
**Parceiro:** Instituto Eurofarma

## Interface de gestão (T08–T12)

No navegador, o botão **Interface Gestor** fica na barra superior da página inicial do site, ao lado de **Login**.
Ele abre a gestão direto, fora da moldura mobile; **Voltar ao site** retorna à apresentação.
O acesso do aluno não expõe esse atalho.
O seletor **DEMO** alterna Educador (Painel, Minha turma, Presença, Relatórios, Alertas, Check-ins, Mensagens),
Gestor (Evasão, Relatório ESG) e Admin TI (Integrações, Evasão, ESG).
A tela de Check-ins do educador mostra participação por aluno e conteúdo emocional apenas agregado, conforme C4.
Somente navegação funciona; botões de ação, busca, filtros e seletores de período são ilustrativos.

A interface foi verificada em 1280×800. A sidebar tem 190px e o conteúdo mínimo de 1100px;
quando necessário há rolagem horizontal, sem variante mobile. Presença e console possuem rolagem própria.
Dados imutáveis em `lib/data/management_mock_data.dart`, entidades em `lib/models/management.dart`.
São 28 alunos fictícios do SENAI e 342 pontos institucionais; scores e fatores são fornecidos pelo mock,
sem fórmula no aplicativo. T10 usa identificadores fictícios; T11 e o check-in emocional são agregados.
As fontes já utilizadas (Fraunces, Inter e JetBrains Mono) estão em `assets/fonts/`, com licenças OFL.

Validação: `flutter test --no-pub` e `flutter build web --no-pub` após resolver dependências.
No SDK local, `flutter pub get` resolve pacotes mas pode avisar sobre links simbólicos do Windows.
O build Web com `--no-pub` foi verificado sem habilitar Developer Mode. Isso não valida builds nativos.
A análise da gestão e seus dados passa; a análise global ainda aponta avisos anteriores em telas do aluno e na apresentação.

Continuidade e revisão cruzada: consultar `.ai/STATE.md`. Nenhum arquivo do projeto foi movido e nenhum envio ao GitHub foi realizado.
