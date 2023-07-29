provider "aws" {
  region = "ap-northeast-2"

  alias = "korea"
}

provider "aws" {
  region = "ap-northeast-1"

  alias = "japan"
}


resource "aws_s3_bucket" "kor_s3" {
  provider = aws.korea

  bucket = "terraform-kor-region-bucket"
}

resource "aws_s3_bucket" "jp_s3" {
  provider = aws.japan

  bucket = "terraform-jp-region-bucket"
}
