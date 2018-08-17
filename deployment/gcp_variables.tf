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
 * Terraform variable declarations for GCP.
 */

variable "gcp_project_id" {
  description = "GCP Project ID"
  type = "string"
  default = ""
}

variable "gcp_region" {
  description = "Council Bluffs, Iowa, USA region"
  type = "string"
  default = "us-central1"
}

variable "gcp_credentials_file" {
  description = "Full path to the JSON credentials file"
  type = "string"
  default = "../gcp_compute_key.json"
}

variable "gcp_ssh_key" {
    description = "Full path to the SSH public key file"
    type = "string"
    default = "../../.ssh/sko19_ssh_key.pub"
}
