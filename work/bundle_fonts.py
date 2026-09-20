from pathlib import Path
import re,urllib.request,hashlib,concurrent.futures
root=Path('C:/Users/PC/AppData/Local/Pub/Cache/hosted/pub.dev/google_fonts-6.3.3/lib/src/google_fonts_parts')
out=Path('assets/fonts');out.mkdir(parents=True,exist_ok=True)
tasks=[]
for method,family,part in [('fraunces','Fraunces','f'),('inter','Inter','i'),('jetBrainsMono','JetBrainsMono','j')]:
    text=(root/f'part_{part}.g.dart').read_text(encoding='utf-8').split(f'static TextStyle {method}(')[1].split('return googleFontsTextStyle')[0]
    for weight,style,sha,count in re.findall(r'fontWeight: FontWeight.w(\d+),\s+fontStyle: FontStyle.(\w+),\s+\): GoogleFontsFile\(\s+\x27([a-f0-9]+)\x27,\s+(\d+)',text):
        if int(weight) < 400: continue
        name={'400':'Regular','500':'Medium','600':'SemiBold','700':'Bold','800':'ExtraBold','900':'Black'}[weight]
        if style=='italic': name=('' if name=='Regular' else name)+'Italic'
        tasks.append((f'{family}-{name}.ttf',sha,int(count)))
def fetch(t):
    name,sha,count=t
    raw=urllib.request.urlopen('https://fonts.gstatic.com/s/a/'+sha+'.ttf',timeout=30).read()
    assert len(raw)==count and hashlib.sha256(raw).hexdigest()==sha
    (out/name).write_bytes(raw)
    return name
with concurrent.futures.ThreadPoolExecutor(max_workers=6) as pool:
    print('\n'.join(pool.map(fetch,tasks)))
for family,folder in [('Fraunces','fraunces'),('Inter','inter'),('JetBrainsMono','jetbrainsmono')]:
    (out/f'{family}-OFL.txt').write_bytes(urllib.request.urlopen(f'https://raw.githubusercontent.com/google/fonts/main/ofl/{folder}/OFL.txt',timeout=30).read())
