variable "oracle_api_key_fingerprint" {}
variable "oracle_api_private_key_path" {}

variable "ssh_public_key" {}
variable "ssh_private_key_path" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}

variable "region" {}

variable "instance_display_name" {
  default = "adguard"
}

variable "vcn_cidr_block" {
  default = "10.1.0.0/16"
}

variable "availability_domain_number" {
  default = 2
}

variable "instance_shape" {
  # Free-Tier is VM.Standard.E2.1.Micro
  default = "VM.Standard.E2.1.Micro"
}


variable "instance_image_ocid" {
  type = map

  default = {
    # See https://docs.oracle.com/en-us/iaas/images/ubuntu-2004/
    # Oracle-provided image "Canonical-Ubuntu-20.04-2021.02.15-0"
    # for Ampere choose aarch64 images
    uk-london-1      = "ocid1.image.oc1.uk-london-1.aaaaaaaa7vf2q5jtvzmniylmssuyrczkxw64wl4mlat4kh2fprquuosgficq"
    us-ashburn-1     = "ocid1.image.oc1.iad.aaaaaaaas3iu6z267kkadslq5b3dldp2huvgsb3g47rc2f5k4fog32b5o26a"
  }
}

