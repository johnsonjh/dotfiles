# vim: set ft=sh ts=4 sw=4 tw=80 expandtab colorcolumn=80 :
# SPDX-License-Identifier: FSFAP
# ksh93 configuration

###############################################################################
#
# Copyright (c) 2022-2023 Jeffrey H. Johnson <trnsz@pobox.com>
#
# Copying and distribution of this file, with or without
# modification, are permitted in any medium without royalty
# provided the copyright notice and this notice are preserved.
# This file is offered "AS-IS", without any warranty.
#
###############################################################################

# Import system settings
if [ -f /etc/kshrc ]; then
        . /etc/kshrc
fi

# Emacs-style line editing
set -o emacs

# Arrow keys
alias __A=$(print '\0020') # ^P = up    = previous command
alias __B=$(print '\0016') # ^N = down  = next command
alias __C=$(print '\0006') # ^F = right = forward a character
alias __D=$(print '\0002') # ^B = left  = back a character
alias __H=$(print '\0001') # ^A = home  = beginning of line
