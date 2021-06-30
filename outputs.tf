output "instance_id" {
  description = "ocid of created instances. "
  value       = [oci_core_instance.adguard_instance.id]
}

output "private_ip" {
  description = "Private IPs of created instances. "
  value       = [oci_core_instance.adguard_instance.private_ip]
}

output "public_ip" {
  description = "Public IPs of created instances. "
  value       = [oci_core_instance.adguard_instance.public_ip]
}

output "adguard_bucket_id" {
  value = oci_objectstorage_bucket.adguard_bucket.id
}
output "adguard_archive_bucket_id" {
  value = oci_objectstorage_bucket.adguard_archive_bucket.id
}
