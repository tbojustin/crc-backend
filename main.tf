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

/*module from the registry that take care 3 of the items (db, lambda/python, and API)
ENCAPSULATION: These would all change together
PRIVILEGES: A development team might need access to this
VOLATILITY: Low to Medium. This is the "brains" of the website 
*/

module "website_counter" {
  source                 = "./modules/website_counter"
  counter_table_name     = "${var.site_name}-counterdb"
  counter_table_key_name = "URL_path"

}