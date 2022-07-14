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
# Shell should never be csh

# shellcheck disable=SC2006,SC2046,SC2065,SC2116
test _`echo asdf 2>/dev/null` != _asdf >/dev/null &&\
  printf '%s\n' "ERROR: Installation not supported using csh as sh." &&\
  exit 1

################################################################################
# Strict mode

set -eu > "/dev/null" 2>&1

################################################################################
# Cygwin

OS="$(
  {
    exec 2> "/dev/null"
    uname -s |
      cut -d '_' -f1 |
      cut -d '-' -f1 |
      cut -d ' ' -f1
  } || true )"

test "${OS:-}" = "CYGWIN" &&
  {
    { command -v git ; } > "/dev/null" 2>&1 ||
      {
        printf '%s\n' "ERROR: \"git\" not found."
        exit 1
      }

    command -v git 2>&1 |
      head -n 1 | grep -q '^/cygdrive/.*git$' &&
      {
        printf '%s\n' "ERROR: Unable to find native Cygwin \"git\"."
        exit 1
      }

    "$(command -v git)" --version 2>&1 |
      head -n 1 | grep -q 'windows' &&
      {
        printf '%s\n' "ERROR: Unable to find compatible Cygwin \"git\"."
        exit 1
      }

    "$(command -v git)" config --global "core.autocrlf" "false" ||
      {
        printf '%s\n' "ERROR: Unable to disable core.autocrlf."
        exit 1
      }

    "$(command -v git)" config --global "core.symlinks" "true" ||
      {
        printf '%s\n' "ERROR: Unable to enable core.symlinks."
        exit 1
      }

    "$(command -v git)" config --global "core.filemode" "false" ||
      {
        printf '%s\n' "ERROR: Unable to disable core.filemode."
        exit 1
      }

    # shellcheck disable=SC2155
    export CYGWIN="winsymlinks:native $(printf '%s\n' "${CYGWIN:-}" |
      sed -e 's/winsymlinks:[A-z]\+$//' -e 's/winsymlinks:[A-z]\+ //')"
  }

################################################################################
# Configuration

# Default PATH
test -z "${PATH:-}" && PATH="/bin:/usr/bin:/sbin:/usr/sbin:/etc:/opt/bin"

# POSIX PATH
(command -p env getconf PATH > "/dev/null" 2>&1) &&
  PATH="$(command -p env getconf PATH 2> "/dev/null")":"${PATH:?}"

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
  {
    printf '%s\n' "${PATH:?}" |
      tr ':' '\n' |
      awk '!x[$0]++;' |
      awk '{ system("test -d \""$0"\" && printf \"%s\" \""$0"\":"); }' |
      sed 's/:$//' |
      tr -s '/'
  }
)"

################################################################################
# Prerequisites

# git
test -z "${GIT:-}" &&
  {
    GIT="$(command -v "git" 2> "/dev/null")" ||
      {
        printf '%s\n' "ERROR: \"git\" not found."
        exit 1
      }
  }

# rcm
test -z "${RCUP:-}" &&
  {
    RCUP="$(command -v "rcup" 2> "/dev/null")" ||
      {
        printf '%s\n' "ERROR: \"rcup\" not found."
        exit 1
      }
  }

# cURL
test -z "${CURL:-}" &&
  {
    CURL="$(command -v "curl" 2> "/dev/null")" ||
      {
        printf '%s\n' "ERROR: \"curl\" not found."
        exit 1
      }
  }

# NeoVim
test -z "${NVIM:-}" &&
  {
    NVIM="$(command -v "nvim" 2> "/dev/null")" || true
  }

# Vim
test -z "${VIM:-}" &&
  {
    VIM="$(command -v "vim9" 2> "/dev/null" ||
      command -v "vim8" 2> "/dev/null" ||
        command -v "vim" 2> "/dev/null")" || true
  }

# Require NeoVim or Vim
test -z "${NVIM:-}${VIM:-}" &&
  {
    printf '%s\n' "ERROR: \"vim\" and/or \"nvim\" is required."
    exit 1
  }

# Ensure we are on a terminal
test -t 0 2> "/dev/null" ||
  {
    printf '%s\n' "ERROR: Interactive terminal required."
    exit 1
  }

################################################################################
# Download or update

test -d "${HOME:?}"/.dotfiles &&
  {
    ( cd "${HOME:?}"/.dotfiles &&
        {
          { "${GIT:?}" pull || true; } |
            { grep -v '^.* up to date.$' || true; }
        }
    )
  }

test -d "${HOME:?}"/.dotfiles ||
  {
    ( cd "${HOME:?}" &&
        { rm -rf "./.dotfiles" > "/dev/null" 2>&1 || true; }
    )
    "${GIT:?}" clone "https://github.com/johnsonjh/dotfiles" \
      "${HOME:?}"/.dotfiles
  }

################################################################################
# Sanity check

test -d "${HOME:?}"/.dotfiles ||
  {
    printf '%s\n' "ERROR: ${HOME:?}/.dotfiles missing."
    exit 1
  }

################################################################################
# First run tasks

DOTFILES_DIR="${HOME:?}"/.config/dotfiles

# Set HASRUN if "${DOTFILES_DIR:?}"/.hasrun exists
HASRUN=0
test -f "${DOTFILES_DIR:?}"/.hasrun &&
  HASRUN=1

# If !HASRUN, remove "${DOTFILES_DIR:?}"/.init.vim.last
test "${HASRUN:?}" -eq 0 2> "/dev/null" &&
  rm -f "${DOTFILES_DIR:?}"/.init.vim.last > "/dev/null" 2>&1

# Unset HASRUN if "${DOTFILES_DIR:?}"/.init.vim.last nonexistent
test -f "${DOTFILES_DIR:?}"/.init.vim.last ||
  HASRUN=0

# Allow command-line arguments `-f` or `--force` to set DOTFILES_FORCE_RESET
while test "${1:-}" > "/dev/null" 2>&1; do
  test "${1:-}" = '-f' > "/dev/null" 2>&1 && DOTFILES_FORCE_RESET=1
  test "${1:-}" = '--force' > "/dev/null" 2>&1 && DOTFILES_FORCE_RESET=1
  shift 1 > "/dev/null" 2>&1 || true
done

# Unset DOTFILES_FORCE_RESET variable if set to zero
test "${DOTFILES_FORCE_RESET:-}" -eq 0 > "/dev/null" 2>&1 &&
  {
    unset DOTFILES_FORCE_RESET > "/dev/null" 2>&1 || true
  }

# Unset HASRUN and tidy when "${DOTFILES_FORCE_RESET:-}" is set
test -n "${DOTFILES_FORCE_RESET:-}" > "/dev/null" 2>&1 &&
  {
    HASRUN=0
    DOTFILES_FORCE_RESET=1
    rm -f "${DOTFILES_DIR:?}"/.init.vim.last > "/dev/null" 2>&1 || true
    rm -f "${DOTFILES_DIR:?}"/.hasrun > "/dev/null" 2>&1 || true
  }

# Symlink $HOME/.rcrc
test "${HASRUN:?}" -eq 0 2> "/dev/null" &&
  {
    test -f "${HOME:?}"/.rcrc ||
      {
        ln -fs "${HOME:?}"/.dotfiles/rcrc "${HOME:?}"/.rcrc
      }
  }

# rcup
"${RCUP:?}"

# Reset NeoVim and Vim configuration
test "${HASRUN:?}" -eq 0 2> "/dev/null" &&
  {
    rm -rf "${HOME:?}"/.local/share/nvim > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.nvimundo         > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.nvimundo-session > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.vim              > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.vimundo          > "/dev/null" 2>&1
    rm -rf "${HOME:?}"/.vimundo-session  > "/dev/null" 2>&1
  }

################################################################################
# Vim

GHRWURL='https://raw.githubusercontent.com'
PDST='autoload'
PVIM='plug.vim'
NVS='/nvim/site/'
PLUGURL="${GHRWURL:?}"/junegunn/vim-plug/master/"${PVIM:?}"

# Ensure Vim info directory exists
mkdir -p "${HOME:?}"/.vim/files/info

# Ensure $HOME/go/bin exists if Golang is available.
"$(command -v go)" version < "/dev/null" 2> "/dev/null" |
  grep -q 'go ' > "/dev/null" 2>&1 &&
  {
    mkdir -p "${HOME:?}"/go/bin
    PATH="${HOME:?}"/go/bin:"${PATH:?}"
  }

# Clean-up
test "${HASRUN:?}" -eq 1 2> "/dev/null" ||
  rm -rf \
    "${XDG_DATA_HOME:-${HOME:?}/.local/share}${NVS:?}${PDST:?}/${PVIM:?}"
test "${HASRUN:?}" -eq 1 2> "/dev/null" ||
  rm -rf \
    "${HOME:?}/.vim/${PDST:?}/${PVIM:?}"

# Install vim-plug for NeoVim
mkdir -p                                                      \
  "${XDG_DATA_HOME:-${HOME:?}/.local/share}${NVS:?}${PDST:?}" \
    > "/dev/null" 2>&1
test -f \
  "${XDG_DATA_HOME:-${HOME:?}/.local/share}${NVS:?}${PDST:?}/${PVIM:?}" ||
    "${CURL:?}" -fsSLo                                                      \
      "${XDG_DATA_HOME:-${HOME:?}/.local/share}${NVS:?}${PDST:?}/${PVIM:?}" \
      "${PLUGURL:?}"

# Install vim-plug for Vim
mkdir -p                     \
  "${HOME:?}/.vim/${PDST:?}" \
    > "/dev/null" 2>&1
test -f \
  "${HOME:?}/.vim/${PDST:?}/${PVIM:?}" ||
    "${CURL:?}" -fsSLo                     \
      "${HOME:?}/.vim/${PDST:?}/${PVIM:?}" \
      "${PLUGURL:?}"

# Symlink vimrc to init.vim for this run
ln -fs "${HOME:?}"/.config/nvim/init.vim "${HOME:?}"/.vimrc

# Check if Vim configuration has changed
VIMRC_CHANGED=1
test -f "${DOTFILES_DIR:?}"/.init.vim.last &&
  {
    cmp -s "${DOTFILES_DIR:?}"/.init.vim.last > "/dev/null" 2>&1 \
      "${HOME:?}"/.dotfiles/config/nvim/init.vim 2> "/dev/null" &&
      {
        VIMRC_CHANGED=0
      }
  }

# If Vim configuration changed
test "${VIMRC_CHANGED:?}" -eq 1 2> "/dev/null" &&
  {
    # Setup NeoVim if installed
    test -z "${NVIM:-}" ||
      {
        test "${HASRUN:?}" -eq 1 2> "/dev/null" &&
          {
            "${NVIM:?}"                           \
              '+silent! let g:plug_retries = 6'   \
              '+silent! let g:plug_threads = 1'   \
              '+silent! let g:plug_timeout = 360' \
              '+silent! let g:plug_window  = ""'  \
              '+silent! PlugUpgrade'              \
              '+qall' || true

            "${NVIM:?}"                           \
              '+silent! UpdateRemotePlugins'      \
              '+qall' || true
          }

        "${NVIM:?}"                               \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugClean!'                   \
          '+qall' || true

        "${NVIM:?}"                               \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugInstall'                  \
          '+qall' || true

        "${NVIM:?}"                               \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugInstall'                  \
          '+qall' || true

        "${NVIM:?}"                               \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugUpdate'                   \
          '+qall' || true

        "${NVIM:?}"                               \
          '+silent! UpdateRemotePlugins'          \
          '+qall' || true
      }

    # Setup Vim if installed
    test -z "${VIM:-}" ||
      {
        test "${HASRUN:?}" -eq 1 2> "/dev/null" &&
          {
            "${VIM:?}"                            \
              '+silent! let g:plug_retries = 6'   \
              '+silent! let g:plug_threads = 1'   \
              '+silent! let g:plug_timeout = 360' \
              '+silent! let g:plug_window  = ""'  \
              '+silent! PlugUpgrade'              \
              '+qall' || true
          }

        "${VIM:?}"                                \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugClean!'                   \
          '+qall' || true

        "${VIM:?}"                                \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugInstall'                  \
          '+qall' || true

        "${VIM:?}"                                \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugInstall'                  \
          '+qall' || true

        "${VIM:?}"                                \
          '+silent! let g:plug_retries = 6'       \
          '+silent! let g:plug_threads = 1'       \
          '+silent! let g:plug_timeout = 360'     \
          '+silent! let g:plug_window  = ""'      \
          '+silent! PlugUpdate'                   \
          '+qall' || true
      }
  }

################################################################################
# Clean-up

# Remove ${HOME}/.README.md if it exists
test -L "${HOME:?}"/.README.md          > "/dev/null" 2>&1 &&
  rm -f "${HOME:?}"/.README.md          > "/dev/null" 2>&1
test -h "${HOME:?}"/.README.md          > "/dev/null" 2>&1 &&
  rm -f "${HOME:?}"/.README.md          > "/dev/null" 2>&1

# Remove ${HOME}/.LICENSES/FSFAP.txt if it exists
test -L "${HOME:?}"/.LICENSES/FSFAP.txt > "/dev/null" 2>&1 &&
  rm -f "${HOME:?}"/.LICENSES/FSFAP.txt > "/dev/null" 2>&1
test -h "${HOME:?}"/.LICENSES/FSFAP.txt > "/dev/null" 2>&2 &&
  rm -f "${HOME:?}"/.LICENSES/FSFAP.txt > "/dev/null" 2>&1

# Remove ${HOME}/.LICENSES if empty
rmdir   "${HOME:?}"/.LICENSES           > "/dev/null" 2>&1 || true

# Remove ${HOME}/.install.sh if it exists
test -L "${HOME:?}"/.install.sh         > "/dev/null" 2>&1 &&
  rm -f "${HOME:?}"/.install.sh         > "/dev/null" 2>&1
test -h "${HOME:?}"/.install.sh         > "/dev/null" 2>&2 &&
  rm -f "${HOME:?}"/.install.sh         > "/dev/null" 2>&1

################################################################################
# Finish

mkdir -p "${DOTFILES_DIR:?}" > "/dev/null"
touch "${DOTFILES_DIR:?}"/.hasrun
cp -f "${HOME:?}"/.dotfiles/config/nvim/init.vim \
  "${DOTFILES_DIR:?}"/.init.vim.last > "/dev/null"
"${RCUP:?}" || true

################################################################################
