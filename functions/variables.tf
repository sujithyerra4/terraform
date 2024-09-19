variable "common_tags"{
    type=map
    default={
        Project= "Expense"
        Environment="dev"
        terraform="true"
    }
}

variable "instance_names" {
    type=list(string)
    default= ["mysql","backend","frontend"]
}