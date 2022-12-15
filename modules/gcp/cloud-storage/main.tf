//----------------------------------------------
// Locals
//----------------------------------------------
locals {
  labels = merge(var.labels, { "env" = var.environment })
  bucket_iam_members = flatten([
    for key, value in var.buckets : [
      for _, v in value.access : merge(v, { bucket = key })
  ]])
}

//----------------------------------------------
// Cloud Storage Bucket
//----------------------------------------------
resource "google_storage_bucket" "bucket" {
  for_each                    = var.buckets
  project                     = var.project
  name                        = format("%s-%s", each.value.name, var.environment)
  location                    = each.value.location
  labels                      = merge(local.labels, each.value.labels)
  force_destroy               = each.value.force_destroy
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  storage_class               = each.value.storage_class

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rule
    content {
      condition {
        age = lookup(lifecycle_rule.value, "age", null)
      }
      action {
        type = lookup(lifecycle_rule.value, "action", null)
      }
    }
  }
}

//----------------------------------------------
// Cloud Storage Bucket IAM
//----------------------------------------------
resource "google_storage_bucket_iam_member" "member" {
  for_each = {
    for _, v in local.bucket_iam_members : format(
      "%s-%s-%s",
      v.bucket,
      split("@", v.member)[0],
      split("/", v.role)[1]
    ) => v
  }
  bucket = google_storage_bucket.bucket[each.value.bucket].name
  role   = each.value.role
  member = format("%s:%s", each.value.type, each.value.member)
}

