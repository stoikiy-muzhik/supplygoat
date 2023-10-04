resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  region        = "us-west-2"
  acl           = "private"
  tags = {
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
  }
}


resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_bucket" "data_log_bucket" {
  bucket = "data-log-bucket"
}

resource "aws_s3_bucket_logging" "data" {
  bucket = aws_s3_bucket.data.id

  target_bucket = aws_s3_bucket.data_log_bucket.id
  target_prefix = "log/"
}


resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
  bucket = aws_s3_bucket.data.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "data_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "data_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "data" {
  depends_on = [aws_s3_bucket_versioning.data]
  role   = aws_iam_role.data_replication.arn
  bucket = aws_s3_bucket.data.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.data_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  region        = "us-west-2"
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  region        = "us-west-2"
  acl           = "private"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-financials"
    Environment = local.resource_prefix.value
  }

}


resource "aws_s3_bucket_versioning" "financials" {
  bucket = aws_s3_bucket.financials.id

  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_bucket" "financials_log_bucket" {
  bucket = "financials-log-bucket"
}

resource "aws_s3_bucket_logging" "financials" {
  bucket = aws_s3_bucket.financials.id

  target_bucket = aws_s3_bucket.financials_log_bucket.id
  target_prefix = "log/"
}


resource "aws_s3_bucket_server_side_encryption_configuration" "financials" {
  bucket = aws_s3_bucket.financials.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_versioning" "financials" {
  bucket = aws_s3_bucket.financials.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "financials_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.financials.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "financials_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "financials" {
  depends_on = [aws_s3_bucket_versioning.financials]
  role   = aws_iam_role.financials_replication.arn
  bucket = aws_s3_bucket.financials.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.financials_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  region        = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
  }

}


resource "aws_s3_bucket" "operations_log_bucket" {
  bucket = "operations-log-bucket"
}

resource "aws_s3_bucket_logging" "operations" {
  bucket = aws_s3_bucket.operations.id

  target_bucket = aws_s3_bucket.operations_log_bucket.id
  target_prefix = "log/"
}



resource "aws_s3_bucket_server_side_encryption_configuration" "operations" {
  bucket = aws_s3_bucket.operations.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_versioning" "operations" {
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "operations_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "operations_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "operations" {
  depends_on = [aws_s3_bucket_versioning.operations]
  role   = aws_iam_role.operations_replication.arn
  bucket = aws_s3_bucket.operations.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.operations_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  region        = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
}


resource "aws_s3_bucket_server_side_encryption_configuration" "data_science" {
  bucket = aws_s3_bucket.data_science.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}



resource "aws_s3_bucket_versioning" "data_science" {
  bucket = aws_s3_bucket.data_science.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "data_science_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.data_science.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "data_science_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "data_science" {
  depends_on = [aws_s3_bucket_versioning.data_science]
  role   = aws_iam_role.data_science_replication.arn
  bucket = aws_s3_bucket.data_science.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.data_science_destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  region = "us-west-2"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
  }
}


resource "aws_s3_bucket" "logs_log_bucket" {
  bucket = "logs-log-bucket"
}

resource "aws_s3_bucket_logging" "logs" {
  bucket = aws_s3_bucket.logs.id

  target_bucket = aws_s3_bucket.logs_log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "logs_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "logs_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "logs" {
  depends_on = [aws_s3_bucket_versioning.logs]
  role   = aws_iam_role.logs_replication.arn
  bucket = aws_s3_bucket.logs.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.logs_destination.arn
      storage_class = "STANDARD"
    }
  }
}