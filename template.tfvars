# Oracle Cloud Infrastructure Authentication details
# THIS IS NOT THE SAME AS YOUR NORMAL SSH KEY
# Replace with the fingerprint of your oracle key
export TF_VAR_oracle_api_key_fingerprint=""

# Replace with the path to your private oracle key
export TF_VAR_oracle_api_private_key_path=""

###################
# User OCID
export TF_VAR_user_ocid=""

###################
# Tenancy OCID
export TF_VAR_tenancy_ocid=""

###################
# Region
# List available: https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
export TF_VAR_region="us-ashburn-1"

###################
# Availability Domain
# List available: https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
export TF_VAR_availability_domain_number="3"

###################
# Your SSH Details used to access the server
# Fill in with your own public key signature -- usually its "cat ~/.ssh/id_rsa.pub"
export TF_VAR_ssh_public_key=""

# Fill in the path to the private key path of the ssh key
export TF_VAR_ssh_private_key_path=""
