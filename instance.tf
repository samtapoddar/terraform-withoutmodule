resource "aws_instance" "web" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name= "${aws_key_pair.new-key.key_name}"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  tags = {
    Name = "first-tf-instance"
  }
}

resource "aws_key_pair" "new-key" {
  key_name   = "new-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjb2hhUsTLi/7sox6EW3J69MVrUb7ClQsA/2qmm03DJ6zaEZwHYoRLuIVRCHpni3wIW+3ZsFQFnLvx1+qCHB+10402LcPRtrxis0jxwRg5xMCdLuYqjH2LhOw+DLDxQYV5AsoaWcfKbAktxK0tXb9RDjP1HajyLDyealzG94S+69K9uMybqmoUq9V3OQXxOKkgJKLosbGJugFey+XVqMTpPTaNsHGpW3LtE9KwVnRQG5yfZbd1yrdgJNm9XedroMZnKzZHdr02PjOGMnKpXYIDsv2VH61Tn263Jf7BGaFJtCQHohMIDUCOKUzYaQn/FO1eoZ2CdHVmMnlS3yuuA2kZAC8iv3NClX3Nmi+TJ7SrPRpBtSdu0TMyqKjK69zeDqbCzXohX9xDlsrHjO0sDmAb5NHHGHeGVC9EUEtZtNF4s2EhGoe6qziTKqQ9r/MNWhAhFRkBuKxzxLDRiQN/7B6FSf14uKTzmk6NsCbL3HNoNNXAwwWXkY+OmpmiZ/HrtWU= samta@samta-ThinkBook-14-G2-ITL-Ub"
}