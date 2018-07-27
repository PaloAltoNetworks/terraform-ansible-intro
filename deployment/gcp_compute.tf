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
 * Terraform compute resources for GCP.
 * Acquire all zones and choose one randomly.
 */

data "google_compute_zones" "available" {
  region = "${var.gcp_region}"
}

resource "google_compute_instance" "panos" {
    count = 1
    name = "panos"
    machine_type = "n1-standard-4"
    zone = "${data.google_compute_zones.available.names[0]}"
    can_ip_forward = true
    allow_stopping_for_update = true
    metadata {
        serial-port-enable = true
        ssh-keys = "admin:${file("${var.gcp_ssh_key}")}"
    }
    service_account {
        scopes = [
            "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring.write",
        ]
    }
    network_interface {
        network = "default"
        access_config = {}
    }

    boot_disk {
        initialize_params {
            image = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries-byol-810"
        }
    }
}

resource "google_compute_firewall" "mgt" {
    name = "allow-traffic"
    network = "default"
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports = ["22", "443"]
    }
    source_ranges = ["0.0.0.0/0"]
}

resource "random_string" "password" {
    length = 20
    upper = true
    lower = true
    number = false
    special = false
}

/*
resource "null_resource" "gcp_fwinit" {
    triggers {
        key = "${google_compute_instance.panos.network_interface.0.access_config.0.nat_ip}"
    }
    provisioner "local-exec" {
        command = "/home/ec2-user/util/fw_init.sh ${google_compute_instance.panos.network_interface.0.access_config.0.nat_ip} ${var.panos_username} ${random_string.password.result} /home/ec2-user/.ssh/id_rsa"
    }
}
*/
