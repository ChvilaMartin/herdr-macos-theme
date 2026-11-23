# Herdr picks a terminal font by family and weight only, with no italic switch.
# This copies Operator Mono's italic faces (which you must own and have installed)
# under their own family, "Operator Mono Italic Face", with the italic flags off,
# so the layout's `font` can name it. Fonts in ~/.config/herdr-app/fonts/ load on
# their own. Needs fontTools (pip install fonttools).
#   python3 scripts/operator-mono-italic.py ~/Library/Fonts ~/.config/herdr-app/fonts
import sys, os
from fontTools.ttLib import TTFont
src, out = sys.argv[1], sys.argv[2]
FAM = "Operator Mono Italic Face"
for w in ["XLight", "Light", "Book", "Medium", "Bold"]:
    f = TTFont(os.path.join(src, f"OperatorMono-{w}Italic.ttf"))
    sub = "Regular" if w == "Book" else w
    names = f["name"]
    for rec in list(names.names):
        if rec.nameID in (1, 2, 3, 4, 6, 16, 17):
            names.removeNames(nameID=rec.nameID)
    full = f"{FAM} {sub}"
    ps = f"OperatorMonoItalicFace-{sub}"
    for nid, val in [(1, FAM), (2, sub), (3, ps), (4, full), (6, ps), (16, FAM), (17, sub)]:
        names.setName(val, nid, 3, 1, 0x409)
        names.setName(val, nid, 1, 0, 0)
    os2 = f["OS/2"]
    os2.fsSelection &= ~0x0001          # not italic
    os2.fsSelection &= ~0x0200          # not oblique
    if sub == "Regular": os2.fsSelection |= 0x0040
    f["head"].macStyle &= ~0x0002
    f["post"].italicAngle = 0
    f.save(os.path.join(out, f"OperatorMonoItalicFace-{sub}.ttf"))
    print(full, os2.usWeightClass)
