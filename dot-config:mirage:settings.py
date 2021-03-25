# pylint: skip-file
# flake8: noqa
# mypy: ignore-errors
self.include_builtin("config/settings.py")


class General:
    # When closing the window, minimize the application to system tray instead
    # of quitting the application.
    # A click on the tray icon reveals the window, middle click fully quits it
    # and right click opens a menu with these options.
    close_to_tray: bool = True

    # Show rooms, members and messages in way that takes less vertical space.
    compact: bool = True
