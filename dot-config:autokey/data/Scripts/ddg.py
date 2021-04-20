# Enter script code
from urllib.parse import urlencode
from time import sleep


def strip(s):
    return " ".join(n for n in s.split() if len(s) > 0)


q = ''
try:
    q = strip(clipboard.get_selection().strip())
except:
    pass

if not len(q):
    try:
        q = strip(clipboard.get_clipboard().strip())
    except:
        pass
if len(q):
    url = "https://lmddgtfy.net/?{}".format(urlencode({'q': q}))
    for key in url:
        keyboard.send_keys(key)
        sleep(0.01)
