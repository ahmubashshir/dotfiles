"""
This package holds private credentials.
"""

from enum import Enum, auto


class Creds(Enum):
    def __init__(self, *args, **kwargs):
        super().__init__()
        attribs = dir(self.value)
        for each in dir(Enum):
            if each in attribs:
                attribs.remove(each)
        for each in attribs:
            setattr(self, each, getattr(self.value, each))

    def __str__(self):
        if isinstance(self.value, (str,)):
            return self.value
        else:
            return self.name.replace('_', ' ')
