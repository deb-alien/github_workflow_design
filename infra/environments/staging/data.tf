# ==============================================================================
# DATA SOURCES
# ==============================================================================

# Fetch active AWS Availability Zones in the current region
data "aws_availability_zones" "azs" {
  state                  = "available"
  all_availability_zones = true
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}
