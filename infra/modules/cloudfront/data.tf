data "aws_cloudfront_cache_policy" "managed_cache_policy_with_query_strings" {
  name = "UseOriginCacheControlHeaders-QueryStrings"
}
