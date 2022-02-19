# provider set the api interactions and authentication related to the cloud provider i deal with.
# first initialized using terraform init command.
provider "aws" {
  # AWS credentials will be supplied using CodeBuild’s service role.
  # profile = "tf-user" # make aws credientials accessed through the profile created using aws CLI. 
  region = "us-west-2"
}


# type and name of the data source must be unique within the module.
data "aws_ami" "ubuntu" {
  most_recent = true # get the latest AMI.

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # account id of the owner of the AMI.
}

# most importnat thing in terraform is resource, as it is responsible for provisioning infrastructure.
resource "aws_instance" "helloworld" {
  ami           = data.aws_ami.ubuntu.id # amazon machine image we select, whenever we need to create an instance.
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}



