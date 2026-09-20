from pathlib import Path
import re
p=Path(r'C:/Users/PC/Ferramentas/_IA/Codex/INDICE_DE_PROJETOS.md')
s=p.read_text(encoding='utf-8')
row='| EduTrack Flutter — interface de gestão T08–T12 | Em andamento | `C:\\Users\\PC\\Desktop\\edutrack-final-flutter-main` | https://github.com/Enzo-Grisolia/edutrack-final-flutter (referência do README; sem envio nesta sessão) | 2026-09-20: ajustes visuais e navegação DEMO; testes e build Web verificados; revisão cruzada pendente. Cópia local preservada. |\n'
if 'edutrack-final-flutter-main' not in s:
    s=re.sub(r'\n+## Estados usados', lambda m:'\n'+row+'\n## Estados usados',s)
s=s.replace('Última atualização: 2026-09-19','Última atualização: 2026-09-20')
p.write_text(s,encoding='utf-8')
