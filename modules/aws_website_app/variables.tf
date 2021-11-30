variable "main_table_name" {
  description="Name of the main dynamodb table"
  type=string
}

variable "main_table_key_name" {
  description="Name of the key used for the main table - if you need to be all fancy with more than one: do it in your Python script"
  type=string
}

variable "api_name" {
  description="What the API is named"
  type=string
}

variable "python_source_file" {
  description="Where you hiding that Pythonic goodness?"
  type=string
}

variable "python_output_path" {
  description="Where you hiding that zipped Pythonic goodness?"
  type=string
}
