aws_region = "ap-south-1"

name = "phase5"

spoke_vpc_id = "YOUR-REAL-SPOKE-VPC-ID"

private_subnet_id = "YOUR-REAL-PRIVATE-SUBNET-ID"

spoke_cidr = "10.1.0.0/16"

hub_cidr = "10.0.0.0/16"

hub_test_ip = "10.0.1.10"

hub_test_security_group_id = "YOUR-REAL-HUB-SG-ID"

create_hub_test = false

instance_type = "t3.micro"