/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

//import Vue from 'vue'
//import App from '../app.vue'

//document.addEventListener('DOMContentLoaded', () => {
//  const app = new Vue({
//    render: h => h(App)
//  }).$mount()
//  document.body.appendChild(app.$el)
//
//  console.log(app)
//})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


window.Vue = require('vue');
window.Event = new Vue();

require('es6-promise').polyfill();
window.axios = require('axios');

 import Vue from 'vue/dist/vue.esm'
 import App from './components/app.vue'
 import AddObjectif from './components/AddObjectif.vue'


let csrf = document.querySelector('meta[name="csrf-token"]');
if (csrf) {
    window.token = csrf.getAttribute('content');
    window.axios.defaults.headers.common["X-CSRF-TOKEN"] = window.token;
} else {
    console.error("CSRF token not found!")
}


 document.addEventListener('DOMContentLoaded', () => {
   new Vue({
     el: 'app',
     data: {
       message: "Can you say hello?"
     },
     components: {
         App
     }
   })
 });


//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
