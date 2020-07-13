resource "okta_policy_rule_signon" "MFAoutofCountry0pre2h8b2qUO13ebY1t7" {
status = "ACTIVE"
name = "MFA out of Country"
policyid = "${okta_policy_signon.ForMarketing00pe2h7ubvhIvb8Pl1t7.id}"
access = "ALLOW"
}
resource "okta_policy_signon" "ForMarketing00pe2h7ubvhIvb8Pl1t7" {
status = "ACTIVE"
name = "For Marketing"
description = "static description"
}
resource "okta_app_oauth" "oidcclient0oa21xc45q1RyUNzy1t7" {
label = "MobileApplication"
type = "native"
grant_types = ["refresh_token","password","authorization_code","implicit"]
redirect_uris = ["com.okta.vanbeektech:/openid"]
response_types = ["id_token","code"]
token_endpoint_auth_method = "client_secret_basic"
consent_method = "TRUSTED"
}
