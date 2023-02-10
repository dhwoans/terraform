terraform {
    backend "remote" {
    hostname      =  "app.terraform.io"
    organization  =   "dhwoans"

    workspaces{
      name = "cloud-backend"
    }
  }
}

# 로컬 변수 선언
locals {
  service_name  = "terraform"
}

