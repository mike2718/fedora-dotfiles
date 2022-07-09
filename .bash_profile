#!/usr/bin/bash
#################################################################
#                                                               #
#   .bash_profile file                                          #
#                                                               #
#   Executed from the bash shell when you log in.               #
#                                                               #
#################################################################
# shellcheck source=.bash_profile
#source ~/.bashrc
#source ~/.bash_login
TZ='Asia/Shanghai';export TZ
[[ -f ~/.bashrc ]] && . ~/.bashrc
#[[ -f ~/.bash_login ]] && . ~/.bash_login
