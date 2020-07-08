resource "okta_policy_signon" "newserverausl6l5880dElOP840h7" {
status = "ACTIVE"
name = "new server"
description = "blah blah"
}
resource "okta_auth_server" "defaultausgub6xfsZCb1A5O0h7" {
audiences = ["api://payments"]
description = "Default Authorization Server for your Applications"
name = "default"
}
resource "okta_policy_signon" "defaultausgub6xfsZCb1A5O0h7" {
status = "ACTIVE"
name = "default"
description = "Default Authorization Server for your Applications"
}
resource "okta_auth_server" "newserverausl6l5880dElOP840h7" {
audiences = ["http://localhost:3000"]
description = "blah blah"
name = "new server"
}
