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

# Checks directory for files that lack a newline character 

# The following section is adapted from content on Stack 
# https://stackoverflow.com/questions/3261925/how-to-fix-no-newline-at-end-of-file-warning-for-lots-of-files
# Question asked by: Elliot 
# https://stackoverflow.com/users/103213/elliot
# Answer given by: Time Abell 
# https://stackoverflow.com/users/10245/tim-abell
# START adapted content
for i in ./*(D); do \
    if diff /dev/null "$i" | tail -1 | grep '^\\ No newline' > /dev/null; then \
        echo $i; 
    fi; done
# END adapted content
