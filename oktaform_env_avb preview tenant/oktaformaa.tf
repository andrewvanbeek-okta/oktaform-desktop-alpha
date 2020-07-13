resource "okta_app_oauth" "oidcclient0oa1wsu87yZcuqRV91t7" {
label = "atko"
type = "web"
grant_types = ["implicit","authorization_code","refresh_token"]
redirect_uris = ["http://localhost:55"]
response_types = ["id_token","code"]
token_endpoint_auth_method = "client_secret_basic"
}
