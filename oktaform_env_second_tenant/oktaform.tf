resource "okta_auth_server_claim" "testoneoclskp6egedfXZ38x0h7" {
status = "ACTIVE"
name = "test_one"
value_type = "EXPRESSION"
value = "user.firstName"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.keycloakauslrka4f79eAysUq0h7.id}"
}
resource "okta_auth_server_claim" "thisiscustomoclskp80r4plYVlkx0h7" {
status = "ACTIVE"
name = "this_is_custom"
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
resource "okta_auth_server" "keycloakauslrka4f79eAysUq0h7" {
audiences = ["http://localhost:8180"]
description = null
name = "keycloak"
}
