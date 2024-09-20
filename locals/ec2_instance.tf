# 1.commandline   -var="varibale_name=value"
# 2. terraform.tfvars  varibale_name="value"
# 3. environment varibale  export TF_VAR_varibale_name=value
# 4.default
# 5. prompt



resource "aws_instance" "expense"{
count=length(var.instance_names)
    ami= data.aws_ami.joindevops.id
    instance_type= local.instance_type
    vpc_security_group_ids=[aws_security_group.ssh.id]
      tags ={
        Name=var.instance_names[count.index]
     }
}

resource "aws_security_group" "ssh"{

    name= var.sg_name
    description= var.sg_description
    # it is a block
    ingress{
        from_port= var.from_port
        to_port=var.to_port
        protocol=var.protocol
        cidr_blocks=var.ingress_cidr
        ipv6_cidr_blocks=["::/0"]
    }

     egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
    }

    tags= var.tags

}