#!/bin/sh
xmlstarlet ed -d '//item[not(guid[contains(text(),"longterm")])]'
