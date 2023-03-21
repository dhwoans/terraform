variable "name"{
  description ="set vpc name"
  type = string
  default = "vpc"
}
variable "vpc_cidr"{
  description ="vpc cidr block "
  type = string
  default = "10.0.0.0/16"
}

variable "private"{
  description ="private subnet"
  type = string
  default = "10.0.0.0/24"
}

variable "public"{
  description ="public subnet"
  type = string
  default = "10.0.1.0/24"
}

