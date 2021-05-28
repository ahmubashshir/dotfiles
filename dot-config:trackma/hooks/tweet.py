# -*- coding: utf-8 -*-
#
# This hook posts to Twitter whenever you complete a show.
#
# To use it, copy this file to ~/.trackma/hooks/ and fill in the consumer/access tokens.
# You may use the twitter_authorize.py utility to fetch them.

#########################

#########################
try:
    from private import TwitterAccess
    ACCESS_KEY = TwitterAccess.KEY
    ACCESS_SECRET = TwitterAccess.SECRET
except ImportError:
    ACCESS_KEY = ""
    ACCESS_SECRET = ""

if not ACCESS_KEY or not ACCESS_SECRET:
    raise Exception(
        "You must provide the Twitter access token in the hook file.")

CONSUMER_KEY = "9GZsCbqzjOrsPWlIlysvg"
CONSUMER_SECRET = "ebjXyymbuLtjDvoxle9Ldj8YYIMoleORapIOoqBrjRw"

try:
    import twitter
    from twitter.error import TwitterError, TwitterHTTPError
except NameError:
    print("tweet-hook: python3-twitter is not installed.")
except ModuleNotFoundError:
    from twitter import TwitterError, TwitterHTTPError
    USE_OAUTH = True

if USE_OAUTH:
    api = twitter.Twitter(
        auth=twitter.OAuth(
            ACCESS_KEY,
            ACCESS_SECRET,
            CONSUMER_KEY,
            CONSUMER_SECRET
        )
    )
else:
    api = twitter.Api(consumer_key=CONSUMER_KEY,
                      consumer_secret=CONSUMER_SECRET,
                      access_token_key=ACCESS_KEY,
                      access_token_secret=ACCESS_SECRET)


def status_changed(engine, show, old_status):
    api_name = engine.api_info['name']
    finished_status = engine.mediainfo['statuses_finish']
    score_max = engine.mediainfo['score_max']

    if show['my_status'] in finished_status:
        msg = "[%s] Finished %s" % (api_name, show['title'])
        if show['my_score']:
            msg += " - Score: %s/%s" % (show['my_score'], score_max)
        msg += " %s" % show['url']

        if len(msg) <= 280:
            engine.msg.info('Twitter', "Tweeting: %s (%d)" % (msg, len(msg)))
            try:
                api.PostUpdate(
                    msg) if not USE_OAUTH else api.statuses.update(status=msg)
            except TwitterError as e:
                engine.msg.warn(
                    'Twitter', "Error Code: %d, Reason: %s" % (e.e.code, e.e.reason))
        else:
            engine.msg.warn('Twitter', "Tweet too long.")
