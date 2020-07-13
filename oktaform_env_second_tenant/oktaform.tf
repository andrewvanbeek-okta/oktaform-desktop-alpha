resource "okta_app_oauth" "oidcclient0oahk5h8usLt9thC40h7" {
label = "Angular"
type = "browser"
grant_types = ["implicit"]
redirect_uris = ["http://localhost:8080/implicit/callback"]
response_types = ["id_token","token"]
token_endpoint_auth_method = "client_secret_basic"
consent_method = "TRUSTED"
}
