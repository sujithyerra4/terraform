variable "ami_id" {
    type = string 
    default = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
    type = string
   // default= "t2.large"
}

variable "Environment"{
 default="prod"
}

locals{
    domain_name ="sujithyerra.online"
    zone_id=""
    instance_type= var.Environment == "prod"? "t2.small":"t2.micro"
}

variable "tags"{
type=map
default= {
    Name = "backend"
    Project="Expense"
    Component="backend"
    Environment="dev"
    Terraform="true"
}
}

variable "sg_name"{
    default= "allow-shh"
    type =string
}

variable "sg_description"{
    default= "allow port 22"
}

variable "from_port"{
    type=number
    default= 22
}

variable "to_port"{
    type=number
    default= 22
}

variable "protocol"{
    type=number
    default= 22
}

variable "ingress_cidr"{
    type=list(string)
    default= ["0.0.0.0/0"]
}