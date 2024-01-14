"""
 Author: ahmubashshir
 Inspired by: slapelachie and github:DAgostinatrice/HQMediaPlayer
 A Discord RPC hook for the trackma client.
 Place under ~/.config/trackma/hooks/

 use images from pypresence-assets dir
 when creating discord application
"""
import os
import sys

from threading import Thread, Event
from time import time, sleep
from struct import error as StructError
from asyncio import (new_event_loop as new_loop,
                     set_event_loop as set_loop)
from pypresence.client import Client

from pypresence.exceptions import InvalidID, InvalidPipe, DiscordNotFound, DiscordError
from trackma.engine import Engine
from trackma.utils import (estimate_aired_episodes,
                           Tracker)


class DiscordRPC(Thread):
    """
    Discord RPC Thread

    Updates discord rich presence status periodically.
    """
    regret: bool = True

    _rpc = None
    _client_id = "777075127266705408"  # set discord application id here
    _enabled = False
    _pid = None
    _quit = None
    _errors = (
        ConnectionRefusedError,
        InvalidPipe,
        FileNotFoundError,
        ConnectionResetError,
        StructError,
        DiscordError,
        DiscordNotFound,
        InvalidID,
    )

    def __init__(self, *args, **kwargs):
        for attr in ['regret']:
            if attr in kwargs:
                setattr(self, attr, kwargs[attr])
                del kwargs[attr]

        super().__init__(*args, **kwargs)
        self._quit = Event()
        self._pid = os.getpid()

        self._details = {
            'details': "Regretting...",
            'state': None,
            'pos': None,
            'img': None,
            'txt': None
        }

    def stop(self):
        self._quit.set()

    def present(
        self, engine: Engine, pos: int = None,
        details: str = "Regretting...", state: str = None,
        url: str = None, thumb: str = "icon"
    ):
        """
        Set status for DiscordRPC.
        """
        self._details = {
            'details': details,
            'state': state,
            'pos': pos,
            'thumb': thumb,
            'buttons': [{
                "label": "View %s" % engine.api_info['mediatype'].capitalize(),
                "url": url
            }] if url else None,
            'img': engine.account["api"],
            'txt': "{} at {}".format(
                engine.account["username"],
                engine.account["api"]
            )
        }

    def run(self):
        set_loop(new_loop())
        while not self._quit.wait(0.25):
            try:
                self._reconnect()
                if self._quit.is_set() and self._enabled:
                    self._rpc.clear_activity(pid=self._pid)
                elif self._enabled and not self._quit.is_set():
                    if self._details['details'] == "Regretting..." and not self.regret:
                        self._rpc.clear_activity(pid=self._pid)
                    else:
                        self._rpc.set_activity(
                            pid=self._pid,
                            large_image=self._details['thumb'],
                            large_text=self._details['details'],
                            small_image=self._details['img'],
                            small_text=self._details['txt'],
                            buttons=self._details['buttons'],
                            details=self._details['details'],
                            state=self._details['state'],
                            start=time() * 1000 - int(self._details['pos'])
                            if self._details['pos'] else None
                        )
            except self._errors:
                self._enabled = False
                try:
                    self._rpc.close()
                except:
                    pass
        print("Trackma (%s): Closing connection to discord." %
              (__package__ or __name__))
        sys.exit(0)

    def _reconnect(self):
        if not self._enabled:
            try:
                self._rpc = Client(self._client_id)
                self._rpc.start()
                self._enabled = True
            except self._errors:
                self._enabled = False


rpc = DiscordRPC(regret=False)


def init(engine):
    """
    Initialize this hook.
    """
    rpc.start()
    rpc.present(engine)


def destroy(engine):
    rpc.stop()


def tracker_state(engine, status):
    """
    Update status in thread.
    """
    if status["state"] in [Tracker.PLAYING, Tracker.IGNORED]:
        show = status["show"][0]
        title = show["titles"][0]
        episode = status["show"][-1]
        url = engine.get_show_info(show['id'])["url"]
        thumb = engine.get_show_info(show['id'])["image"]
        total = show["total"] or estimate_aired_episodes(
            engine.get_show_info(show['id'])
        ) or '?'

        if status["paused"]:
            rpc.present(engine,
                        status["viewOffset"],
                        "{}".format(title),
                        "Paused episode {} of {}".format(
                            episode,
                            total
                        ),
                        url,
                        thumb
                        )
        else:
            rpc.present(engine,
                        status["viewOffset"],
                        "{}".format(title),
                        "Watching episode {} of {}".format(
                            episode,
                            total
                        ),
                        url,
                        thumb
                        )

    else:
        rpc.present(engine)
