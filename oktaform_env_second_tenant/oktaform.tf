resource "okta_auth_server" "defaultausgub6xfsZCb1A5O0h7" {
audiences = ["api://payments"]
description = "Default Authorization Server for your Applications"
name = "default"
}
resource "okta_auth_server_claim" "factorIdoclhj12z0jYdAF83R0h7" {
name = "factorId"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.factorId"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "smsFactoroclhj13zf7nF8ScwV0h7" {
name = "smsFactor"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.factorId"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "rolesocli39ozuuNzsR0e20h7" {
status = "ACTIVE"
name = "roles"
value_type = "GROUPS"
value = ".*"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
group_filter_type = "REGEX"
}
resource "okta_auth_server_claim" "accountsocli3anllookHUn1h0h7" {
name = "accounts"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.bank_accounts"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "titleocliubukslTLZzDXq0h7" {
name = "title"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.title"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "optoclj6dl7i50XL1Lg40h7" {
name = "opt"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "appuser.opt"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "reqocljc8bthekHEQHaO0h7" {
name = "req"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "appuser.req"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "adminocljeez3d4nLcy5ve0h7" {
name = "admin"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "true"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "userDisplayNameocljpz2h504OnwqGk0h7" {
name = "userDisplayName"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.firstName + user.lastName"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "appContextoclnizbb2rfPRxd370h7" {
name = "appContext"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"not\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "extraserviceclaimoclrenc6fk37CjN4x0h7" {
name = "extra_service_claim"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "app.profile.coolitem"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "databaseguidoclrjlmcfsbeQAbYc0h7" {
name = "database_guid"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.database_id"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "sigvauleoclrk070koSolqNcT0h7" {
name = "sig_vaule"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.sig_value"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "orgidoclrn3dmhi56BySgU0h7" {
name = "org_id"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.org_id"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "globalvalueocls8abeqdBp0WTGb0h7" {
name = "global_value"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"spaghetti\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "groupstestocls9cmq34couaHFm0h7" {
status = "ACTIVE"
name = "groups_test"
value_type = "GROUPS"
value = ".*"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
group_filter_type = "REGEX"
}
resource "okta_auth_server_claim" "roleperrmissionsoclsnjuecrrTediQe0h7" {
name = "role_perrmissions"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "appuser.role_permissions"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_claim" "burneridoclsoi2az0aNAWvZD0h7" {
name = "burner_id"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.burner_id"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_policy" "SpecificApi00plk3u7am36fKgiD0h7" {
status = "ACTIVE"
name = "Specific Api"
description = "api for managing posgress payment data api"
priority = 1
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_policy" "DefaultPolicy00pgub6xh38LvQb4l0h7" {
status = "ACTIVE"
name = "Default Policy"
description = "Default Policy for your Authorization Server"
priority = 2
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "Adminscpjeez3czmycNAvE0h7" {
consent = "IMPLICIT"
name = "Admin"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "admintwoscpoiykqoaKDfuuwK0h7" {
consent = "IMPLICIT"
name = "admin-two"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "datasetonescpsk88bsbfp7afrC0h7" {
consent = "IMPLICIT"
name = "dataset_one"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "datasettwoscpsk8fgfpARJbKm80h7" {
consent = "IMPLICIT"
name = "dataset_two"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "newscopescprvzhyw7vPifxWw0h7" {
consent = "REQUIRED"
name = "newscope"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "paymentsreadscplk3u7bmbrSSmTa0h7" {
consent = "REQUIRED"
name = "payments-read"
description = ""
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "scopethatrequiresconsentscpsg1bick7ZQOViD0h7" {
consent = "REQUIRED"
name = "scope_that_requires_consent"
description = "We want access to everything, just kidding.."
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "superadminscpq4xakdcjYE4hSG0h7" {
consent = "IMPLICIT"
name = "super-admin"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
resource "okta_auth_server_scope" "truefxreadonlyscpq9d8s20KsvZIQv0h7" {
consent = "IMPLICIT"
name = "truefx-read-only"
description = null
auth_server_id = "${okta_auth_server.defaultausgub6xfsZCb1A5O0h7.id}"
}
