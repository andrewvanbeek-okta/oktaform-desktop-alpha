resource "okta_auth_server" "netappserveraushwgdn84o55qnwY0h7" {
audiences = ["http://localhost:60611/authorization-code/callback"]
description = null
name = "net app server"
}
resource "okta_auth_server_policy" "AuthServer00phwgffkqBrNEeHX0h7" {
status = "ACTIVE"
name = "Auth Server"
description = "for all clients"
priority = 1
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.netappserveraushwgdn84o55qnwY0h7.id}"
}
resource "okta_auth_server" "forteioauskkfitx0l6SNY6R0h7" {
audiences = ["http://localhost:3000"]
description = null
name = "forte.io"
}
resource "okta_auth_server_claim" "yourFirstNameoclklhjdg1w99OnCp0h7" {
name = "yourFirstName"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.firstName"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
}
resource "okta_auth_server_claim" "yourLastNameoclklhjyvj14aBR550h7" {
name = "yourLastName"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.lastName"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
}
resource "okta_auth_server_claim" "deviceTypeoclklhr367HECzWHq0h7" {
name = "deviceType"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.deviceType"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
}
resource "okta_auth_server_claim" "phoneDigitsoclklhr6g7XtDntc40h7" {
name = "phoneDigits"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.mobilePhone"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
}
resource "okta_auth_server_claim" "groupsoclkwexfnwgW3TeIZ0h7" {
status = "ACTIVE"
name = "groups"
value_type = "GROUPS"
value = ".*"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
group_filter_type = "REGEX"
}
resource "okta_auth_server_policy" "all00pkkfi28xQuwrC9D0h7" {
status = "ACTIVE"
name = "all"
description = "all folks"
priority = 1
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.forteioauskkfitx0l6SNY6R0h7.id}"
}
resource "okta_auth_server" "keycloakauslrka4f79eAysUq0h7" {
audiences = ["http://localhost:8180"]
description = null
name = "keycloak"
}
resource "okta_auth_server_claim" "testoneoclskp6egedfXZ38x0h7" {
name = "test_one"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.firstName"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
resource "okta_auth_server_claim" "thisiscustomoclskp80r4plYVlkx0h7" {
name = "this_is_custom"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"custom\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
resource "okta_auth_server_policy" "Forall00plrkivr3fJyiLhQ0h7" {
status = "ACTIVE"
name = "For all"
description = "for all"
priority = 1
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
resource "okta_auth_server_scope" "lolscpskp64i5ONKHIHw0h7" {
consent = "IMPLICIT"
name = "lol"
description = "lol"
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
resource "okta_auth_server_scope" "spascpskp9bwjpd42gLv0h7" {
consent = "IMPLICIT"
name = "spa"
description = "spa"
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
