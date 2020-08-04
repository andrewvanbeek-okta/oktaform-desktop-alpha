<template>
  <div class="wrapper">
    <div id="cover">
      <center>
        <atom-spinner class="loader" :animation-duration="1000" :size="600" :color="'#ff1d5e'" />
      </center>
    </div>
    <div>
      <parallax class="section page-header" :style="headerStyle">
        <div class="container">
          <div class="md-layout">
            <div class="md-layout-item md-size-50 md-small-size-70 md-xsmall-size-100">
              <br />
              <md-button v-on:click="showCreateConfig()" class="md-danger md-lg">
                <i class="fas fa-plus"></i> Add Config
              </md-button>
            </div>
          </div>
        </div>
      </parallax>
      <div class="main main-raised">
        <div class="section">
          <div class="container">
            <div class="md-layout">
              <div class="md-layout-item md-size-66 md-xsmall-size-100 mx-auto text-center">
                <h2 class="title text-center">Let's talk Oktaform</h2>
                <h5
                  class="description"
                >This tool helps manage and sync configurations from one Okta tenant to another, while also automatically generating terraform files for you. Each okta tenant that use to sync here will gets own folder in you application support libary for this app, so you have automated orgainzation across multiple environments. Additionally migrate complex config is now as easy as point and click. We will not be able to get everything but we will be able to get 80% of it.</h5>
              </div>
            </div>
            <div class="features text-center">
              <div class="md-layout">
                <div class="md-layout-item md-medium-size-33 md-small-size-100">
                  <img src="https://miro.medium.com/max/960/0*3i0MOCi2wHX607Jp.png" />
                  <h4 class="info-title">Terraform</h4>
                  <p>Ah yeah Infrastructure code, lets automate some config. Oktaform is going to allow you to automigrate your data from one okta tenant to another. If you are new to okta check out https://www.terraform.io/docs/providers/okta/index.html.</p>
                </div>
              </div>
              <div class="md-layout-item md-medium-size-33 md-small-size-100">
                <div class="info">
                  <img
                    src="https://www.okta.com/sites/all/themes/Okta/images/logos/developer/Thumbnail-folderDeveloper.png"
                  />
                  <h4 class="info-title">Okta</h4>
                  <p>The MVP OF IDPS, If you are trying to secure the perimeter that us ya know. But if you are using this tool you like know that. We will use oktaform to manage our many environments. Learn more at https://developer.okta.com</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="section section-contacts">
        <div class="container">
          <md-speed-dial md-direction="bottom" class="md-danger md-top-right md-just-icon md-round">
            <md-speed-dial-target class="md-danger md-just-icon md-round">
              <md-icon class="md-morph-initial">menu</md-icon>
              <md-icon class="md-morph-final">settings</md-icon>
            </md-speed-dial-target>

            <md-speed-dial-content>
              <md-button v-on:click="getEnvironments()" class="md-danger md-round md-lg">
                <md-icon>note</md-icon>List Environments
              </md-button>
              <md-button v-on:click="showDelete()" class="md-danger md-round md-lg">
                <md-icon>note</md-icon>List Terraform Files
              </md-button>

              <md-button v-on:click="showCreateConfig()" class="md-danger md-round md-lg">
                <md-icon>add</md-icon>Add Configs
              </md-button>
              <md-button v-on:click="resetPage()" class="md-danger md-round md-lg">
                <md-icon>refresh</md-icon>Reset
              </md-button>
            </md-speed-dial-content>
          </md-speed-dial>
          <md-switch class="md-top-right" v-model="autogenerate">Auto Migrate is on</md-switch>
          <div class="md-layout">
            <div
              style="align-items: flex-start;"
              class="md-layout-item md-size-100 md-xsmall-size-100 mx-auto"
            >
              <h2 class="text-center title">Okta Details</h2>
              <h4
                class="text-center description"
              >Just Provide your Api key and URL. We do not transmit this anywhere else.</h4>
              <form class="contact-form">
                <md-field maxlength="20">
                  <label>Name Your File</label>
                  <md-input v-model="filename"></md-input>
                </md-field>
              </form>
              <br />
              <br />
              <br />
              <form class="contact-form">
                <div class="md-layout">
                  <div class="md-layout-item md-size-50 md-small-size-100 mr-auto">
                    <login-card header-color="green">
                      <h4 slot="title" class="card-title">Okta Tenant 1</h4>
                      <p
                        slot="description"
                        class="description"
                      >Place the Okta url and api token you want to pull data from here</p>
                      <md-field class="md-form-group" slot="inputs">
                        <label for="Config">Config</label>
                        <md-select v-model="tenantOneConfig" name="Config" id="Config">
                          <md-option
                            v-for="env in environments"
                            :value="env.name"
                          >{{env.name.split("oktaform_env_")[1].split(".json")[0]}}</md-option>
                        </md-select>
                      </md-field>
                    </login-card>
                  </div>
                  <div class="md-layout-item md-size-50 md-small-size-100 mr-auto">
                    <login-card header-color="green">
                      <h4 slot="title" class="card-title">Okta Tenant 2</h4>
                      <p
                        slot="description"
                        class="description"
                      >Place the Okta url and api token you want to migrate data to here</p>
                      <md-field class="md-form-group" slot="inputs">
                        <label for="Config">Config</label>
                        <md-select
                          v-model="tenantTwoConfig"
                          @md-selected="applyEnvironmentTwo()"
                          name="Config"
                          id="Config"
                        >
                          <md-option
                            v-for="env in environments"
                            :value="env.name"
                          >{{env.name.split("oktaform_env_")[1].split(".json")[0]}}</md-option>
                        </md-select>
                      </md-field>
                    </login-card>
                  </div>
                </div>
              </form>
              <br />
              <br />
              <br />
              <div class="md-layout">
                <div class="md-layout-item md-size-33 mx-auto text-center">
                  <md-button v-on:click="pullResources()" class="md-danger">Get Okta Config</md-button>
                </div>
              </div>
              <!-- <v-text-field
                v-model="search"
                append-icon="search"
                label="Search"
                single-line
                hide-details
              ></v-text-field>-->

              <center></center>
              <vue-tabs>
                <v-tab v-for="(table, i) in tables" v-if="renderComponent" :title="tables[i].title">
                  <div style="align-items: flex-start;" class="full-table">
                    <h1>{{tables[i].title}}</h1>
                    <br />
                    <br />
                    <v-text-field
                      v-model="search"
                      append-icon="search"
                      label="Search"
                      single-line
                      hide-details
                    ></v-text-field>

                    <v-data-table
                      :headers="tables[i].headers"
                      :items="tables[i].respData"
                      :search="search"
                      :single-select="true"
                      :item-key="tables[i].title"
                      show-select
                    >
                      <template v-slot:item.data-table-select="props">
                        <v-checkbox
                          :input-value="resources[tables[i].title].includes(props.item)"
                          @change="onSelect(props.item, tables[i].title)"
                        ></v-checkbox>
                      </template>
                      <template #item.profile_name="{ item }">
                        <span v-if="item.profile">{{item.profile.name}}</span>
                        <span v-else>Not Applicable</span>
                      </template>
                    </v-data-table>
                    <md-badge class="md-primary" :md-content="resources[tables[i].title].length">
                      <v-btn
                        class="ma-0"
                        v-show="true"
                        @click="show()"
                        color="pink"
                        fab
                        dark
                        small
                        absolute
                        bottom
                        right
                      >
                        <v-icon>mdi-cart</v-icon>
                      </v-btn>
                    </md-badge>
                  </div>
                </v-tab>
              </vue-tabs>
            </div>
          </div>
        </div>
      </div>
      <md-button v-on:click="sendSelected()" class="md-danger">Generate</md-button>
      <modal name="hello-world" :adaptive="true" :scrollable="true" width="80%" height="auto">
        <div v-for="(table, i) in addedTables" v-if="renderComponent" class="full-table">
          <h3>{{addedTables[i].title}}</h3>

          <v-data-table
            :headers="addedTables[i].headers"
            :items="addedTables[i].respData"
            :single-select="true"
            item-key="name"
            show-select
          >
            <template v-slot:item.data-table-select="props">
              <v-icon
                small
                @click="deleteItem(props.item, addedTables[i].title)"
              >mdi-arrow-left-bold-hexagon-outline</v-icon>
              <v-icon
                small
                @click="appendToName(props.item, addedTables[i].title)"
              >mdi-format-annotation-plus</v-icon>
            </template>
          </v-data-table>
        </div>
      </modal>
      <modal name="delete" :adaptive="true" :scrollable="true" width="80%" height="auto">
        <div v-if="renderComponent" class="full-table">
          <h1>Your Different Environments</h1>
          <md-table v-model="folders" md-sort="timestamp" md-sort-order="asc" md-card>
            <md-table-row slot-scope="{ item }" slot="md-table-row">
              <md-table-cell md-label="Name">{{ item.name }}</md-table-cell>
              <md-table-cell md-label="View Folder Contents" md-sort-by="name">
                <md-button v-on:click="showFiles(item.name)" class="md-icon-button">
                  <md-icon>folder</md-icon>
                </md-button>
              </md-table-cell>
            </md-table-row>
          </md-table>
        </div>
      </modal>
      <modal name="folder_files" :adaptive="true" :scrollable="true" width="80%" height="auto">
        <div v-if="renderComponent" class="full-table">
          <h1>Delete Models and Files</h1>
          <md-table v-model="files" md-sort="timestamp" md-sort-order="asc" md-card>
            <md-table-toolbar>
              <h1 class="md-title">With auto select and alternate headers</h1>
            </md-table-toolbar>
            <md-table-toolbar slot="md-table-alternate-header" slot-scope="{ count }">
              <div class="md-toolbar-section-start">{{ getAlternateLabel(count) }}</div>
              <div class="md-toolbar-section-end">
                <md-button class="md-icon-button">
                  <md-icon>delete</md-icon>
                </md-button>
              </div>
            </md-table-toolbar>
            <md-table-row slot-scope="{ item }" slot="md-table-row">
              <md-table-cell md-label="Name">{{ item.name }}</md-table-cell>
              <md-table-cell
                md-label="Delete File and destroy resources in tenant "
                md-sort-by="name"
              >
                <md-button v-on:click="deleteFileAndApply(item)" class="md-icon-button">
                  <md-icon>delete</md-icon>
                </md-button>
              </md-table-cell>
            </md-table-row>
          </md-table>
        </div>
      </modal>
      <v-dialog v-model="dialog" width="600px">
        <v-card>
          <v-card-title>
            <span class="headline">Response</span>
          </v-card-title>
          <v-card-text>{{serverResponse}}</v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="resetPage()">Close</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-dialog v-model="schema" width="600px">
        <v-card>
          <v-card-title>
            <span class="headline">Identity is everything: User Schemas do not match</span>
          </v-card-title>
          <v-card-text>
            Oktaform has detected that the user schemas from Okta tenant Two are missing values from Okta tenant One,
            <strong>WARNING If you click resolve you will automatically resolve the differences and adding the missing schema properties, this action cannot not be reverted via Oktaform. Additionally if you have issues CHECK THAT THE SAME FEATURES ARE ENABLED</strong>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="green darken-1" text @click="resolveSchema()">resolve</v-btn>
            <v-btn color="green darken-1" text @click="schema = false">Close</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-dialog v-model="schemaTable" width="600px">
        <v-card>
          <v-card-title>
            <span class="headline">Attributes Added</span>
          </v-card-title>
          <v-data-table
            :headers="attributesAddedHeaders"
            :items="attributesAdded"
            :items-per-page="20"
            class="elevation-1"
          ></v-data-table>
          <v-card-actions>
            <v-btn color="green darken-1" text @click="schemaTable = false">Close</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <modal name="spinner" :adaptive="true" :scrollable="true" width="50%" height="auto">
        <center>
          <h3>Hold tight</h3>
          <atom-spinner :animation-duration="1000" :size="60" :color="'#ff1d5e'" />
        </center>
      </modal>
      <modal name="create_config" :adaptive="true" :scrollable="true" width="50%" height="auto">
        <form class="contact-form">
          <div class="md-layout">
            <div class="md-layout-item md-size-100 md-small-size-100 mr-auto">
              <login-card header-color="md-danger" class="md-danger">
                <h4 slot="title" class="card-title">Your Okta Tenant</h4>
                <p
                  slot="description"
                  class="description"
                >Place the Okta url and api token you want to pull data from here</p>
                <md-field class="md-form-group" slot="inputs">
                  <md-icon>text-snippet</md-icon>
                  <label>Tenant Config Name</label>
                  <md-input v-on:change="checkIfEmpty(environmentName)" v-model="environmentName"></md-input>
                  <span v-if="emptyNameField" class="md-danger" style="color: red;">Cannot be empty</span>
                </md-field>
                <md-field class="md-form-group" slot="inputs">
                  <md-icon>web</md-icon>
                  <label>Okta Url</label>
                  <md-input v-on:change="checkIfUrl()" v-model="environmentUrl"></md-input>
                  <span v-if="badUrl" class="md-danger" style="color: red;">Not a proper Okta Url</span>
                  <span v-if="emptyUrlField" class="md-danger" style="color: red;">Cannot be empty</span>
                </md-field>
                <md-field class="md-form-group" slot="inputs">
                  <md-icon>lock_outline</md-icon>
                  <label>Api Token</label>
                  <md-input
                    type="password"
                    v-on:change="checkIfEmpty(environmentToken)"
                    v-model="environmentToken"
                  ></md-input>
                  <span v-if="emptyTokenField" class="md-danger" style="color: red;">Cannot be empty</span>
                </md-field>
                <md-button
                  slot="footer"
                  v-on:click="saveEnvironment()"
                  class="md-simple md-danger md-lg"
                >Save</md-button>
              </login-card>
            </div>
          </div>
        </form>
      </modal>
    </div>
  </div>
</template>

<script>
import Spinner from "vue-spinner-component/src/Spinner.vue";
import { VueTabs, VTab } from "vue-nav-tabs";
import "vue-nav-tabs/themes/vue-tabs.css";
import { NavTabsCard } from "@/components";
import $ from "jquery";
import Api from "@/services/api/Api";
import { AtomSpinner } from "epic-spinners";
import FileDownload from "js-file-download";
import Loading from "vue-loading-overlay";
import { LoginCard } from "@/components";

function getSafe(fn, defaultVal) {
  try {
    return fn();
  } catch (e) {
    return defaultVal;
  }
}

var tfId = function (fullObject) {
  var name = fullObject.name || fullObject.profile.name;
  name = name.replace(/[^a-zA-Z ]/g, "");
  console.log(name);
  console.log(fullObject);
  var header = name.replace(/\s+/g, "") + fullObject.id;
  return header;
};

export default {
  bodyClass: "landing-page",
  props: {
    header: {
      type: String,
      default: require("@/assets/img/bg7.jpg"),
    },
    teamImg1: {
      type: String,
      default: require("@/assets/img/faces/avatar.jpg"),
    },
    teamImg2: {
      type: String,
      default: require("@/assets/img/faces/christian.jpg"),
    },
    teamImg3: {
      type: String,
      default: require("@/assets/img/faces/kendall.jpg"),
    },
  },
  components: {
    AtomSpinner,
    VueTabs,
    Spinner,
    VTab,
    LoginCard,
    NavTabsCard,
  },
  data() {
    return {
      url: null,
      resources: {},
      schema: false,
      singleSelect: false,
      attributesAdded: [],
      attributesAddedHeaders: [],
      schemaTable: false,
      search: "",
      policies: [],
      dialog: false,
      badUrl: false,
      folders: [],
      tenantOneConfig: "",
      tenantTwoConfig: "",
      tenantTwoName: "",
      tenantOneName: "",
      emptyTokenField: "",
      emptyUrlField: "",
      emptyNameField: "",
      autogenerate: true,
      environmentUrl: "",
      environmentToken: "",
      environmentName: "",
      environments: [],
      classicModal: true,
      classicModalHide: false,
      rules: [],
      serverResponse: "",
      oktaTenantOneUrl: "",
      oktaTenantOneApiToken: "",
      oktaTenantTwoUrl: "",
      oktaTenantTwoApiToken: "",
      apiToken: null,
      message: null,
      searched: "",
      selected: [],
      loading: "",
      filename: "oktaform",
      renderComponent: true,
      tables: [],
      addedTables: [],
      render: false,
      files: [{ name: "test" }],
      rezources: [],
    };
  },
  methods: {
    spinning(value) {
      if (value) {
        this.$modal.show("spinner");
      } else {
        this.$modal.hide("spinner");
      }
    },
    checkIfUrl() {
      this.checkIfEmpty();
      if (
        this.environmentUrl.includes("okta") &&
        this.environmentUrl.includes("https://")
      ) {
        this.badUrl = false;
        this.emptyUrlField = false;
      } else {
        this.badUrl = true;
      }
    },
    checkIfEmpty() {
      if (this.environmentName != "") {
        this.emptyNameField = false;
      }
      if (this.environmentToken != "") {
        this.emptyTokenField = false;
      }
      if (this.environmentUrl != "") {
        this.emptyUrlField = false;
      }
    },
    show() {
      var component = this;
      this.addedTables = [];
      for (var key in this.resources) {
        if (
          this.resources.hasOwnProperty(key) &&
          this.resources[key].length != 0
        ) {
          var headers = Object.keys(this.resources[key][0]);
          headers = headers.map(function (oktaResourceKey) {
            return {
              text: oktaResourceKey,
              value: oktaResourceKey,
            };
          });
          var table = {
            title: key,
            respData: this.resources[key],
            headers: headers,
          };
          console.log("CHECK THIS OUT");
          console.log(table);
          console.log("CHECK THIS OUT");
          component.addedTables.push(table);
        }
      }
      console.log("YEAH");
      this.$modal.show("hello-world");
    },
    async openConfig() {
      console.log("JKNDKBFKDBK");
      this.$modal.show("configure");
    },
    async resetPage() {
      this.dialog = false;
      console.log(this.$router);
      window.location.reload();
    },
    async showDelete() {
      var component = this;
      component.folders = component.environments.map(function (file) {
        return { name: file.name.split(".json")[0], timestamp: file.timestamp };
      });
      this.$modal.show("delete");
    },
    async showFiles(item) {
      var component = this;
      var name = item;
      console.log(name);
      var getFiles = await component.$http.get(
        "http://localhost:8000/files?name=" + name
      );
      this.files = getFiles.data.files;
      this.$modal.show("folder_files");
    },
    hide() {
      this.$modal.hide("hello-world");
    },
    changeItem(item) {
      console.log("TESTSTS");
      console.log(item);
    },
    async deleteItem(item, resource) {
      var component = this;
      component.resources[resource] = component.resources[resource].filter(
        function (obj) {
          return obj.id !== item.id;
        }
      );
      console.log(item);
      component.show();
    },
    sendSelected() {
      var component = this;
      component.spinning(true);
      var resources = component.selected;
      var allItems = component.policies.concat(component.rules);
      component.$http
        .post(`http://localhost:8000/writeAll`, {
          resources: component.resources,
          items: allItems,
          filename: component.filename,
          foldername: component.tenantTwoConfig.split(".json")[0],
        })
        .then((response) => {
          console.log(response.data);
          component.spinning(false);
          console.log("here");
          component.showResponse(response.data);
        })
        .catch((e) => {
          console.log(e);
        });
    },
    async deleteFileAndApply(file) {
      var component = this;
      component.spinning(true);
      component.$http
        .delete(
          "http://localhost:8000/removeFile?filename=" +
            file.name +
            "&path=" +
            file.folder
        )
        .then((response) => {
          component.$http
            .get("http://localhost:8000/apply?path=" + file.folder)
            .then((response) => {
              component.showResponse(response.data);
              component.spinning(false);
            });
        });
    },
    showResponse(response) {
      var component = this;
      this.serverResponse = response.message;
      this.dialog = true;
    },
    appendToName(item, resource) {
      var component = this;
      if (!item.name.includes(" from oktaform")) {
        item.name = item.name + " from oktaform";
      } else {
        item.name = item.name.split(" from oktaform")[0];
      }
      component.deleteItem(item, resource);
      component.resources[resource].push(item);
      component.show();
    },
    showCreateConfig() {
      this.$modal.show("create_config");
    },
    async saveEnvironment() {
      var component = this;
      if (
        component.environmentUrl != "" &&
        component.environmentName != "" &&
        component.environmentToken != "" &&
        !component.badUrl
      ) {
        var saveEnv = await component.$http.post(
          "http://localhost:8000/environment",
          {
            url: component.environmentUrl.trim(),
            apiToken: component.environmentToken.trim(),
            name: component.environmentName,
          }
        );
        console.log(saveEnv);
        if (saveEnv.data.message === "saved!") {
          component.getEnvironments();
          component.resetPage();
        }
      } else {
        if (component.environmentUrl == "") {
          component.emptyUrlField = true;
        }
        if (component.environmentToken == "") {
          component.emptyTokenField = true;
        }
        if (component.environmentName == "") {
          component.emptyNameField = true;
        }
      }
    },
    async getEnvironments() {
      var component = this;
      var getEnvs = await component.$http.get(
        "http://localhost:8000/environments"
      );
      console.log(getEnvs);
      component.environments = getEnvs.data.files;
    },
    async findEnvironment(name) {
      var environment = await this.environments.find(function (
        environment_config
      ) {
        return environment_config.name === name;
      });
      return environment;
    },
    async resolveSchema() {
      var component = this;
      var setConfig = await this.$http.post("http://localhost:8000/schemas", {
        tenantOne: this.tenantOneConfig,
        tenantTwo: this.tenantTwoConfig,
      });
      console.log(setConfig.data);
      component.attributesAdded = Object.values(
        setConfig.data.missingProperties
      );
      component.attributesAddedHeaders = [
        {
          text: "title",
          align: "start",
          sortable: false,
          value: "title",
        },
        { text: "type", value: "type" },
      ];
      component.schema = false;
      component.schemaTable = true;
    },
    async applyEnvironmentTwo() {
      this.tenantTwoName = this.tenantTwoConfig
        .split("oktaform_env_")[1]
        .split(".json")[0];
      var setConfig = await this.$http.post(
        "http://localhost:8000/migrationConfig",
        { name: this.tenantTwoConfig }
      );
      //this.defaultImport()
      console.log(setConfig);
      this.schema = true;
    },
    async pullResources() {
      this.tenantOneName = this.tenantOneConfig
        .split("oktaform_env_")[1]
        .split(".json")[0];
      var component = this;
      component.tables = [];
      //component.resources = []
      const baseURI = "";
      var resources = [
        "groups",
        "groups/rules",
        "authorizationServers",
        "apps",
        "policies?type=OKTA_SIGN_ON",
        "idps",
        "idps?type=OIDC",
        "idps?type=SAML2",
        "idps?type=GOOGLE",
        "idps?type=FACEBOOK",
        "trustedOrigins",
        "policies?type=PASSWORD",
        "policies?type=IDP_DISCOVERY",
        "inlineHooks",
        "eventHooks",
        "zones"
      ];
      resources.forEach(async function (rez) {
        component.resources[rez] = [];
        component.$http
          .post("http://localhost:8000/resource", {
            name: component.tenantOneConfig,
            resource: rez,
          })
          .then(async function (response) {
            var objectBase = Object.keys(response.data[0]);
            if (
              objectBase.includes("profile") &&
              !objectBase.includes("name")
            ) {
              console.log("HERE in the SPLICER");
              objectBase.splice(2, 0, "profile_name");
            }
            console.log(objectBase);
            var headers = objectBase;
            headers = headers.map(function (oktaResourceKey) {
              return {
                text: oktaResourceKey,
                value: oktaResourceKey,
              };
            });
            var table = {
              title: rez,
              respData: response.data,
              headers: headers,
            };
            if (table.title == "policies?type=IDP_DISCOVERY") {
              console.log("HERE HERE");
              if (table.respData) {
                var item = getSafe(() => table.respData[0]);
                console.log(`item ${item}`);
                console.log(item);
                var links = Object.keys(item._links)
                  .filter(function (link) {
                    return (
                      link.toString() == "claims" ||
                      link.toString() == "scopes" ||
                      link.toString() == "rules" ||
                      link.toString() == "policies"
                    );
                  })
                  .map(function (filteredlink) {
                    return item._links[filteredlink].href;
                  });
                var children = await component.getChildrenCollection(links);
                table.respData = getSafe(() => children[0].childObjects);
              }
            }
            console.log("BELOW IS THE TABLE");
            console.log(headers);
            component.tables.push(table);
            component.rezources = response.data;
            component.renderComponent = false;
            component.$nextTick(() => {
              component.renderComponent = true;
            });
          })
          .catch(function (error) {
            console.log(error);
          });
      });
    },
    async onSelect(item, resource) {
      var component = this;
      console.log(component.selected);
      if (!component.resources[resource].includes(item)) {
        if (resource != "idps") {
          component.resources[resource].push(item);
        } else {
          resource += "?type=" + item.type;
        }

        var mostRecentItem = item;
        if (mostRecentItem._links) {
          //var links = component.mapLinks(mostRecentItem)
          var links = Object.keys(mostRecentItem._links)
            .filter(function (link) {
              return (
                link.toString() == "claims" ||
                link.toString() == "scopes" ||
                link.toString() == "rules" ||
                link.toString() == "policies"
              );
            })
            .map(function (filteredlink) {
              return item._links[filteredlink].href;
            });
          var children = await component.getChildrenCollection(links);
          component.resources[resource][
            component.resources[resource].length - 1
          ]["children"] = await children;
        }

        if (item.name.toUpperCase().includes("DEFAULT") && item.system) {
          component.resources[resource][
            component.resources[resource].length - 1
          ].name = "Oktaform:default: " + component.tenantOneName;
        }

        if (item.name == "Idp Discovery Policy") {
          component.defaultImport(item);
        }
        if (item.name.toUpperCase().includes("DEFAULT")) {
          if (item._links.self.href.includes("authorizationServers")) {
            component.defaultImport(item);
          }
        }
        if (item.actions || item.conditions) {
          component.findIncludes(item);
        }
        component.show();
      } else {
        component.deleteItem(item, resource);
      }
    },
    async defaultImport(item) {
      this.$http.post(`http://localhost:8000/import`, {
        name: this.tenantTwoConfig,
        resource: item,
        type: item._links.self.href.split("v1/")[1].split("/")[0],
      });
    },
    async findIncludes(item) {
      //type group_rule, IDP_DISCOVERY, OKTA_SIGN_ON, PASSWORD
      var itemType = {
        group_rule: {
          tobeAdded: await getSafe(
            () => item.actions.assignUserToGroups.groupIds
          ),
          type: "groups",
        },
        OKTA_SIGN_ON: {
          tobeAdded: await getSafe(() => item.conditions.people.groups.include),
          type: "groups",
        },
        PASSWORD: {
          tobeAdded: await getSafe(() => item.conditions.people.groups.include),
          type: "groups",
        },
        IDP_DISCOVERY: {
          tobeAdded: await getSafe(() => item.actions.idp.providers),
          multiple: true,
          type: "idps",
        },
      };
      var resourcesToAdd = [];
      if (!itemType[item.type].multiple) {
        resourcesToAdd = await itemType[item.type].tobeAdded;
        console.log(resourcesToAdd);
        var groups = await this.tables.find(function (resource) {
          return resource.title === itemType[item.type].type;
        });
        console.log("#####");
        console.log(groups);
        console.log("#####");
        item.groups = groups.respData.filter(function (resource) {
          return resourcesToAdd.includes(resource.id);
        });
        item.groupIds = item.groups.map(function (item) {
          return "${okta_group." + tfId(item) + ".id}";
        });
      } else {
        console.log(await itemType[item.type])
        resourcesToAdd = await itemType[item.type].tobeAdded.map(function(idp) {
          return idp.id
        })
         var idps = await this.tables.find(function (resource) {
          return resource.title === itemType[item.type].type;
        });
        console.log("find this")
        console.log(resourcesToAdd)
        console.log(idps)
        console.log("find this")
        item.idps = idps.respData.filter(function (resource) {
          return resourcesToAdd.includes(resource.id);
        });
        console.log(item.idps)
        item.idpIds = item.idps.map(function (item) {
          var idpTypes = {"OIDC": "okta_idp_oidc.", "SAML2": "okta_idp_saml.", "FACEBOOK": "okta_idp_social.", "GOOGLE": "okta_idp_social."}
          return "${" + idpTypes[item.type] + tfId(item) + ".id}";
        });
        console.log(item.idpIds)
      }

      return resourcesToAdd;
    },
    async getChildrenCollection(links) {
      var component = this;
      links = Promise.all(
        links.map(async function (link) {
          var child = await component.getChildrenModels(link);
          var type = child.type || link.split("/")[link.split("/").length - 1];
          return { type: type, childObjects: child.children };
        })
      );
      return links || [];
    },
    async getChildrenModels(href) {
      var component = this;
      var getChild = await component.$http.get(
        "http://localhost:8000/children?href=" +
          href +
          "&name=" +
          component.tenantOneConfig
      );
      console.log(getChild.data);
      var children = getChild.data.children.filter(function (childResource) {
        return !childResource.system;
      });
      return { type: getChild.data.type, children: children };
    },
    getAlternateLabel(count) {
      let plural = "";

      if (count > 1) {
        plural = "s";
      }

      return `${count} user${plural} selected`;
    },
  },
  mounted() {
    this.getEnvironments();
  },
  computed: {
    headerStyle() {
      return {
        backgroundImage: `url(https://cdn.glitch.com/4804aa21-14f8-431e-b8d7-87a67866858a%2FOKTAFORMBIGGER.png?v=1567701043120)`,
      };
    },
  },
};
</script>

<style lang="scss" scoped>
.md-card-actions.text-center {
  display: flex;
  justify-content: center !important;
}
.contact-form {
  margin-top: 30px;
}

.full-table {
  min-width: 100%;
  margin-left: 0px;
}

.md-table {
  min-width: 100vh;
  float: left;
}

.md-has-textarea + .md-layout {
  margin-top: 15px;
}

.loader {
  position: fixed;
  width: 100%;
  height: 100%;
  z-index: 9999;
}

#cover {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  opacity: 0.8;
  background: #aaa;
  z-index: 10;
  display: none;
}

.allow-scroll {
  overflow-y: scroll;
}

.pirate {
  position: -webkit-sticky;
  position: sticky;
  top: 4rem;
}

.v--modal-overlay[data-modal="spinner"] {
  background: white;
}

.v--modal-overlay[data-modal="spinner"] .v--modal-box {
  position: relative;
  overflow: hidden;
  box-sizing: border-box;
  background: transparent;
}

div.md-card-header.md-danger {
  background-color: #c9446e;
}

.dialog-content {
  flex: 10 auto;
  width: 100%;
  padding: 15px;
  font-size: 14px;
  max-height: 50em;
  overflow-y: scroll;
}

.dialog-content {
  flex: 10 auto;
  width: 100%;
  padding: 15px;
  font-size: 14px;
  height: 10em;
}

.v-dialog__container {
  display: unset;
}
</style>

