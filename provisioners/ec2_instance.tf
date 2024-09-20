resource "aws_instance" "terraform"{

    ami="ami-09c813fb71547fc4f"
    instance_type= "t2.micro"
    vpc_security_group_ids=[aws_security_group.ssh.id]
     tags ={
        Name="terraform"
     }


 provisioner "local-exec" {
    command= "echo ${self.private_ip} > private.txt"
 }

connection{
    type="ssh"
    user="ec2-user"
    password="DevOps321"
    host=self.public_ip
}
 provisioner "remote-exec" {
    inline=[
        "sudo dnf install nginx",
        "systemctl start nginx"
    ]
 }
#   provisioner "remote-exec" {
#     when=destroy
#     inline=[
#         "systemctl stop nginx"
#     ]
#  }
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

    tags={
        Name="allow-ssh"
    }

}