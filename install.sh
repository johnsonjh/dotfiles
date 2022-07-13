#!/usr/bin/env sh
# vim: set ft=sh ts=2 sw=2 tw=80 expandtab colorcolumn=80 :
# SPDX-License-Identifier: FSFAP

################################################################################
#
# Copyright (c) 2022 Jeffrey H. Johnson <trnsz@pobox.com>
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered "AS-IS",
# without any warranty.
#
################################################################################

################################################################################
# Strict mode

set -eu > "/dev/null" 2>&1

# shellcheck disable=SC3040
(env sh -c 'set -o pipefail' > "/dev/null" 2>&1) &&
  set -o pipefail > "/dev/null" 2>&1

################################################################################
# Configuration

# Default PATH
test -z "${PATH:-}" && PATH="/bin:/usr/bin:/sbin:/usr/sbin:/etc:/opt/bin"

# POSIX PATH
(command -p "env" "getconf" PATH > "/dev/null" 2>&1) &&
  PATH="$(command -p "env" "getconf" PATH 2> "/dev/null")":"${PATH:?}"

# SunOS PATH
PATH=/usr/ccs/bin:/opt/SUNWspro/bin:"${PATH:?}":/usr/ucb/bin
PATH=/usr/xpg7/bin:/usr/xpg6/bin:/usr/xpg4/bin:"${PATH:?}"
PATH=/usr/gnu/bin:"${PATH:?}"

# macOS PATH
PATH=/opt/homebrew/bin:/opt/X11/bin:"${PATH:?}":/Library/Apple/usr/bin

# BSD PATH
PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/games:"${PATH:?}"

# AIX PATH
PATH=/opt/freeware/bin:/opt/freeware/sbin:/usr/bin/X11:"${PATH:?}":/usr/ucb

# Snap PATH
PATH=/snap/bin:"${PATH:?}"

# Vim PATH
PATH=/opt/vim/bin:/opt/vim9/bin:/opt/vim8/bin:"${PATH:?}"

# NeoVim PATH
PATH=/opt/nvim/bin:/opt/neovim/bin:"${PATH:?}"

# Generic PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/X11R7/bin:/usr/X11R6/bin:"${PATH:?}"

# Local PATH
PATH="${HOME:?}"/.local/bin:"${HOME:?}"/bin:"${PATH:?}"

# Deduplicate PATH
PATH="$(
  printf '%s\n' "${PATH:?}" |
    tr ':' '\n' |
    awk '!x[$0]++;' |
    awk '{ system("test -d \""$0"\" && printf \"%s\" \""$0"\":"); }' |
    sed 's/:$//' |
    tr -s '/'
)"

################################################################################
# Prerequisites

# rcm
test -z "${RCUP:-}" &&
  {
    RCUP="$(command -v "rcup" 2> "/dev/null")" ||
      {
        printf '%s\n' "ERROR: rcup not found."
        exit 1
      }
  }

# cURL
test -z "${CURL:-}" &&
  {
    CURL="$(command -v "curl" 2> "/dev/null")" ||
      {
        printf '%s\n' "ERROR: curl not found."
        exit 1
      }
  }

# NeoVim
test -z "${NVIM:-}" &&
  {
    NVIM="$(command -v "nvim" 2> "/dev/null")" ||
      true
  }

# Vim
test -z "${VIM:-}" &&
  {
    VIM="$(command -v "vim9" 2> "/dev/null" ||
      command -v "vim8" 2> "/dev/null" ||
      command -v "vim" 2> "/dev/null")" ||
      true
  }

# Require NeoVim or Vim
test -z "${NVIM:-}${VIM:-}" &&
  {
    printf '%s\n' "ERROR: vim or nvim not found."
    exit 1
  }

# Ensure we are on a TTY and stderr/stdout is not redirected
ISATTY=0
test -t 0 2> "/dev/null" && ISATTY=1

test "${ISATTY:?}" -eq 1 2> "/dev/null" ||
  {
    printf '%s\n' "ERROR: TTY/PTY required."
    exit 1
  }

################################################################################
# First run tasks

DOTFILES_DIR="${HOME:?}"/.config/dotfiles

# Have we run before?
test -f "${DOTFILES_DIR:?}"/.hasrun && HASRUN=1 || HASRUN=0

# Symlink $HOME/.rcrc
test "${HASRUN:?}" -eq 0 2> "/dev/null" &&
  {
    test -f "${HOME:?}"/.rcrc ||
      {
        ln -fs "${HOME:?}"/.dotfiles/rcrc "${HOME:?}"/.rcrc
      }
  }

# rcup
test "${HASRUN:?}" -eq 0 2> "/dev/null" && ${RCUP:?} -v
test "${HASRUN:?}" -eq 1 2> "/dev/null" && ${RCUP:?}

# Reset NeoVim and Vim configuration
test "${HASRUN:?}" -eq 0 2> "/dev/null" &&
  {
    printf '%s\n' "Resetting NeoVim configuration ..."
    rm -rf "${HOME:?}"/.local/share/nvim > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.nvimundo > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.nvimundo-session > "/dev/null" 2>&1
    printf '%s\n' "Resetting NeoVim configuration ..."
    rm -rf "${HOME:?}"/.vim > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.vimundo > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.vimundo-session > "/dev/null" 2>&1
  }

################################################################################
# Vim

GHRWURL='https://raw.githubusercontent.com'
PLUGDST='autoload/plug.vim'
PLUGURL="${GHRWURL:?}/junegunn/vim-plug/master/plug.vim"

# Ensure Vim info directory exists
mkdir -p "${HOME:?}"/.vim/files/info

# Ensure $HOME/go/bin exists if Golang is available.
$(command -v go) "version" < "/dev/null" 2> "/dev/null" |
  grep -q 'go ' > "/dev/null" 2>&1 &&
  {
    mkdir -p "${HOME:?}"/go/bin
    PATH="${HOME:?}"/go/bin:"${PATH:?}"
  }

# Install vim-plug for NeoVim
mkdir -p "${XDG_DATA_HOME:-${HOME:?}/.local/share}"/nvim/site/"${PLUGDST:?}"
${CURL:?} -fLo \
  "${XDG_DATA_HOME:-${HOME:?}/.local/share}"/nvim/site/${PLUGDST:?} \
  "${PLUGURL:?}"

# Install vim-plug for Vim
mkdir -p "${HOME:?}"/.vim/"${PLUGDST:?}"
${CURL:?} -fLo \
  "${HOME:?}"/.vim/${PLUGDST:?} \
  "${PLUGURL:?}"

# Symlink vimrc to init.vim for this run
ln -fs "${HOME:?}"/.config/nvim/init.vim "${HOME:?}"/.vimrc

# Setup NeoVim if installed
test -z "${NVIM:-}" ||
  {
    test "${HASRUN:?}" -eq 1 2> "/dev/null" &&
      {
        ${NVIM:?} '+PlugUpgrade' '+qall' || true
      }
    ${NVIM:?} '+PlugClean!' '+qall' || true
    ${NVIM:?} '+PlugInstall' '+qall' || true
    ${NVIM:?} '+PlugUpdate' '+qall' || true
  }

# Setup Vim if installed
test -z "${VIM:-}" ||
  {
    test "${HASRUN:?}" -eq 1 2> "/dev/null" &&
      {
        ${VIM:?} '+PlugUpgrade' '+qall' || true
      }
    ${VIM:?} '+PlugClean!' '+qall'
    ${VIM:?} '+PlugInstall' '+qall'
    ${VIM:?} '+PlugUpdate' '+qall'
  }

################################################################################
# Clean-up

# Remove $HOME/.README.md if it exists
test -L "${HOME:?}"/.README.md 2> "/dev/null" &&
  rm -f "${HOME:?}"/.README.md > "/dev/null" 2>&1
test -h "${HOME:?}"/.README.md 2> "/dev/null" &&
  rm -f "${HOME:?}"/.README.md > "/dev/null" 2>&1

# Remove $HOME/.install.sh if it exists
test -L "${HOME:?}"/.install.sh 2> "/dev/null" &&
  rm -f "${HOME:?}"/.install.sh > "/dev/null" 2>&1
test -h "${HOME:?}"/.install.sh 2> "/dev/null" &&
  rm -f "${HOME:?}"/.install.sh > "/dev/null" 2>&1

################################################################################
# Finish

mkdir -p "${DOTFILES_DIR:?}"
touch "${DOTFILES_DIR:?}"/.hasrun
${RCUP:?}

################################################################################
