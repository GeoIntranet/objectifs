<template>
  <div>
    <div class="row py-4" style="background-color: white;">
      <div class=" offset-2 col-lg-8">
        <h1>{{title}}</h1>
        <add-objectif></add-objectif>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <div class="col-12 col-sm-6 col-md-6 col-lg-4 mt-3" v-for="(objectif,index) in this.objectifs" :key="objectif.id">
          <div class="wrapper-objectif pr-2">
            <objectif :index="index" :objectif="objectif"></objectif>
          </div>
        </div>
      </div>
      <div class="row mt-2" v-if="invalidWeight == true">
        <div class="col-lg-12 text-center">
          <hr class="elevo">
          <div class="badge badge-invalid">Invalid general weight</div>
        </div>
      </div>
      <div class="row mt-2" v-if="objectifs.length <= 0">
        <div class="col-lg-12 text-center">
          <hr class="elevo">
          <div class="badge badge-invalid">Invalid Objectives</div>
        </div>
      </div>
    </div>
  
  
  </div>
</template>

<script>
    import AddObjectif from './AddObjectif.vue';
    import Objectif from './Objectif.vue';

    export default {
        components: {
            'add-objectif': AddObjectif,
            'objectif': Objectif,
        },
        data: function () {
            return {
                title: "Objectives management",
                objectifs: [],
                invalidWeight: false,
                weight: 0,
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
                        vm.objectifs = response.data;
                        vm.processWeight();
                    })
                    .catch(function (error) {
                    })
            },
            processWeight() {
                this.weight = this.objectifs.reduce((a, b) => a + (b.weight || 0), 0);
                this.invalidWeight = this.weight != 100;
            }
        },
        mounted() {
            this.getObjectifs();
            Event.$on('edit_objectif', (index,objectif) => {
                this.objectifs[index] = objectif;
                this.processWeight();
            });
            Event.$on('add_objectif', (objectif) => {
                this.objectifs.push(objectif);
                this.processWeight();
            });

            Event.$on('delete_objectif', (index) => {
                this.objectifs.splice(index, 1);
                this.processWeight();
            })
        }
    }
</script>

