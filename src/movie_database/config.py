from datetime import timedelta


cache_file = '/tmp/tvrecinfo-database-cache.json'
refresh_age = timedelta(minutes=5)

title_filter_beginning = []
title_filter_ending = ['(WDR)', '(90 min.)', '(90 min)', '(90min.)','(90min)', '(90m)', '(FSK12)', '(FSK_12)', '(FSK14)', '(FSK_14)', '(FSK16)', '(FSK_16)', '(FSK18)', '(FSK_18)', '.ts', '.mp4']

title_filter = ['…', '’', 'ae', 'oe', 'ue', 'Ae', 'Oe', 'Ue']

