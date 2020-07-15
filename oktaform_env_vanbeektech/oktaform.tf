resource "okta_policy_signon" "IPFilter00psi1lcb7tkt5DzZ0h7" {
status = "ACTIVE"
name = "IP Filter"
description = "static description"
}
resource "okta_policy_signon" "ForMarketing00pslokd2wg85i0g90h7" {
status = "ACTIVE"
name = "For Marketing"
description = "static description"
}
resource "okta_policy_rule_signon" "MFAoutofCountry0prsloktlfldX1e8H0h7" {
status = "ACTIVE"
name = "MFA out of Country"
policyid = "${okta_policy_signon.ForMarketing00pslokd2wg85i0g90h7.id}"
access = "ALLOW"
}
