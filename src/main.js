// =========================================================
// * Vue Material Kit - v1.2.0
// =========================================================
//
// * Product Page: https://www.creative-tim.com/product/vue-material-kit
// * Copyright 2019 Creative Tim (https://www.creative-tim.com)
// * Licensed under MIT (https://github.com/creativetimofficial/vue-material-kit/blob/master/LICENSE.md)
//
// * Coded by Creative Tim
//
// =========================================================
//
// * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import axios from 'axios'
import VModal from 'vue-js-modal'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import MaterialKit from "./plugins/material-kit";
import vuetify from "@/plugins/vuetify";



Vue.config.productionTip = false;
Vue.prototype.$http = axios

Vue.use(MaterialKit);
Vue.use(VueMaterial)
Vue.use(VModal, { dialog: false })
const NavbarStore = {
  showNavbar: false
};
Vue.mixin({
  data() {
    return {
      NavbarStore
    };
  }
});

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount("#app");
