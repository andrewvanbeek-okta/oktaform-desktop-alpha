'use strict'

const path = require('path')
const isDevelopment = process.env.NODE_ENV !== 'production'
const axios = require('axios');
const fixPath = require('fix-path');
fixPath();


var getAppDataPath = function () {
  switch (process.platform) {
    case "darwin": {
      return path.join(process.env.HOME, "Library", "Application Support", "oktaform-desktop");
    }
    case "win32": {
      return path.join(process.env.APPDATA, "oktaform-desktop");
    }
    case "linux": {
      return path.join(process.env.HOME, "oktaform-desktop");
    }
    default: {
      console.log("Unsupported platform!");
      process.exit(1);
    }
  }
}



const init = async () => {
  var supportpath = ""
  var supportdirpath = ""
  const dotenv = require('dotenv');
  dotenv.config();
  //if (!isDevelopment) {
    supportpath = getAppDataPath()
    supportpath += "/"
    supportdirpath = getAppDataPath()
  //}

  // server.js
  // where your node app starts
  var oktatoken = process.env.OKTA_API_TOKEN
  var oktaurl = process.env.OKTA_URL
  // init project
  const express = require("express");
  const app = express();
  var cors = require("cors");
  var hcltojson = require("hcl-to-json");
  var fs = require("fs");
  var bodyParser = require("body-parser");
  var tmp = require('tmp');
  var history = require('connect-history-api-fallback')
  app.use(history());
  process.on('SIGINT', function () {
    console.log("\nGracefully shutting down from SIGINT (Ctrl-C)");
    process.exit(1);
  });

  var getFileContents = async function (filename) {
    console.log(supportpath + filename)
    console.log("########################in file contents")
    var contents = await fs.readFileSync(supportpath + filename).toString()
    console.log("########################in file contents")
    return contents
  }

  var getEnvironment = async function (name) {
    console.log("########################")
    var contents = await getFileContents(name)
    console.log("########################")
    return JSON.parse(contents)
  }

  var getFolderContents = async function (filename) {
    const dirpath = path.join(__dirname, '..')
    var EXTENSION = '.json';
    var directory_path = supportdirpath
    if (isDevelopment) {
      directory_path = dirpath
    }
  }


  app.use(bodyParser.json());

  class Group {
    constructor(group) {
      this.name = group.profile.name;
      this.description = group.profile.description;
      this.finalForm = tfGenerate(this, group, "okta_group", Object.keys(this));
    }
  }


  var tfGenerate = function (model, fullObject, resource, keys) {
    var name = fullObject.name || fullObject.profile.name
    name = name.replace(/[^a-zA-Z ]/g, "")
    console.log(name)
    console.log(fullObject)
    var header =
      "resource " +
      JSON.stringify(resource) +
      " " +
      JSON.stringify(name.replace(/\s+/g, '') + fullObject.id);
    var body = header + " {\n";
    keys.forEach(function (key) {
      var keyvalue = "";
      if (typeof model[key] === "string") {
        keyvalue = JSON.stringify(model[key]);
      } else {
        keyvalue = JSON.stringify(model[key]);
      }
      body = body + String(key) + " = " + keyvalue + "\n";
    });
    body = body + "}\n";
    return body;
  };

  var tfId = function (fullObject) {
    var name = fullObject.name || fullObject.profile.name
    name = name.replace(/[^a-zA-Z ]/g, "")
    console.log(name)
    console.log(fullObject)
    var header = name.replace(/\s+/g, '') + fullObject.id
    return header
  }

  var addArray = function(items) {
    var list = []
    list.push.apply(list, items)
    return list
  }

  var filterList = function(items, filter) {
   return items.map(function(item) { return item[filter] })
  }

  class OauthApp {
    constructor(app) {
      this.label = app.label;
      this.type = app.settings.oauthClient.application_type;
      this.grant_types = app.settings.oauthClient.grant_types;
      this.redirect_uris = app.settings.oauthClient.redirect_uris;
      this.response_types = app.settings.oauthClient.response_types;
      this.token_endpoint_auth_method = "client_secret_basic";
      this.consent_method = "TRUSTED"
      this.finalForm = tfGenerate(this, app, "okta_app_oauth", Object.keys(this));
      this.terraformId = tfId(app)
    }
  }


  class GroupRule {
    constructor(grouprule) {
      this.name = grouprule.name;
      this.status = grouprule.status
      this.group_assignments = addArray(grouprule.groupIds)
      this.expression_value = grouprule.conditions.expression.value
      this.finalForm = tfGenerate(this, grouprule, "okta_group_rule", Object.keys(this));
      this.terraformId = tfId(grouprule)
    }
  }

  class OidcIdp {
    constructor(idp) {
      this.name = idp.name;
      this.acs_type = "INSTANCE";
      this.acs_binding = "HTTP-POST";
      this.authorization_url = idp.protocol.endpoints.authorization.url;
      this.authorization_binding = idp.protocol.endpoints.authorization.binding;
      this.token_url = idp.protocol.endpoints.token.url;
      this.token_binding = idp.protocol.endpoints.token.binding;
      this.user_info_url = idp.protocol.endpoints.token.url || "https://placeholderfromokta.com"
      this.user_info_binding = "HTTP-REDIRECT"
      this.jwks_url = idp.protocol.endpoints.jwks.url;
      this.jwks_binding = idp.protocol.endpoints.jwks.binding;
      this.scopes = ["openid"];
      this.client_id = idp.protocol.credentials.client.client_id;
      this.client_secret = idp.protocol.credentials.client.client_secret;
      this.issuer_url = idp.protocol.issuer.url;
      this.username_template = "idpuser.email";
      this.finalForm = tfGenerate(this, idp, "okta_idp_oidc", Object.keys(this));
      this.terraformId = tfId(idp)
    }
  }

  class AuthorizationServer {
    constructor(server) {
      this.audiences = server.audiences;
      this.description = server.description;
      this.name = server.name;
      this.finalForm = tfGenerate(
        this,
        server,
        "okta_auth_server",
        Object.keys(this)
      )
      this.terraformId = tfId(server)
    }
  }

  class AuthPolicy {
    constructor(policy) {
      this.status = policy.status;
      this.name = policy.name;
      this.description = policy.description;
      this.priority = policy.priority;
      this.client_whitelist = ["ALL_CLIENTS"]
      this.auth_server_id = "${okta_auth_server." + policy.parentid + ".id}";
      this.finalForm = tfGenerate(
        this,
        policy,
        "okta_auth_server_policy",
        Object.keys(this)
      )
      this.terraformId = tfId(policy)
    }
  }

  class AuthScope {
    constructor(scope) {
      this.consent = scope.consent || "IMPLICIT"
      this.name = scope.name;
      this.description = scope.description;
      this.auth_server_id = "${okta_auth_server." + scope.parentid + ".id}";
      this.finalForm = tfGenerate(
        this,
        scope,
        "okta_auth_server_scope",
        Object.keys(this)
      )
      this.terraformId = tfId(scope)
    }
  }

  class AuthClaim {
    constructor(claim) {
      this.status = claim.status;
      this.name = claim.name;
      this.value_type = claim.valueType;
      this.value = claim.value;
      this.claim_type = claim.claimType;
      this.auth_server_id = "${okta_auth_server." + claim.parentid + ".id}";
      this.group_filter_type = claim.group_filter_type
      this.finalForm = tfGenerate(
        this,
        claim,
        "okta_auth_server_claim",
        Object.keys(claim.group_filter_type ? this : {name: this.name, status: this.status, value_type: this.value_type, value: this.value, claim_type: this.claim_type, auth_server_id: this.auth_server_id})
      )
      this.terraformId = tfId(claim)
    }
  }

  class SignOnPolicy {
    constructor(policy) {
      this.status = policy.status;
      this.name = policy.name;
      this.description = policy.description || "static description"
      this.finalForm = tfGenerate(
        this,
        policy,
        "okta_policy_signon",
        Object.keys(this)
      )
      this.terraformId = tfId(policy)
    }
  }

  class SignOnRule {
    constructor(rule) {
      this.status = rule.status;
      this.name = rule.name;
      this.policyid = "${okta_policy_signon." + rule.parentid + ".id}";
      this.access = rule.actions.access || rule.actions.signon.access
      this.finalForm = tfGenerate(
        this,
        rule,
        "okta_policy_rule_signon",
        Object.keys(this)
      )
      this.terraformId = tfId(rule)
    }
  }

  class AuthPolicyRule {
    constructor(rule) {
      this.status = rule.status;
      this.name = rule.name;
      this.description = rule.description;
      this.priority = rule.priority;
      this.group_whitelist = ["${data.okta_group.all.id}"];
      this.grant_type_whitelist = rule.conditions.grantTypes.include;
      this.policy_id = "${okta_auth_server." + rule.resourceName + ".id}";
      this.auth_server_id = "${okta_auth_server." + rule.parentid + ".id}";
      this.finalForm = tfGenerate(
        this,
        rule,
        "okta_auth_server_policy_rule",
        Object.keys(this)
      )
      this.terraformId = tfId(rule)
    }
  }

  class TrustedOrigin {
    constructor(origin) {
      this.name   = origin.name
      this.origin = origin.origin
      this.scopes = addArray(filterList(origin.scopes, "type"))
      this.finalForm = tfGenerate(
        this,
        origin,
        "okta_trusted_origin",
        Object.keys(this)
      )
      this.terraformId = tfId(origin)
    }
  }

  class ModelCreator {
    constructor(json) {
      this.modelType = json.type;
      this.modelJson = json.resource;
      this.create = function () {
        if (this.modelType && this.modelJson) {
          switch (this.modelType) {
            case "groups":
              return new Group(this.modelJson);
              break;
            case "authorizationServers":
              return new AuthorizationServer(this.modelJson);
              break;
            case "apps":
              return new OauthApp(this.modelJson);
              break;
            case "OAUTH_AUTHORIZATION_POLICY":
              return new AuthPolicy(this.modelJson);
              break;
            case "RESOURCE_ACCESS":
              return new AuthPolicyRule(this.modelJson);
              break;
            case "OKTA_SIGN_ON":
              return new SignOnPolicy(this.modelJson);
              break;
            case "SIGN_ON":
              return new SignOnRule(this.modelJson);
              break;
            case "OIDC":
              return new OidcIdp(this.modelJson);
              break;
            case "claims":
              return new AuthClaim(this.modelJson);
              break;
            case "trustedOrigins":
              return new TrustedOrigin(this.modelJson);
              break;
            case "groups/rules":
              return new GroupRule(this.modelJson);
              break;
            case "scopes":
              return new AuthScope(this.modelJson);
          }
        }
      };
      this.model = this.create();
    }
  }

  // http://expressjs.com/en/starter/static-files.html
  app.use(express.static("public"));
  app.use(cors());

  //["groups", "authorizationServers", "apps", "policies?type=OKTA_SIGN_ON", "policies?type=PASSWORD", "meta/schemas/user/default"]

  var refrenceModels = {
    groups:
      "https://raw.githubusercontent.com/articulate/terraform-provider-okta/master/examples/okta_group/okta_group.tf",
    apps:
      "https://raw.githubusercontent.com/articulate/terraform-provider-okta/master/examples/okta_app_oauth/basic.tf",
    authorizationServers:
      "https://raw.githubusercontent.com/articulate/terraform-provider-okta/master/examples/okta_auth_server/basic.tf"
  };

  var checkChildren = function hasChild(obj, key) {
    return typeof obj[key] === "object";
  };

  var filtered_keys = function (obj, filter) {
    var keys = [];
    for (var key in obj) {
      if (obj.hasOwnProperty(key) && filter.test(key)) {
        var keyHolder = String(key);
        var item = {};
        item[keyHolder] = obj[key];
        keys.push(item);
      }
    }
    return keys;
  };

  var filtered_object_keys = function (obj, filter) {
    var newObj = {};
    // array of onjects
    obj.forEach(function (object) {
      for (var key in object) {
        var keyString = String(key);
        var keyStringArray = keyString.split(".");
        var cleanedKey = keyStringArray[keyStringArray.length - 2];
        newObj[cleanedKey] = [];
      }
      for (var key in object) {
        var keyString = String(key);
        var keyStringArray = keyString.split(".");
        var cleanedKey = keyStringArray[keyStringArray.length - 2];
        newObj[cleanedKey].push(object[key]);
      }
    });

    return newObj;
  };

  var stringify = function (obj_from_json) {
    if (typeof obj_from_json !== "object" || Array.isArray(obj_from_json)) {
      var item = JSON.stringify(obj_from_json);
      if (item.includes) return JSON.stringify(obj_from_json);
    }
    let props = Object.keys(obj_from_json)
      .map(key => `${key}:${stringify(obj_from_json[key])}`)
      .join(",");
    return `{${props}}`;
  };

  var flattenObject = function (ob) {
    var toReturn = {};

    for (var i in ob) {
      if (!ob.hasOwnProperty(i)) continue;

      if (typeof ob[i] == "object") {
        var flatObject = flattenObject(ob[i]);
        for (var x in flatObject) {
          if (!flatObject.hasOwnProperty(x)) continue;

          toReturn[i + "." + x] = flatObject[x];
        }
      } else {
        toReturn[i] = ob[i];
      }
    }
    return toReturn;
  };

  // http://expressjs.com/en/starter/basic-routing.html
  app.get("/test", function (req, res) {
    console.log("HERE")
    var foldername = "oktaform_env_avb_tenant_for_real"
    var testsupportpath = getAppDataPath()
    testsupportpath += "/"
    var filename = "oktaform"
    console.log(testsupportpath + foldername + "/" + filename + ".tf")
    var content = ""
    if (fs.existsSync(testsupportpath + foldername + "/" + filename + ".tf")) {
      console.log("GETS IN HERE")
      content = fs.readFileSync(testsupportpath + foldername + "/" + filename + ".tf")
      console.log(content.toString())
    }

  });

  app.post("/writeAll", function (req, res) {
    var autogenerate = true
    //console.log(req.body)
    var filename = req.body.filename
    var itemsToWrite = [];
    var resources = req.body.resources;
    var foldername = req.body.foldername
    var childrenItems = req.body.items;
    for (var key in resources) {
      var currentModels = resources[key];
      currentModels.forEach(function (oktaJson) {
        var itemKey = key;
        if (key.includes("?type=")) {
          itemKey = key.split("?type=")[1];
        }
        var fullModel = new ModelCreator({ type: itemKey, resource: oktaJson });
        var finalForm = fullModel.model.finalForm;
        itemsToWrite.push(finalForm);
        console.log("CHILDREN BELOW ")
        if(oktaJson.children){
          oktaJson.children.forEach(function (child) {
            var childType = child.type
            console.log("HERE")
            child.childObjects.forEach(function (child) {
              child.parentid = fullModel.model.terraformId
              var childModel = new ModelCreator({ type: childType, resource: child })
              itemsToWrite.push(childModel.model.finalForm)
            })
          })
        }
        if(oktaJson.groups) {
          oktaJson.groups.forEach(function (group) {
            var groupModel = new ModelCreator({ type: "groups", resource: group })
            itemsToWrite.push(groupModel.model.finalForm)
          })
        }
      });
    }
    var content = ""
    if (fs.existsSync(supportpath + foldername + "/" + filename + ".tf")) {
      content = fs.readFileSync(supportpath + foldername + "/" + filename + ".tf")
      //console.log(content)
    }
    console.log(supportpath + foldername + "/default.tf")
    if (fs.existsSync(supportpath + foldername + "/default.tf")) {
      content += fs.readFileSync(supportpath + foldername + "/default.tf")
      console.log(content)
    }
    
    itemsToWrite.forEach(async function (item, index, array) {
     // console.log(item)
     console.log("CHECK")
    //  console.log(content.toString().trim())
    //  console.log(item.toString().trim())
     console.log(item.toString().trim() == content.toString().trim())
      console.log(content.toString().includes(item.toString()))
      console.log("CHECK")
      content = content.toString().trim()
      if (!content.includes(item.toString().trim())) {
        fs.appendFileSync(supportpath + foldername + "/" + filename + ".tf", item, function (err) {
          if (err)
            throw err;
        });
      }
      if (index === (array.length - 1)) {
        // This is the last one.
        if (autogenerate) {
          var util = require('util'),
            exec = require('child_process').exec;
          exec('terraform init && terraform apply -lock=false -auto-approve', {
            cwd: supportpath + foldername
          }, function (error, stdout, stderr) {
            // work with result
            console.log(error);
            console.log(stdout);
            console.log(stderr);
            if(stdout) {
              res.send({ message: stdout })
            } else {
              res.send({ message: stderr })
            }
     
          });

          //res.download(supportpath + foldername + "/" + filename + ".tf");
        }
        else {
          //res.download(supportpath + "oktaform.tf");
        }
      }


    });


  });

  app.get("/resource", async function (req, res) {
    var request = require("request");
    var object = req.query.resource;
    var oktaConfig = await getEnvironment(req.query.name)
    var url = oktaConfig.url
    var token = oktaConfig.apiToken
    var options = {
      method: "GET",
      url: req.query.url + "/api/v1/" + object,
      headers: {
        "Cache-Control": "no-cache",
        Authorization: "SSWS " + token,
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    request(options, function (error, response, body) {
      if (error) throw new Error(error);
      res.send(body);
    });
  });

  app.post("/resource", async function (req, res) {
    var request = require("request");
    console.log(req.body.name)
    var oktaConfig = await getEnvironment(req.body.name)
    var url = oktaConfig.url
    var token = oktaConfig.apiToken
    var object = req.body.resource
    var options = {
      method: "GET",
      url: url + "/api/v1/" + object,
      headers: {
        "Cache-Control": "no-cache",
        Authorization: "SSWS " + token,
        "Content-Type": "application/json",
        Accept: "application/json"
      }
    };
    request(options, function (error, response, body) {
      if (error) throw new Error(error);
      var oauthApplications = []
      if (req.body.resource == "apps") {
        var arrayBody = JSON.parse(body)
        arrayBody.forEach(function (app) {
          if (app.settings.oauthClient) {
            oauthApplications.push(app)
          }
        })
        console.log(oauthApplications)
        res.send(oauthApplications)
      } else {
        res.send(body);
      }
    });
  });

  app.delete("/removeFile", function (req, res) {
    var filename = req.query.filename
    var folder = req.query.path + "/"
    console.log(filename)
    console.log(filename)
    console.log(supportpath + folder + filename)
    fs.unlink(supportpath + folder + filename, (error) => {
      if (!error) {
        res.send({ "message": "deleted" })
        console.log("deleted")
      } else {
        console.log(error)
      }
    })
  })

  app.get("/children", async function (req, res) {
    var request = require("request");
    var oktaConfig = await getEnvironment(req.query.name)
    var href = req.query.href
    var token = oktaConfig.apiToken
    console.log(href)
    var options = {
      method: "GET",
      url: href,
      headers: {
        "Cache-Control": "no-cache",
        Authorization: "SSWS " + token,
        "Content-Type": "application/json",
        Accept: "application/json"
      },
      json: true
    };
    request(options, function (error, response, body) {
      console.log(body)
      var type = "none"
      if (body[0]) {
        type = body[0].type
      }
      res.send({ "children": body, "type": type });
    });
  })

  app.get("/files", async function (req, res) {
    const dirpath = path.join(__dirname, "..")
    var EXTENSION = '.tf';
    var name = req.query.name
    console.log(name)
    var directory_path = supportdirpath + "/" + name
    // console.log(directory_path)
    // if (isDevelopment) {
    //   directory_path = dirpath + "/" + name
    // }
    console.log(directory_path)
    fs.readdir(directory_path, function (err, files) {
      var filestosend = []
      if (files === undefined || files.length == 0) {
        // array empty or does not exist
        res.send({ error: "no files found", currentpath: directory_path })
      } else {
        var targetFiles = files.filter(function (file) {
          return path.extname(file).toLowerCase() === EXTENSION && path.basename(file) !== "init.tf"
        });
        targetFiles = targetFiles.map(function (file) {
          console.log(directory_path + "/" + file)
          var timestamp = fs.statSync(directory_path + "/" + file).mtime.getTime()
          const date = new Date(timestamp);
          return { name: file, timestamp: date, folder: name }
        })
        res.send({ files: targetFiles })
      }
    })
  })


  app.get("/apply", function (req, res) {
    var foldername = req.query.path
    console.log("gets to apply")
    console.log(supportpath + foldername)
    var util = require('util'),
      exec = require('child_process').exec;
    exec('terraform init && terraform apply -lock=false -auto-approve', {
      cwd: supportpath + foldername
    }, function (error, stdout, stderr) {
      // work with result
      console.log(error);
      console.log(stdout);
      console.log(stderr);
      res.send({ "message": stdout })
    });
  })

  app.post("/import", async function (req, res) {
    var foldername = req.body.name.split(".json")[0]
    var oktaConfig = await getEnvironment(req.body.name)
    var url = oktaConfig.url
    var token = oktaConfig.apiToken
    console.log(url + "/api/v1/authorizationServers/default")
    var headers = {
      "Authorization": "SSWS " + token, "Content-Type": "application/json",
      "Accept": "application/json"
    }
    var defaultObject = {}
    var resource = ""
    if(req.body.type == "authorizationServers") {
      var migratedServer = req.body.resource
      var getDefaultResourceServer = await axios.get(url + "/api/v1/authorizationServers?q=default&limit=1", { headers: headers })
      var defaultServer = getDefaultResourceServer.data[0]
      var serverAddress = tfId(migratedServer)
      var serverId = defaultServer.id
      var fullModel = new ModelCreator({ type: "authorizationServers", resource: migratedServer});
      var finalForm = fullModel.model.finalForm  + "\n"
      defaultObject = { "type": "okta_auth_server", tf: finalForm, id: serverId, address: serverAddress }
    } 

    var file = supportpath + foldername + "/default.tf"
    //if (!fs.existsSync(file)) {
      var content = ""
      if (fs.existsSync(supportpath + foldername + "/default.tf")) {
        content = fs.readFileSync(supportpath + foldername + "/default.tf")
        console.log(content)
      }
      console.log(supportpath + foldername + "/default.tf")
      var fullAddress = defaultObject.type + "." + defaultObject.address
      var resourceHeader = fullAddress.split(".").slice(0, 2).map(function(addressString){ return `"${addressString}"`}).join(" ")
      console.log("this is the resource header")
      console.log(resourceHeader)
      if (!content.includes(resourceHeader)){
        fs.appendFileSync(supportpath + foldername + "/default.tf", defaultObject.tf, function (err) {
          console.log(err)
        })

        console.log(fullAddress)
        const { spawn } = require('child_process');
        const child = spawn(`terraform init && terraform import ${fullAddress} ${defaultObject.id}`, {
          stdio: 'inherit',
          shell: true,
          cwd: supportpath + foldername
        });

        child.on('exit', function (code, signal) {
          console.log('child process exited with ' +
                      `code ${code} and signal ${signal}`);
        });

        child.stdout.on('data', (data) => {
          console.log(`child stdout:\n${data}`);
          res.send({message: data})
        });
        
        child.stderr.on('data', (data) => {
          console.error(`child stderr:\n${data}`);
        });
        // var util = require('util'),

        //   exec = require('child_process').exec;
        // exec(`terraform init && terraform import ${fullAddress} ${defaultObject.id}`, {
        //   cwd: supportpath + foldername
        // }, function (error, stdout, stderr) {
        //   // work with result
        //   console.log(error);
        //   console.log(stdout);
        //   console.log(stderr);
        //   //res.send({ "message": stdout })
        
        // });
      }
    //}
  })

  app.post("/environment", async function (req, res) {
    var environment = JSON.stringify(req.body)
    var filename = req.body.name
    console.log(environment)
    await fs.appendFile(supportpath + "oktaform_env_" + filename + ".json", environment, function (err) {
      if (err) {
        res.send(err)
      } else {
        res.send({ "message": "saved!" })
      }
    })
  })

  // app.get("/environments", async function (req, res) {

  //   const dirpath = path.join(__dirname, '..')
  //   var EXTENSION = '.json';
  //   var directory_path = supportdirpath
  //   if (isDevelopment) {
  //     directory_path = dirpath
  //   }
  //   fs.readdir(directory_path, function (err, files) {
  //     var targetFiles = files.filter(function (file) {
  //       return path.extname(file).toLowerCase() === EXTENSION && path.basename(file).includes("oktaform_env_")
  //     });
  //     if (targetFiles === undefined || targetFiles.length == 0) {
  //       // array empty or does not exist
  //       res.send({ error: "no files found", currentpath: directory_path })
  //     } else {
  //       targetFiles = targetFiles.map(function (file) {
  //         var timestamp = fs.statSync(file).mtime.getTime()
  //         const date = new Date(timestamp);
  //         return { name: file, timestamp: date }
  //       })
  //       res.send({ files: targetFiles })
  //     }
  //   })
  // })

    app.get("/environments", async function (req, res) {

    const dirpath = path.join(__dirname, '..')
    var EXTENSION = '.json';
    var directory_path = supportdirpath
    // if (isDevelopment) {
    //   directory_path = dirpath
    // }
    fs.readdir(directory_path, function (err, files) {
      var targetFiles = files.filter(function (file) {
        return path.extname(file).toLowerCase() === EXTENSION && path.basename(file).includes("oktaform_env_")
      });
      if (targetFiles === undefined || targetFiles.length == 0) {
        // array empty or does not exist
        res.send({ error: "no files found", currentpath: directory_path })
      } else {
        var filestosend = []
        console.log(targetFiles)
        targetFiles.forEach(async function (file, index, array) {
          if (path.extname(file).toLowerCase() === EXTENSION && path.basename(file).includes("oktaform_env_")) {
            var contents = await fs.readFileSync(supportpath + file).toString()
            console.log(contents.toString())
            filestosend.push({ name: file})

            console.log(filestosend)
            if (index === (array.length - 1)) {
              console.log(filestosend)
              res.send({ "files": filestosend })
            }
          }
        })
      }
    })
  })

  app.get("/environment", function (req, res) {
    console.log(req.query)

  })

  app.get("/implicit/callback", function (req, res) {
    console.log(req.query)
    res.redirect("oktaform://abc=1")
  })

  app.post("/migrationConfig", async function (req, res) {
    console.log("##########################################")
    var config = await getFileContents(req.body.name)
    console.log(config)
    config = JSON.parse(config)
    var orgname = config.url.split("https://")[1].split(".")[0]
    var orgtype = config.url.split("https://")[1].split(".")[1] + "." + config.url.split("https://")[1].split(".")[2]
    var tfFile =
      `provider "okta" {
      org_name  = "${orgname}" 
      api_token = "${config.apiToken}"
      base_url  = "${orgtype}"
    }`
    var configDir = req.body.name.split(".json")[0]
    var dir = ""
    if (isDevelopment) {
      dir = './' + configDir
    } else {
      dir = './' + supportpath + configDir
    }


    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir);
      fs.writeFileSync(supportpath + configDir + "/" + "init.tf", tfFile)
      res.send({ message: "file was overwritten" })
    } else {
      fs.writeFileSync(supportpath + configDir + "/" + "init.tf", tfFile);
      res.send({ message: "file was overwritten" })
    }
  })

  // listen for requests :
  const listener = app.listen(8000, function () {
    console.log(
      "Your app is listening port " +
      listener.address().port
    );
  });



};



import { app, protocol, BrowserWindow } from 'electron'
import {
  createProtocol,
  installVueDevtools
} from 'vue-cli-plugin-electron-builder/lib'
import { support } from 'jquery';
import { timeStamp } from 'console';
// const isDevelopment = process.env.NODE_ENV !== 'production'

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let win

// Scheme must be registered before the app is ready
protocol.registerSchemesAsPrivileged([{ scheme: 'app', privileges: { secure: true, standard: true } }])

function createWindow() {
  // Create the browser window.
  win = new BrowserWindow({
    icon: path.join(__static, 'icon.png'),
    width: 1000, height: 900, webPreferences: {
      nodeIntegration: true
    }
  })
  win.maximize()

  if (process.env.WEBPACK_DEV_SERVER_URL) {
    // Load the url of the dev server if in development mode
    win.loadURL(process.env.WEBPACK_DEV_SERVER_URL)
    if (!process.env.IS_TEST) win.webContents.openDevTools()
  } else {
    createProtocol('app')
    // Load the index.html when not in development
    win.loadURL('app://./index.html')
  }

  win.on('closed', () => {
    win = null
  })
}

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow()
  }
})

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', async () => {
  init()
  if (isDevelopment && !process.env.IS_TEST) {
    // Install Vue Devtools
    // Devtools extensions are broken in Electron 6.0.0 and greater
    // See https://github.com/nklayman/vue-cli-plugin-electron-builder/issues/378 for more info
    // Electron will not launch with Devtools extensions installed on Windows 10 with dark mode
    // If you are not using Windows 10 dark mode, you may uncomment these lines
    // In addition, if the linked issue is closed, you can upgrade electron and uncomment these lines
    // try {
    //   await installVueDevtools()
    // } catch (e) {
    //   console.error('Vue Devtools failed to install:', e.toString())
    // }
    protocol.registerFileProtocol('oktaform', (request, callback) => {
      console.log("was hit!!!")
      console.log(request)
      //parse authorization code from request 

    }, (error) => {
      if (error) console.error('Failed to register protocol')
    })

  }
  createWindow()
})

app.on('open-url', function (event, data) {
  event.preventDefault();
});

app.setAsDefaultProtocolClient('oktaform');

// Exit cleanly on request from parent process in development mode.
if (isDevelopment) {
  if (process.platform === 'win32') {
    process.on('message', data => {
      if (data === 'graceful-exit') {
        app.quit()
      }
    })
  } else {
    process.on('SIGTERM', () => {
      app.quit()
    })
  }
}

