<template>
  <div>
    <h1>{{title}}</h1>
    <add-objectif></add-objectif>
    <br>
    <div class="row">
      <div class="col-lg-4 col-md-4 col-sm-4 mt-3" v-for="objectif,index in this.objectifs">
        <div class="wrapper-objectif pr-1">
          <objectif :index="index" :objectif="objectif"></objectif>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import AddObjectif from './AddObjectif.vue';
    import Objectif from './Objectif.vue';
    import Test from './test.vue';

    export default {
        components: {
            test: Test,
            'add-objectif': AddObjectif,
            'objectif': Objectif,
        },
        data: function () {
            return {
                title: "Gestion d'objectifs ",
                objectifs: [],
            }
        },
        props: [],
        methods: {
            getObjectifs() {
                let vm = this;
                axios.get('/api/v1/objectifs', {
                    _token: window.token,
                })
                    .then(function (response) {
                        console.log(response.data);
                        vm.objectifs = response.data
                    })
                    .catch(function (error) {
                    })
            }
        },
        mounted() {
            this.getObjectifs();

            Event.$on('add_objectif', (objectif) => {
                this.objectifs.push(objectif)
            });

            Event.$on('delete_objectif', (index) => {
                this.objectifs.splice(index,1)
            })
        }
    }
</script>

