#!/bin/bash
date
cat test.jpg| demux 16 one.gz two.gz three.gz
gunzip one.gz
xview one
date
