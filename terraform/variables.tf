variable "compartment_ocid" {
  default = "ocid1.compartment.oc1..uniqueid"
}

variable "region" {
  default = "us-phoenix-1"
}

variable "imageOCID" {
  default = "image"
}


variable "ssh_public_key" {
  default = "ssh-rsa <public_key_value>"
}

# Defines the number of instances to deploy
variable "NumInstances" {
  default = "1"
}

variable "InstanceShape" {
  default = "VM.Standard2.1"
}

# Specifies the Availability Domain
variable "localAD" {
  default = "<AD_name>"
}