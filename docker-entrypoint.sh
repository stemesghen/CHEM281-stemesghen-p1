#!/bin/sh

umask 000

cd input

exec mopac "$@"

