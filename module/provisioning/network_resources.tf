resource "tencentcloud_vpc" "vpcs" {
  count = local.is_tencent_cloud_enabled ? length(var.resource_plan.vpcs) : 0

  name       = var.resource_plan.vpcs[count.index].name
  cidr_block = var.resource_plan.vpcs[count.index].cidr_block
}

resource "tencentcloud_subnet" "subnets" {
  count = local.is_tencent_cloud_enabled ? length(var.resource_plan.subnets) : 0

  vpc_id            = tencentcloud_vpc.vpcs[0].id
  name              = var.resource_plan.subnets[count.index].name
  cidr_block        = var.resource_plan.subnets[count.index].cidr_block
  availability_zone = var.resource_plan.subnets[count.index].availability_zone
}

resource "tencentcloud_route_table" "route_tables" {
  count = local.is_tencent_cloud_enabled ? length(var.resource_plan.route_tables) : 0

  vpc_id = tencentcloud_vpc.vpcs[0].id
  name   = var.resource_plan.route_tables[count.index].name
}

resource "tencentcloud_security_group" "security_groups" {
  count = local.is_tencent_cloud_enabled ? length(var.resource_plan.security_groups) : 0

  name        = var.resource_plan.security_groups[count.index].name
  description = var.resource_plan.security_groups[count.index].description
}

resource "tencentcloud_security_group_rule" "security_group_rules" {
  count = local.is_tencent_cloud_enabled ? length(var.resource_plan.security_group_rules) : 0

  security_group_id = tencentcloud_security_group.security_groups[0].id
  type              = var.resource_plan.security_group_rules[count.index].type
  cidr_ip           = var.resource_plan.security_group_rules[count.index].cidr_ip
  ip_protocol       = var.resource_plan.security_group_rules[count.index].ip_protocol
  port_range        = var.resource_plan.security_group_rules[count.index].port_range
  policy            = var.resource_plan.security_group_rules[count.index].policy
}
