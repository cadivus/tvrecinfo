# tvrecinfo

This tool is for getting information about episodes of tv-series by specifying the title of an episode.


## Help output
```
$ tvrecinfo --help
usage: tvrecinfo [-h] [--get-column GET_COLUMN] [--title TITLE]
                 [--in-database]
                 database

positional arguments:
  database              Specifies database-source

optional arguments:
  -h, --help            show this help message and exit
  --get-column GET_COLUMN
                        Specifies column to print
  --title TITLE         Specifies title
  --in-database         Prints whether title is in database
```

## Examples

```
$ tvrecinfo "https://www.eplists.de/eplist.cgi?action=show&file=Alf" --title="Der Rollentausch" --in-database
True
```

```
$ tvrecinfo "https://www.eplists.de/eplist.cgi?action=show&file=Alf" --title="Der Rollentausch" --get-column="No."
20
```

```
$ var=$(tvrecinfo "https://www.eplists.de/eplist.cgi?action=show&file=Alf" --title="Der Rollentausch" --get-column="SE")
$ echo $var
01
```


## Use cases

### Sort VDR-Recording

[https://github.com/cadivus/tvrecinfo/tree/master/examples/VDR](https://github.com/cadivus/tvrecinfo/tree/master/examples/VDR)

![Series](https://github.com/cadivus/tvrecinfo/blob/master/doc/images/Series.png?raw=true)


![Series-Directory](https://github.com/cadivus/tvrecinfo/blob/master/doc/images/SeriesDirectory.png?raw=true)

