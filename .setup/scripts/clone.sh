#!/bin/bash

git clone git@github.com:jeksterslab/betaDelta.git
rm -rf "$PWD.git"
mv betaDelta/.git "$PWD"
rm -rf betaDelta
