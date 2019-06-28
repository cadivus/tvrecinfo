# tvrecinfo for MediathekView

## Configuration of MediathekView

Download-set target:
```
%s___%t___%T___%q.mp4
```


## Setup

### update.sh
Runs "mediathekview -auto" for updating abos and runs the sort-scripts.


### update_to_log.sh

Is for cronjobs, creates a log-file.


### sort_*.sh

Sort the new movies after updating the abos.