variable "counter_table_name" {
  description="Name of the counter table"
  type=string
}

variable "counter_domain"{
  description="Domain name for site getting 'counted'"
  type=string
}

variable "counter_domain_arn"{
  description="Certifcate ARN for Domain name for site getting 'counted'"
  type=string
}
