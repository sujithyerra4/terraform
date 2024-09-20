# 1.commandline   -var="varibale_name=value"
# 2.terraform.tfvars  varibale_name="value"
# 3.environment varibale  export TF_VAR_varibale_name=value
# 4.default
# 5.prompt




resource  "aws_instance" "expense" {
   for_each = var.instances
   ami="ami-09c813fb71547fc4f"
   instance_type = each.value
   vpc_security_group_ids=[aws_security_group.ssh.id]
   tags = merge(
        var.common_tags,
        {
            Name = each.key
            Component= each.key
        }
     )
}


resource "aws_security_group" "ssh" {

    name= var.sg_name
    description= var.sg_description
    # it is a block
   dynamic  "ingress"{
for_each=var.ingress_rules
    content {
        from_port= ingress.value["from_port"]
        to_port=ingress.value.to_port
        protocol=ingress.value.protocol
        cidr_blocks=ingress.value.cidr_blocks
    }
   }

     egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
    }

    tags = merge(
        var.common_tags,
        {
            Name= "allow"
            
        }
    )

}