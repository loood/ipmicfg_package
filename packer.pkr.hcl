packer {
  required_version = ">= 1.10.0"
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "~> 1"
    }
  }
}

variable "distro_codename" {
  type    = string
  default = "${env("DISTRO_CODENAME")}"
}

variable "distro_name" {
  type    = string
  default = "${env("DISTRO_NAME")}"
}

variable "distro_version" {
  type    = string
  default = "${env("DISTRO_VERSION")}"
}

variable "source_dest" {
  type    = string
  default = "/tmp/source"
}

locals {
  output_dir = "/workspace/dist/${var.distro_codename}"
}

source "docker" "build" {
  discard    = true
  image      = "${var.distro_name}:${var.distro_version}"
  privileged = true
  volumes = {
    "${path.cwd}/" = "/workspace"
  }
}

build {
  sources = ["source.docker.build"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive", "DISTRO_NAME=${var.distro_name}", "UBUNTU_RELVER=${var.distro_version}", "UBUNTU_CODENAME=${var.distro_codename}", "OUTPUT_DIR=${local.output_dir}"]
    scripts          = ["scripts/setup.sh", "scripts/build.sh"]
  }

}
