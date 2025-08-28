### Bastion Host
resource "aws_instance" "create-bastion" {
  ami                    = data.aws_ami.amzn2023.id
  instance_type          = var.instance-type
  subnet_id              = aws_subnet.create-pub-2a.id
  vpc_security_group_ids = [aws_security_group.create-bastion-sg.id]
  key_name  = var.bastion-key-name
  root_block_device {
    volume_size = "8"
    volume_type = "gp3"
    delete_on_termination = true
    tags = {
      Name = "bastion-block-device"
    }
  }

  tags = {
    Name = var.bastion-instance-name
  }
}





### EC2 Instance NFS-Server Host
resource "aws_instance" "create-nfs" {
  ami                    = data.aws_ami.amzn2023.id
  instance_type          = var.instance-type
  subnet_id              = aws_subnet.create-pub-2a.id
  vpc_security_group_ids = [aws_security_group.create-nfs-sg.id]
  key_name  = var.nfs-key-name
  root_block_device {
    volume_size = "100"
    volume_type = "gp3"
    delete_on_termination = true
    tags = {
      Name = "nfs-block-device"
    }
  }

  # User Data (NFS 설치 및 설정)
  user_data = <<-EOF
  #!/bin/bash
  set -xe

  # 패키지 설치
  sudo dnf install -y nfs-utils firewalld

  # NFS 서비스 활성화
  sudo systemctl enable --now nfs-server

  # 방화벽 설정
  sudo systemctl enable --now firewalld
  sudo firewall-cmd --permanent --add-service=nfs
  sudo firewall-cmd --permanent --add-service=rpc-bind
  sudo firewall-cmd --permanent --add-service=mountd
  sudo firewall-cmd --reload

  # NFS 공유 디렉토리 생성
  sudo mkdir -p /nfs_share
  sudo chown -R nobody:nobody /nfs_share
  sudo chmod 777 /nfs_share

  # /etc/exports 설정
  echo "/nfs_share *(rw,sync,no_root_squash,insecure)" | sudo tee -a /etc/exports

  # NFS export 반영
  sudo exportfs -rav
  sudo exportfs -v

  # NFS 서버 재시작
  sudo systemctl restart nfs-server
  sudo systemctl disable --now firewalld
  sudo systemctl stop firewalld
  EOF

  tags = {
    Name = var.nfs-instance-name
  }
}