resource "okta_app_oauth" "oidcclient0oahw5xna0MD4b3uI0h7" {
label = ".net App"
type = "web"
grant_types = ["refresh_token","authorization_code","client_credentials"]
redirect_uris = ["http://localhost:60611/authorization-code/callback"]
response_types = ["code"]
token_endpoint_auth_method = "client_secret_basic"
}
resource "okta_app_oauth" "oidcclient0oahikuahrKHsYSTZ0h7" {
label = "Bank App"
type = "web"
grant_types = ["client_credentials","refresh_token","authorization_code","implicit"]
redirect_uris = ["https://oauth-toolkit.glitch.me/toolkit","http://localhost:3000/authorization-code/callback","https://okta-example-playground.appspot.com/authorization-code/callback","https://wandering-domain.glitch.me/authorization-code/callback","https://avbank.glitch.me/authorization-code/callback","http://localhost:3000/toolkit","https://oauth-toolkit.glitch.me/demo/authorization-code/callback","https://daily-argument.glitch.me/authorization-code/callback","https://avbank.glitch.me/accountPage","https://pushy-accordion.glitch.me/authorization-code/callback","https://pushy-accordion.glitch.me/accountPage","https://avb-multi.glitch.me/authorization-code/callback","https://avb-multi.glitch.me/accountPage"]
response_types = ["token","id_token","code"]
token_endpoint_auth_method = "client_secret_basic"
}
