# Enter script code
from urllib.parse import urlencode


def strip(s):
    return " ".join(n for n in s.split() if len(s) > 0)


cmd = ''
try:
    cmd = strip(clipboard.get_selection().strip())
except:
    pass

if not len(q):
    try:
        cmd = strip(clipboard.get_clipboard().strip())
    except:
        pass

if len(cmd):
    esh_url = "https://explainshell.com/explain?{}".format(
        urlencode({'cmd': cmd}))
    for key in esh_url:
        keyboard.send_keys(key)
        sleep(0.01)
