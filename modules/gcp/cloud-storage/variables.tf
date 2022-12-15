//----------------------------------------------
// General
//----------------------------------------------
variable "project" {
  description = "Project ID"
  type        = string
}

variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "labels" {
  description = "Key value pair labels shared across all modules"
  type        = map(string)
}

//----------------------------------------------
// Cloud Storage Bucket
//----------------------------------------------
variable "buckets" {
  description = <<EOF
    name                        (Required) - Name of the bucket
    location                    (Required) - Location of the bucket (e.g. 'EU')
    labels                      (Optional) - Labels attached to the bucket
    force_destroy               (Optional) - Whether Terraform should delete non-empty buckets
    uniform_bucket_level_access (Optional) - Whether to enable uniform bucket level access
    storage_class               (Optional) - Storage class of bucket objects (e.g. 'STANDARD')
    access                      (Optional) - Member and their role on the bucket
    lifecycle_rule              (Optional) - Lifecycle rules for the bucket's objects (e.g. delete objects after 30 days)
  EOF  
  type = map(object({
    name                        = string
    location                    = string
    labels                      = map(string)
    force_destroy               = bool
    uniform_bucket_level_access = bool
    storage_class               = string
    access = list(object({
      member = string
      type   = string
      role   = string
    }))
    lifecycle_rule = list(map(string))
  }))
}
