"""
 Author: ahmubashshir
 Inspired by: slapelachie and github:DAgostinatrice/HQMediaPlayer
 A Discord RPC hook for the trackma client.
 Place under ~/.config/trackma/hooks/

 use images from pypresence-assets dir
 when creating discord application
"""
import os

from threading import Thread
from time import time
from asyncio import (new_event_loop as new_loop,
                     set_event_loop as set_loop)
from pypresence.client import Client
from pypresence.exceptions import InvalidID, InvalidPipe
from trackma.engine import Engine
from trackma.utils import (estimate_aired_episodes,
                           TRACKER_PLAYING as PLAYING,
                           TRACKER_IGNORED as IGNORED)


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
    _last_run = 0
    _errors = (
        ConnectionRefusedError,
        InvalidID,
        InvalidPipe,
        FileNotFoundError,
        ConnectionResetError,
    )

    def __init__(self, *args, **kwargs):
        for attr in ['regret']:
            if attr in kwargs:
                setattr(self, attr, kwargs[attr])
                del kwargs[attr]

        super().__init__(*args, **kwargs)
        self._pid = os.getpid()

        self._details = {
            'details': "Regretting...",
            'state': None,
            'pos': None,
            'img': None,
            'txt': None
        }

    def present(
        self, engine: Engine, pos: int = None,
        details: str = "Regretting...", state: str = None
    ):
        """
        Set status for DiscordRPC.
        """
        self._details = {
            'details': details,
            'state': state,
            'pos': pos,
            'img': engine.account["api"],
            'txt': "{} at {}".format(
                engine.account["username"],
                engine.account["api"]
            )
        }

    def run(self):
        set_loop(new_loop())
        while True:
            try:
                self._reconnect()
                if self._enabled:
                    if time() - self._last_run <= 0.25:
                        continue
                    self._last_run = time()

                    if self._details['details'] == "Regretting..." \
                            and not self.regret:
                        self._rpc.clear_activity(pid=self._pid)
                    else:
                        self._rpc.set_activity(
                            pid=self._pid,
                            large_image="icon",
                            large_text=self._details['details'],
                            small_image=self._details['img'],
                            small_text=self._details['txt'],
                            details=self._details['details'],
                            state=self._details['state'],
                            start=time() * 1000 - self._details['pos']
                            if self._details['pos'] else None
                        )
            except self._errors:
                self._enabled = False
                try:
                    self._rpc.close()
                except AttributeError:
                    pass

    def _reconnect(self):
        if not self._enabled:
            try:
                self._rpc = Client(self._client_id)
                self._rpc.start()
                self._enabled = True
            except self._errors:
                self._enabled = False


rpc = DiscordRPC(daemon=True, regret=False)


def init(engine):
    """
    Initialize this hook.
    """
    rpc.start()
    rpc.present(engine)


def destroy(engine):
    engine.msg.debug("presence", "Destroyed")


def tracker_state(engine, status):
    """
    Update status in thread.
    """
    print(status)
    if status["state"] in [PLAYING, IGNORED]:
        show = status["show"][0]
        title = show["titles"][0]
        episode = status["show"][-1]
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
                        )
                        )
        else:
            rpc.present(engine,
                        status["viewOffset"],
                        "{}".format(title),
                        "Watching episode {} of {}".format(
                            episode,
                            total
                        )
                        )

    else:
        rpc.present(engine)
