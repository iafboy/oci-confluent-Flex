# ---------------------------------------------------------------------------------------------------------------------
# Environmental variables
# You probably want to define these as environmental variables.
# Instructions on that are here: https://github.com/cloud-partners/oci-prerequisites
# ---------------------------------------------------------------------------------------------------------------------

# Required by the OCI Provider
variable "tenancy_ocid" {
}

variable "compartment_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

# Key used to SSH to OCI VMs
variable "ssh_public_key" {
}

variable "ssh_private_key" {
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional variables
# The defaults here will give you a cluster.  You can also modify these.
# ---------------------------------------------------------------------------------------------------------------------

variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain name, if non-empty takes precedence over availability_domain_number"
}

variable "availability_domain_number" {
  default     = 1
  description = "OCI Availability Domains: 1,2,3  (subject to region availability)"
}

variable "confluent" {
  type = map(string)
  default = {
    edition = "Community"
    version = "6.0.0"
  }
}

variable "broker" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 100
    node_count = 3 
    disk_count = 1
    disk_size = 100
  }
}

variable "zookeeper" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 50
    node_count = 3
  }
}

variable "connect" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 50
    node_count = 2
  }
}

variable "rest" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 50
    node_count = 2
  }
}

variable "schema_registry" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 50
    node_count = 1
  }
}

variable "ksql" {
  type = map(any)
  default = {
    shape      = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, boot_volume_size = 50
    node_count = 2
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Constants
# You probably don't need to change these.
# ---------------------------------------------------------------------------------------------------------------------

// https://docs.oracle.com/en-us/iaas/images/image/b97380d8-e5df-4545-aa45-50c78122e1e1/
// Oracle-Linux-7.9-2022.04.04-0
variable "images" {
  type = map(string)
  default = {
    ap-singapore-1 = "ocid1.image.oc1.ap-singapore-1.aaaaaaaah6wihmqo7jfqpvfl7cd4fydr5dgruj4iuokm3essdutucdfiw6ra"
    me-dubai-1     = "ocid1.image.oc1.me-dubai-1.aaaaaaaauhj6sdezwoucqoslxiabiajqyhxloabbtbrrum73lywmdkh2jdaa"
    me-jeddah-1    = "ocid1.image.oc1.me-jeddah-1.aaaaaaaaperkuuxporyqgv7m2rwd4z7vx2yoq5zfydgm2a2ktl57mswhd3sa"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaap6fedeihlynzoc4zbfqbdcha27ec7x2xbpg2a2edfarupjxn65wa"
    sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaazgdqu6qyebkor2yhmzpk6kirqoxrpavmefklvuvmng3wj3f6v3a"
    sa-vinhedo-1 	 = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaaibh76ur5hn24t6f4oxj5du3ev7lw2st5k5wasnq36gnymam5qrca"
    af-johannesburg-1 ="ocid1.image.oc1.af-johannesburg-1.aaaaaaaaqhgw6c6a6rna4jtzhq4nhl5qpzntn5uohi3nryelcn43v6h6kpja"
   }
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
