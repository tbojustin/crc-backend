# crc-backend

This is the backend portion of the, um, "Someone-Else's-Computer Curriculm Vitae Trial" (that's not the real name, but if you got here through Google - good for you!) - [more information on the "trial" here](https://cloudresumechallenge.dev/docs/the-challenge/aws/)

This repo covers the following portions of the "trial":

## CI/CD and Source Control
  - **Source Control** - "Look around...look at where you are..."
  - **Infrastructure as Code** - The "twist" on this project is that instead of using the AWS CDK - I used Terraform. My future is likely "multi cloud". [More in the blog](https://dev.to/tbojustin/old-man-yells-at-cloud-mid-career-pm-completes-the-cloud-resume-challenge-in-aws-using-terraform-1c43-temp-slug-8152442?preview=2c3e3cf8ce426f1861643261b3d0fd894d84db0e35c082c9b3d80435c5ebce1462eaffae0c44f55cafd9fb35a6e1e2d4825ebde44cbdab5e9415a2e9). 
  - **CI/CD (Back end)** - Github Actions and Terraform Cloud - <a href="https://learn.hashicorp.com/tutorials/terraform/github-actions">Instructions here</a> 
 
## Website Infrastructure
The Terraform Configuration Files (.tf files) in the <a href="/modules/website_infra">website_infra</a> directory are contained in a basic Terraform Module: this should change rarely and should require admin-like privileges.
- **Static Website** - <a href="/modules/website_infra/s3_bucket.tf">S3 bucket Configuration</a>
- **DNS** - <a href="/modules/website_infra/acm_certificate.tf">Certificate</a> 
- **HTTPS** - <a href="/modules/website_infra/cloudfront_distribution.tf">Cloudfront</a>
 
## AWS App
The TF files in the <a href="/modules/aws_website_app">aws_website_app</a> directory are contained in a basic Terraform Module: this would change more often than "infrastructure" and should only require developer privileges.
- **Database** - <a href="/modules/aws_website_app/dynamodb.tf">DynamoDB</a>
- **API** - <a href="/modules/aws_website_app/api_gateway.tf">API</a>
- **Python** - <a href="modules/aws_website_app/lambda.tf">Lambda</a> and [Python](/python)
- **Tests** - [Test.py](/python/test.py)
## Frontend and Blog
<a href="https://dev.to/tbojustin/old-man-yells-at-cloud-mid-career-pm-completes-the-cloud-resume-challenge-in-aws-using-terraform-1c43-temp-slug-8152442?preview=2c3e3cf8ce426f1861643261b3d0fd894d84db0e35c082c9b3d80435c5ebce1462eaffae0c44f55cafd9fb35a6e1e2d4825ebde44cbdab5e9415a2e9">
Complete Blog Post</a> and <a href="https://github.com/tbojustin/crc-frontend">Frontend Repo</a>
