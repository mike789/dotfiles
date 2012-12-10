#!/bin/bash

#Install dotfiles

#Excludes

SCRIPTDIR=$(cd "$(dirname "$0")"; pwd)
INSTALLDIR=$HOME
BACKUP=.dotfiles.old

for FILE in $SCRIPTDIR/.*;
do
   if [ ! -d $FILE ]
   then
      FILENAME=$(basename $FILE);
      SUFFIX=${FILE/*./};
      echo "$FILENAME $SUFFIX";
      if [ $SUFFIX == "gpg" ];
      then
          gpg -o $INSTALLDIR/$(basename $FILE .gpg) $FILE;
      fi
      continue
      if [ -f $INSTALLDIR/$FILENAME ];
      then
         if [ -h $INSTALLDIR/$FILENAME ] && [ $(readlink $INSTALLDIR/$FILENAME) == $SCRIPTDIR/$FILENAME ]
         then
            continue
         fi
         if [ ! -d $INSTALLDIR/$BACKUP ];
         then 
            echo "mkdir -p $INSTALLDIR/$BACKUP"
            mkdir -p $INSTALLDIR/$BACKUP
         fi
         echo "mv $INSTALLDIR/$FILENAME $INSTALLDIR/$BACKUP/$FILENAME"
         mv $INSTALLDIR/$FILENAME $INSTALLDIR/$BACKUP/$FILENAME
      fi
      echo "ln -st $INSTALLDIR $SCRIPTDIR/$FILENAME"
      ln -st $INSTALLDIR $SCRIPTDIR/$FILENAME
   fi
done

source $HOME/.bashrc
#exec bash
