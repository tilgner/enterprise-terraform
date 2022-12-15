//------------------------------------
// Resource Group
//------------------------------------
variable "resource_groups" {
  description = <<EOF
    name     (Required) - Name of the resource group
    location (Required) - Location of the resource group
    tags     (Optional) - Tags to attach to the resource group
  EOF
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}