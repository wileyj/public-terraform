output "vpc_id" {
	value ="${module.vpc.id}"
}

output "vpc_name" {
	value ="${module.vpc.name}"
}
output "cidr" {
	value = "lookup(var.cidr, var.region[${var.buildenv}])"
}

output "nameserver" {
	value = "lookup(var.nameserver, var.region[${var.buildenv}])"
}

output "public_subnets" {
	value = "lookup(var.public_subnets, var.region[${var.buildenv}])"
}

output "private_subnets" {
	value = "lookup(var.private_subnets, var.region[${var.buildenv}])"
}
