resource "okta_policy_signon" "Oktaformdefaultavbpreviewtenant00pgub6xfcOajd0040h7" {
status = "ACTIVE"
name = "Oktaform:default: avb preview tenant"
description = "The default policy applies in all situations if no other policy applies."
}
resource "okta_policy_rule_signon" "NondefaultRule0prsv8zgg3nAoXV9w0h7" {
status = "ACTIVE"
name = "Non default Rule"
policyid = "${okta_policy_signon.Oktaformdefaultavbpreviewtenant00pgub6xfcOajd0040h7.id}"
access = "ALLOW"
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
resource "okta_auth_server" "bankingapiauslsufk8uOMda6v60h7" {
audiences = ["api://default"]
description = null
name = "banking api"
}
resource "okta_auth_server_claim" "useroclmwkht2vw83IFBT0h7" {
name = "user"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"david\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "hroclmwkkj2sjtVZ3rq0h7" {
name = "hr"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "true"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "azpoclmwkodtjKVkE4ln0h7" {
name = "azp"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"david\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "userlinkocln0461abR0WRkLA0h7" {
name = "user.link"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.user_1"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "tosoclncmz42rsBq9nOt0h7" {
name = "tos"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.tos"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "spaghettioclnepvywilzoZy5b0h7" {
name = "spaghetti"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"spaghetti\""
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "applicationContextoclnjyzs2xWreURPf0h7" {
name = "applicationContext"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.applicationContext"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "subordinatesoclnnoers9Rr5s2Vn0h7" {
name = "subordinates"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.subordinates"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "testoclno08wp1iSJFOAO0h7" {
name = "test"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.firstName"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "cheatingoclno0ayonIV9BuW80h7" {
name = "cheating"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "\"THE CHEAT\""
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "deletemodelsoclnphnvxfXZygyA70h7" {
name = "delete_models"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.delete_models"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "connectedcrmoclns7c2is44n8OT80h7" {
name = "connected_crm"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.crm_connected"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "emailtypeoclnv8y5yrFGqDzBv0h7" {
name = "email_type"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "appuser.email_type"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "tenantnameoclnvcpeyhtmI5LbG0h7" {
name = "tenant_name"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "appuser.tenant_name"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "dbguidinuserinfooclowggt30M0ziuTN0h7" {
name = "db_guid_in_userinfo"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.redi2_database_user_id"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "dbguidintheatokenoclowgihq1RX53NMR0h7" {
name = "db_guid_in_the_a_token"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.redi2_database_user_id"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "dbguidinidtokenoclowgitz1G9SUXzh0h7" {
name = "db_guid_in_id_token"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.redi2_database_user_id"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "usersgroupoclowgz2boXe2GPxg0h7" {
status = "ACTIVE"
name = "users_group"
value_type = "GROUPS"
value = ".*"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
group_filter_type = "REGEX"
}
resource "okta_auth_server_claim" "eaattributeoclph8yhjqw2Wslig0h7" {
name = "ea_attribute"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.ea_attribute"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "developerroleoclppp7muwa6noi890h7" {
name = "developer_role"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.developerrole"
claim_type = "RESOURCE"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_claim" "organizationoclq46rmov31pTgf10h7" {
name = "organization"
status = "ACTIVE"
value_type = "EXPRESSION"
value = "user.organization"
claim_type = "IDENTITY"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_policy" "ForAll00pmehdu9f051qxTo0h7" {
status = "ACTIVE"
name = "For All"
description = "for all"
priority = 1
client_whitelist = ["ALL_CLIENTS"]
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "adminscpns754aaer6PQDA0h7" {
consent = "REQUIRED"
name = "admin"
description = "admin"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "credsscpmkne7f3t8uEKtk0h7" {
consent = "IMPLICIT"
name = "creds"
description = "client creds"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "leveradminscpppp7mqsih6a6u60h7" {
consent = "IMPLICIT"
name = "lever-admin"
description = null
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "readallapiscpnybzac4ZzKKITz0h7" {
consent = "IMPLICIT"
name = "read-all-api"
description = null
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "serviceonereadscppkyo19zu84Mmoy0h7" {
consent = "IMPLICIT"
name = "serviceone.read"
description = "read access for your service"
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
}
resource "okta_auth_server_scope" "starbucksscopescpn488mz7FBsrSP90h7" {
consent = "IMPLICIT"
name = "starbucks-scope"
description = null
auth_server_id = "${okta_auth_server.bankingapiauslsufk8uOMda6v60h7.id}"
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
