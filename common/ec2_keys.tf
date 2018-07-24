data "template_file" "public_key" {
  template = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_key_pair" "admin" {
  key_name   = "admin-key"
  public_key = "${data.template_file.public_key.rendered}"
}
