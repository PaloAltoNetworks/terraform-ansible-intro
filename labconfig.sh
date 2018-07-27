#!/usr/bin/env bash

# Copyright 2018 Palo Alto Networks.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Download and extract Terraform utility in the deployment directory.
function getTerraform() {
  # Places terraform in ~/bin dir.
  local T_VERSION='0.11.7/terraform_0.11.7_linux_amd64'
  local T_URL="https://releases.hashicorp.com/terraform/${T_VERSION}.zip"
  local T_DIR=~/bin
  local T_ZIP="${T_DIR}/terraform.zip"
  local T_EXE="${T_DIR}/terraform"

  echo "Downloading and installing Terraform binary..."

  if [ -e ${T_EXE} ]; then
    echo "${T_EXE} already exists. Exiting."
    echo ''
    echo "To adjust your path: export PATH=${T_DIR}:\${PATH}"
    return 0
  fi

  mkdir -p ${T_DIR}
  pushd ${T_DIR} > /dev/null
  curl -o "${T_ZIP}" "${T_URL}"
  unzip -q "${T_ZIP}"
  rm "${T_ZIP}"
  popd > /dev/null

  if [ -e ${T_EXE} ]; then
    echo "Successfully retrieved ${T_EXE}."
    echo ''
    echo "To adjust your path: export PATH=${T_DIR}:\${PATH}"
  else
    echo "Could not retrieve ${T_EXE}."
  fi
}

# Install Ansible package from apt repository.
function getAnsible() {
  local A_EXE="ansible"

  if [ -e ${A_EXE} ]; then
    echo "${A_EXE} already exists. Exiting."
    return 0
  fi

  sudo apt-get -y update
  sudo apt-get -y install software-properties-common
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get -y update
  sudo apt-get -y install ansible

  if [ -e ${A_EXE} ]; then
    echo "Successfully installed ${A_EXE}."
    echo ""
  else
    echo "Could not retrieve ${A_EXE}."
  fi
}

# Main program
getAnsible
getTerraform

