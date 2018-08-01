/*
 * Copyright 2018 Palo Alto Networks
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/*
 * Terraform variable declarations for the VM-Series instance.
 */

variable "panos_hostname" {
  description = "Hostname of the VM-Series instance"
  type = "string"
  default = ""
}

variable "panos_username" {
  description = "Username of the VM-Series administrator"
  type = "string"
  default = "admin"
}

variable "panos_password" {
  description = "Password of the VM-Series administrator"
  type = "string"
  default = ""
}

