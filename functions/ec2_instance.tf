resource "aws_instance" "backend"{
count = length(var.instance_names)
    ami="ami-09c813fb71547fc4f"
    instance_type= "t2.micro"
    vpc_security_group_ids=[aws_security_group.ssh.id]
     tags = merge (
        # commontag
        var.common_tags,  
        {
            # extra tag
            Name = var.instance_names[count.index]  
            Component=  var.instance_names[count.index]  
        }
     )
}

resource "aws_security_group" "ssh"{

    name= "allo-ssh"
    description= "allow port 22"
    ingress{
        from_port= 22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
    }

     egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
        ipv6_cidr_blocks=["::/0"]
    }

    tags = merge (
        # commontag
        var.common_tags,  
        {
            # extra tag
            Name = "allow"  
            # Component= "backend"
        }
     )
}