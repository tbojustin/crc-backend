/*custom website infrasturcture module certificates, basic s3 buckets and cloudfront for HTTPS
ENCAPSULATION: You wouldn't do one of these without the other and would stay stable regardless of changes
PRIVILEGES: Website owner would be the only one needing to update this
VOLATILITY: None to Low. The website frontend is synched to a separate repo 
*/

module "website_infra" {
  source  = "./modules/website_infra"
  domain  = var.site_name
  webpath = "./basic_website_files"
}

/*refactored the API, DynamoDB and Lambda portions into a reusable module
based on this tweet 
https://twitter.com/CubicleApril/status/1463657286925225988
ENCAPSULATION: These would all change together
PRIVILEGES: A development team might need access to this
VOLATILITY: Low to Medium. This is the "brains" of the website 
*/

module "website_counter" {
  source              = "./modules/aws_website_app"
  main_table_name     = "${var.site_name}-counterdb"
  main_table_key_name = "URL_path"
  api_name            = "crc_counter_api"
  #the AWS Lambda Module this uses needs both of these
  python_source_file = "${path.root}/python/main.py"
  python_output_path  = "${path.root}/python/main.py.zip"

}