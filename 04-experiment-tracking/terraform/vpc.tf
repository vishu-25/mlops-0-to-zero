data "aws_availability_zones" "available" {}

resource "aws_vpc" "mlflow_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "mlflow-vpc"
    Environment = "dev"
    ManagedBy = "terraform"
    terraform = "true"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.mlflow.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "mlflow-public-${count.index}" }
}

resource "aws_internet_gateway" "mlflow" {
  vpc_id = aws_vpc.mlflow.id

  tags = { 
    Name = "mlflow-igw" 
    Environment = "dev"
    ManagedBy = "terraform"
    terraform = "true"  
  }
}

resource "aws_route_table" "mlflow" {
  vpc_id = aws_vpc.mlflow.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mlflow.id
  }

  tags = { Name = "mlflow-rt" }
}

resource "aws_route_table_association" "mlflow" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.mlflow.id
}

# ─────────────────────────────────────────
# Security Groups
# ─────────────────────────────────────────

resource "aws_security_group" "eks_nodes" {
  name        = "mlflow-eks-nodes-sg"
  description = "Allow EKS node communication"
  vpc_id      = aws_vpc.mlflow.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "mlflow-eks-nodes-sg" }
}

resource "aws_route_table_association" "mlflow" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.mlflow.id
}

# ─────────────────────────────────────────
# Security Groups
# ─────────────────────────────────────────

resource "aws_security_group" "eks_nodes" {
  name        = "mlflow-eks-nodes-sg"
  description = "Allow EKS node communication"
  vpc_id      = aws_vpc.mlflow.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "mlflow-eks-nodes-sg" }
}