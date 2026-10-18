#!/usr/bin/env bash

# mdist Copyright (C) 2026 grzesiowski1223
# This program comes with ABSOLUTELY NO WARRANTY; for details type `mdist --license'.
# This is free software, and you are welcome to redistribute it
# under certain conditions

main() {
  make install DESTDIR="$1"
}

if [ "$1" = "--license" ]; then
  printf "mdist - one line destdir cli program to help me with repository making
Copyright (C) 2026  grzesiowski1223

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see https://www.gnu.org/licenses/ .\n"
else
  main "$1"
fi
