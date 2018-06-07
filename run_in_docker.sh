# Copyright 2018 Google LLC
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

#!/bin/bash
set -e

if [ $# -ne 3 ];
    then echo "Usage: run_in_docker.sh <path to Dockerfile> <context directory> <image tag>"
fi

dockerfile=$1
context=$2
tag=$3


docker run \
    -v ${context}:/workspace \
    -v /home/deploy/.docker/config.json:/root/.docker/config.json:ro \
    gcr.io/kaniko-project/executor:latest \
    -f ${dockerfile} -d ${tag} -c /workspace/ --insecure-skip-tls-verify true -v debug
