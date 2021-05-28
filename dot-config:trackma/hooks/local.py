from subprocess import call, getoutput as get
from os import path
from trackma import utils
from gi import require_version  # nopep8

require_version('Notify', '0.7')  # nopep8
require_version('GdkPixbuf', '2.0')  # nopep8
require_version('GLib', '2.0')  # nopep8

from gi.repository import Notify, GdkPixbuf, GLib, Gio
from trackma.utils import (EngineError,
                           TRACKER_PLAYING as PLAYING,
                           TRACKER_IGNORED as IGNORED)


notif = None
icon_path = '/usr/share/icons/Papirus-Dark/64x64/apps/trackma.svg'
icon_pixbuf = None
was_playing = False


def init(engine):
    global notif, icon_pixbuf
    Notify.init("Trackma")
    icon_pixbuf = GdkPixbuf.Pixbuf.new_from_file(icon_path)

    notif = Notify.Notification.new("Trackma", "Trackma started.", "face-wink")
    notif.set_image_from_pixbuf(icon_pixbuf)
    notif.set_urgency(Notify.Urgency.LOW)
    notif.set_timeout(500)
    try:
        notif.show()
    except GLib.Error:
        pass

    notif.set_hint('desktop-entry', GLib.Variant.new_string('trackma-gtk'))
    notif.set_hint('transient', GLib.Variant.new_boolean(True))


def playing(engine, show, is_playing, episode):
    if not is_playing or engine.config['tracker_type'] == 'local':
        playback_status(engine, show, is_playing, False, episode)


def tracker_state(engine, status):
    if status["state"] in [PLAYING, IGNORED] and engine.config['tracker_type'] != 'local':
        show = status['show'][0]
        episode = status['show'][1]
        is_playing = not status['paused']
        global was_playing
        if was_playing != is_playing:
            playback_status(engine, show, is_playing, True, episode)
        was_playing = is_playing


def playback_status(engine, show, is_playing, is_open, episode):
    def rounded(_path, rad=10):
        from io import BytesIO
        if path.isfile(_path):
            try:
                from PIL import Image, ImageDraw
                im = Image.open(_path)
                circle = Image.new('L', (rad * 2, rad * 2), 0)
                draw = ImageDraw.Draw(circle)
                draw.ellipse((0, 0, rad * 2, rad * 2), fill=255)
                alpha = Image.new('L', im.size, 255)
                w, h = im.size
                alpha.paste(circle.crop((0, 0, rad, rad)), (0, 0))
                alpha.paste(circle.crop((0, rad, rad, rad * 2)), (0, h - rad))
                alpha.paste(circle.crop((rad, 0, rad * 2, rad)), (w - rad, 0))
                alpha.paste(circle.crop(
                    (rad, rad, rad * 2, rad * 2)), (w - rad, h - rad))
                im.putalpha(alpha)
                IM = BytesIO()
                im.save(IM, format='png')
                im = IM.getvalue()
                IM.close()
            except ModuleNotFoundError:
                with open(_path, 'rb') as f:
                    im = f.read()
            try:
                loader = GdkPixbuf.PixbufLoader.new_with_type('png')
                loader.write(im)
                pixbuf = loader.get_pixbuf()
                loader.close()
                return pixbuf
            except:
                pass
        return icon_pixbuf

    filename = utils.to_cache_path(
        "%s_%s_%s.jpg" % (engine.api_info['shortname'],
                          engine.api_info['mediatype'],
                          show['id']))
    notif.update(
        "Playing" if is_playing else ("Paused" if is_open else "Stopped"),
        "%s %d" % (
            show['title'],
            episode
        ),
        'trackma'
    )
    notif.set_image_from_pixbuf(
        rounded(
            filename
        )
    )
    try:
        notif.show()
    except GLib.Error:
        pass


def status_changed(engine, show, old_status):
    finished_status = engine.mediainfo['statuses_finish']
    if show['my_status'] in finished_status:
        show_path = None
        show_info = engine.get_show_info(show['id'])
        for i in reversed(range(1, int(show['total']))):
            try:
                ep_path = engine.get_episode_path(show_info, i)
                show_path = path.dirname(ep_path) \
                    if path.dirname(ep_path) != '/mnt/Multimedia/Animation/English' \
                    else ep_path
                break
            except EngineError:
                pass
        if not (show_path and path.exists(show_path)):
            return
        GFile = Gio.File.new_for_path(show_path)
        GFileInfo = GFile.query_info(
            "metadata::emblems", Gio.FileQueryInfoFlags.NONE, None)
        show_emblems = GFileInfo.get_attribute_stringv('metadata::emblems')
        if not 'checkmark' in show_emblems:
            show_emblems.append('checkmark')
            while '' in show_emblems:
                show_emblems.remove('')
            GFileInfo.set_attribute_stringv("metadata::emblems", show_emblems)
            GFile.set_attributes_from_info(
                GFileInfo, Gio.FileQueryInfoFlags.NONE)
            call(['touch', '-d', get('date -R -r "%s"' % show_path), show_path])
            engine.msg.info(
                'Emblem', "Checked show(%s) as finished." % show['id'])

# These functions are called when the change is made remotely.


def sync_complete(engine, items):
    lines = []
    for show, data in items:
        try:
            lines.append(
                """Action: %(action)-10sID: <a href="%(url)s">%(id)d</a>""" % {**show, **data})
        except:
            pass
    _notif = Notify.Notification.new("Summery", '\n'.join(lines), 'face-tired')
    _notif.set_image_from_pixbuf(icon_pixbuf)
    _notif.set_timeout(20000)
    try:
        _notif.show()
    except GLib.Error:
        pass
    del _notif
