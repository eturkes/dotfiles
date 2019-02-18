#!/bin/sh

# Copyright 2018-2019 Emir Turkes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Upgrade system, clean up files, and check free space

echo Clean\ up\ Docker\ files: \
    && dsc.sh && docker system prune -f \
    && echo Upgrade\ base\ conda\ environment: \
        && cua.sh \
        && conda update conda \
    && echo Upgrade\ misc\ conda\ environment: \
        && conda activate misc \
        && cua.sh \
        && conda update csvkit \
        && pip install -U grip youtube_dl \
        && conda deactivate \
    && echo Upgrade\ dotfiles-eturkes: \
        && cd $HOME/Documents/projects/dotfiles-eturkes/ \
        && git pull \
        && cd - \
    && echo Upgrade\ tikz2pdf: \
        && cd $HOME/Documents/apps/tikz2pdf/ \
        && git pull \
        && cd - \
    && echo Upgrade\ gitignore-eturkes: \
        && cd $HOME/Documents/apps/gitignore-eturkes/ \
        && git pull \
        && git fetch upstream && git merge upstream/master \
        && cd - \
    && echo Upgrade\ KeepToText-eturkes: \
        && cd $HOME/Documents/apps/KeepToText-eturkes/ \
        && git pull \
        && git fetch upstream && git merge upstream/master \
        && cd - \
    && echo Upgrade\ zimfw-eturkes: \
        && cd $HOME/.zim/ \
        && git pull \
        && zmanage update \
        && git fetch upstream && git merge upstream/master \
        && cd - \
    && cd $HOME/Documents/apps/iso \
        && wget -N --trust-server-names=on \
        https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso \
        && cd -\
    && nvim +'call dein#update()' +qall \
    && dtr.sh && sudo zypper up --details \
    && etr.sh && sudo zypper up --details \
    && sudo zypper dup --details --from Packman\ Repository --allow-vendor-change \
    && sudo rpmconf -a \
    && sudo btrfs fi usage / && lff.sh \
    && sudo zypper pa --orphaned --unneeded \
    && sudo zypper ps
