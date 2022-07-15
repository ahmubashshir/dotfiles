local user_opts = require('opts')

return {
    TransBg = '{\\blur100\\bord140\\1c&H000000&\\3c&H000000&}',
    SeekbarBg = '{\\blur0\\bord0\\1c&HFFFFFF&}',
    SeekbarFg = '{\\blur1\\bord1\\1c&HE39C42&}',
    Ctrl1 = '{\\blur0\\bord0\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs36\\fnmaterial-design-iconic-font}',
    Ctrl2 = '{\\blur0\\bord0\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs24\\fnmaterial-design-iconic-font}',
    Ctrl3 = '{\\blur0\\bord0\\1c&HFFFFFF&\\3c&HFFFFFF&\\fs24\\fnmaterial-design-iconic-font}',
    Time = '{\\blur0\\bord0\\1c&HFFFFFF&\\3c&H000000&\\fs17\\fn' ..
        user_opts.font .. '}',
    Tooltip = '{\\blur1\\bord0.5\\1c&HFFFFFF&\\3c&H000000&\\fs18\\fn' ..
        user_opts.font .. '}',
    Title = '{\\blur1\\bord0.5\\1c&HFFFFFF&\\3c&H0\\fs48\\q2\\fn' ..
        user_opts.font .. '}',
    WinCtrl = '{\\blur1\\bord0.5\\1c&HFFFFFF&\\3c&H0\\fs20\\fnmaterial-design-iconic-font}',
    elementDown = '{\\1c&H999999&}'
}
