resource "aws_instance" "machine1" {
  ami           = "ami-........"
  instance_type = "t2.xlarge"
  subnet_id     = "......"
  key_name      = "......"
  inline = [
      "sudo mkdir /s3-folders",
      "sudo apt-get install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config -y",
      "cd /tmp",
      "git clone https://github.com/s3fs-fuse/s3fs-fuse.git",
      "cd s3fs-fuse",
      "./autogen.sh",
      "./configure",
      "make",
      "sudo make install",
      "echo 'KEY:SECRET' | sudo tee -a /etc/passwd-s3fs",
      "sudo chown root:root /etc/passwd-s3fs",
      "sudo chmod 0640 /etc/passwd-s3fs",
      "echo 'user_allow_other' | sudo tee -a /etc/fuse.conf",
      "cd ..",
      "rm -rf s3fs-fuse",
      "echo 's3fs#s3-buckets /s3-folders fuse retries=5,allow_other,url=https://s3.amazonaws.com 0 0' | sudo tee -a /etc/fstab",
  ]
}
