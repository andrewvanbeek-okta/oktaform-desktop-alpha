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
              <v-text-field
                v-model="search"
                append-icon="search"
                label="Search"
                single-line
                hide-details
              ></v-text-field>
                            <v-data-table
    v-model="selected"
    :headers="headers"
    :items="desserts"
    :single-select="singleSelect"
    item-key="name"
    show-select
  >
  
    <template v-slot:top>
      <v-switch v-model="singleSelect" label="Single select" class="pa-3"></v-switch>
    </template>
  </v-data-table>

              <center></center>
              <vue-tabs>
                <v-tab v-for="(table, i) in tables" v-if="renderComponent" :title="tables[i].title">
                  <div style="align-items: flex-start;" class="full-table">
                    <h1>{{tables[i].title}}</h1>
               <v-data-table
    v-model="selected"
    :headers="headers"
    :items="desserts"
    :single-select="singleSelect"
    item-key="name"
    show-select
    class="elevation-1"
  >
    <template v-slot:top>
      <v-switch v-model="singleSelect" label="Single select" class="pa-3"></v-switch>
    </template>
  </v-data-table>
                      <!-- <v-data-table
                      :headers="tables[i].headers"
                      :items="tables[i].respData"
                      :search="search"
                      :single-select="singleSelect"
                      item-key="name"
                      show-select
                    ></v-data-table> -->
                    <!-- <md-table v-model="tables[i].respData" md-card @md-selected="onSelect">
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
                      <md-table-row
                        slot-scope="{ item }"
                        slot="md-table-row"
                        md-seleted="true"
                        md-selectable="multiple"
                        md-auto-select
                      >
                        <md-table-cell
                          v-for="key in Object.keys(item)"
                          :md-label="key"
                          md-sort-by="name"
                        >{{ item[key] }}</md-table-cell>
                      </md-table-row>
                    </md-table>-->
                    <md-button
                      v-on:click="sendApiResource(tables[i].title)"
                      class="md-danger"
                    >Add/Remove {{ tables[i].title }}</md-button>
                  </div>
                </v-tab>
              </vue-tabs>
            </div>
          </div>
        </div>
      </div>
      <md-button v-on:click="sendSelected()" class="md-danger">Generate</md-button>
      <md-button v-on:click="show()" class="md-danger">show</md-button>
      <md-button v-on:click="showDelete()" class="md-danger">delete</md-button>
      <modal name="hello-world" :adaptive="true" :scrollable="true" width="80%" height="auto">
        <div v-for="(table, i) in addedTables" v-if="renderComponent" class="full-table">
          <h1>{{addedTables[i].title}}</h1>
          <md-table v-model="addedTables[i].respData" md-card>
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
              <md-table-cell
                v-for="key in Object.keys(item)"
                :md-label="key"
                md-sort-by="name"
              >{{ item[key] }}</md-table-cell>
            </md-table-row>
          </md-table>
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
      <modal name="response" :adaptive="true" :scrollable="true" width="80%" height="30%">
        <!-- <md-content class="md-primary allow-scroll">
          <nav-tabs-card class="md-danger" no-label>
            <template slot="content">
              <md-tabs md-sync-route class="md-danger" md-alignment="left">
        <md-tab id="tab-home" md-label="Response" md-icon="message">-->
        <!-- //<div v-model="serverResponse">{{serverResponse}}</div> -->
        <!-- </md-tab>
              </md-tabs>
            </template>
          </nav-tabs-card>
        </md-content>-->
      </modal>
      <v-dialog maxHeight="200px" scrollable="true" />
      <modal name v-if="classicModal" @close="classicModalHide">
        <template slot="header">
          <h4 class="modal-title">Modal Title</h4>
          <md-button
            class="md-simple md-just-icon md-round modal-default-button"
            @click="classicModalHide"
          >
            <md-icon>clear</md-icon>
          </md-button>
        </template>

        <template slot="body">
          <div v-model="serverResponse">{{serverResponse}}</div>
        </template>

        <template slot="footer">
          <md-button class="md-simple">Nice Button</md-button>
          <md-button class="md-danger md-simple" @click="classicModalHide">Close</md-button>
        </template>
      </modal>
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
                  <md-input v-on:change="checkIfEmpty(environmentToken)" v-model="environmentToken"></md-input>
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

const searchByName = (items, term) => {
  if (term) {
    return items.filter(item => toLower(item.name).includes(toLower(term)));
  }

  return items;
};

export default {
  bodyClass: "landing-page",
  props: {
    header: {
      type: String,
      default: require("@/assets/img/bg7.jpg")
    },
    teamImg1: {
      type: String,
      default: require("@/assets/img/faces/avatar.jpg")
    },
    teamImg2: {
      type: String,
      default: require("@/assets/img/faces/christian.jpg")
    },
    teamImg3: {
      type: String,
      default: require("@/assets/img/faces/kendall.jpg")
    }
  },
  components: {
    AtomSpinner,
    VueTabs,
    Spinner,
    VTab,
    LoginCard,
    NavTabsCard
  },
  data() {
    return {
      url: null,
      resources: {},
      singleSelect: false,
      search: "",
      policies: [],
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
      headers: [
        {
          text: "Dessert (100g serving)",
          align: "start",
          sortable: false,
          value: "name"
        },
        { text: "Calories", value: "calories" },
        { text: "Fat (g)", value: "fat" },
        { text: "Carbs (g)", value: "carbs" },
        { text: "Protein (g)", value: "protein" },
        { text: "Iron (%)", value: "iron" }
      ],
      desserts: [
        {
          name: "Frozen Yogurt",
          calories: 159,
          fat: 6.0,
          carbs: 24,
          protein: 4.0,
          iron: "1%"
        }
      ]
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
        if (this.resources.hasOwnProperty(key)) {
          component.addedTables.push({
            title: key,
            respData: this.resources[key]
          });
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
      console.log(this.$router);
      window.location.reload();
    },
    async showDelete() {
      var component = this;
      component.folders = component.environments.map(function(file) {
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
          foldername: component.tenantTwoConfig.split(".json")[0]
        })
        .then(response => {
          console.log(response.data);
          //let blob = new Blob([response.data], { type: 'application/tf' }),
          component.spinning(false);
          component.showResponse(response.data);
          //component.resetPage()
        })
        .catch(e => {
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
        .then(response => {
          component.$http
            .get("http://localhost:8000/apply?path=" + file.folder)
            .then(response => {
              component.showResponse(response.data);
              component.spinning(false);
            });
        });
    },
    showResponse(response) {
      var component = this;
      this.serverResponse = response;
      //this.classicModal = true
      this.$modal.show("dialog", {
        title: "Response",
        text: response.message
          .replace(/(\r\n|\n|\r)/gm, "")
          .trim()
          .split(" to do so if necessary.")[1],
        buttons: [
          {
            title: "Close",
            handler: () => {
              this.$modal.hide("dialog");
              component.resetPage();
            }
          }
        ]
      });
    },
    showCreateConfig() {
      this.$modal.show("create_config");
    },
    async sendApiResource(res) {
      var component = this;
      this.resources[res] = this.selected;
      console.log(this.resources[res]);
      if (this.selected.length == 0) {
        delete this.resources[res];
      } else {
        component.show();
      }
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
            url: component.environmentUrl,
            apiToken: component.environmentToken,
            name: component.environmentName
          }
        );
        console.log(saveEnv);
        if (saveEnv.data.message === "saved!") {
          component.getEnvironments();
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
      var environment = await this.environments.find(function(
        environment_config
      ) {
        return environment_config.name === name;
      });
      return environment;
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
    },
    pullResources() {
      this.tenantOneName = this.tenantOneConfig
        .split("oktaform_env_")[1]
        .split(".json")[0];
      var component = this;
      const baseURI = "";
      var resources = [
        "groups",
        "authorizationServers",
        "apps",
        "policies?type=OKTA_SIGN_ON",
        "idps?type=SAML2",
        "idps?type=OIDC",
        "trustedOrigins"
      ];
      resources.forEach(function(rez) {
        component.$http
          .post("http://localhost:8000/resource", {
            name: component.tenantOneConfig,
            resource: rez
          })
          .then(function(response) {
            console.log(response.data);
            var headers = Object.keys(response.data[0]);
            headers = headers.map(function(oktaResourceKey) {
              return {
                text: oktaResourceKey,
                value: oktaResourceKey
              }
            })
            console.log(headers)
            var table = {
              title: rez,
              respData: response.data,
              headers: headers
            }
            console.log("BELOW IS THE TABLE")
            console.log(headers)
            component.tables.push(table);
            component.rezources = response.data;
            component.renderComponent = false;
            component.$nextTick(() => {
              component.renderComponent = true;
            });
          })
          .catch(function(error) {
            console.log(error);
          });
      });
    },
    async onSelect(items) {
      var component = this;
      var component = this;
      var mostRecentItem = items[items.length - 1];
      var links = Object.keys(mostRecentItem._links)
        .filter(function(link) {
          return (
            link.toString() == "claims" ||
            link.toString() == "scopes" ||
            link.toString() == "rules" ||
            link.toString() == "policies"
          );
        })
        .map(function(filteredlink) {
          return mostRecentItem._links[filteredlink].href;
        });
      var children = await component.getChildrenCollection(links);
      items[items.length - 1]["children"] = await children;
      if (
        items[items.length - 1].name.toUpperCase().includes("DEFAULT") &&
        items[items.length - 1].system
      ) {
        items[items.length - 1].name =
          "Oktaform:default: " + component.tenantOneName;
      }
      if (mostRecentItem.name.toUpperCase().includes("DEFAULT")) {
        if (mostRecentItem._links.self.href.includes("authorizationServers")) {
          component.defaultImport(mostRecentItem);
        }
      }
      component.selected = items;
    },
    async defaultImport(item) {
      this.$http.post(`http://localhost:8000/import`, {
        name: this.tenantTwoConfig,
        resource: item,
        type: item._links.self.href.split("v1/")[1].split("/")[0]
      });
    },
    async getChildrenCollection(links) {
      var component = this;
      links = Promise.all(
        links.map(async function(link) {
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
      var children = getChild.data.children.filter(function(childResource) {
        return !childResource.system;
      });
      return { type: getChild.data.type, children: children };
    },
    searchOnTable() {
      //this.searched = searchByName(this.users, this.search)
    },
    getAlternateLabel(count) {
      let plural = "";

      if (count > 1) {
        plural = "s";
      }

      return `${count} user${plural} selected`;
    }
  },
  mounted() {
    this.getEnvironments();
  },
  computed: {
    headerStyle() {
      return {
        backgroundImage: `url(https://cdn.glitch.com/4804aa21-14f8-431e-b8d7-87a67866858a%2FOKTAFORMBIGGER.png?v=1567701043120)`
      };
    }
  }
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
</style>

