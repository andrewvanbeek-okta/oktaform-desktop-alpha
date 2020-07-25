resource "okta_auth_server" "defaultausgub6xfsZCb1A5O0h7" {
audiences = ["api://payments"]
description = "Default Authorization Server for your Applications"
name = "default"
}

resource "okta_auth_server" "newdefaultserverausjztrgdgQqvCshE0h7" {
audiences = ["localhost:8080"]
description = null
name = "new default server"
}

