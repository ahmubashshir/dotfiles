"""
This package holds private credentials.
"""
from netrc import netrc


def Creds(site: str = None):
    try:
       login, account, secret = netrc().authenticators(f"trackma://{site}")
       return (account or login, secret,)
    except:
        return (None, None)
