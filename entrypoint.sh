#!/bin/sh

gleam clean

gleam run -m lustre/dev build --outdir=./priv/static --minify

gleam run -m lustre/dev start
