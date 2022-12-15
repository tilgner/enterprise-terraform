//----------------------------------------------
// Cloud Storage Bucket
//----------------------------------------------
output "bucket_names" {
  description = "Names of the created buckets"
  value       = values(google_storage_bucket.bucket)[*].name
}