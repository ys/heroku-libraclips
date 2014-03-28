heroku-libraclips
=================

Heroku CLI plugins for libraclips

**WARNING: code is crappy and contains basic auth information for the moment**
I just need to figure out how to deal with external gems here with vendoring and all that.

## Install

```
$ heroku plugins:install git@github.com:ys/heroku-libraclips.git
```


## Commands

```
  d2l:add [dataclip]  #  Add a measurment for dataclip
  d2l:list            #  List all the measurements currently active
  d2l:update [id]     #  Update a measurment for dataclip
```

### List

```
Usage: heroku list

 List all the measurements currently active
```

### Add 

```
Usage: heroku add [dataclip]

 Add a measurment for dataclip


 -l, --librato  BASENAME  # specify librato base name
 -s, --source   LIBRATOSOURCE # the source
 -i, --interval RUNINTERVAL # the interval
```

### Update

```
Usage: heroku update [id]

 Update a measurment for dataclip


 -l, --librato  BASENAME  # specify librato base name
 -s, --source   LIBRATOSOURCE # the source
 -i, --interval RUNINTERVAL # the interval
 -d, --dataclip DATACLIP # the dataclip
```
