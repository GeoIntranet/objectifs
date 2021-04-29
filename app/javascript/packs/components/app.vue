<template>
  <div>
    <h1>{{title}}</h1>
    <add-objectif></add-objectif>
    <br>
    <div class="row">
      <div class="col-lg-4 col-md-4 col-sm-4 mt-3" v-for="objectif,index in this.objectifs">
        <div class="wrapper-objectif pr-1">
          <objectif :objectif="objectif"></objectif>
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
            test:Test,
            'add-objectif':AddObjectif,
            'objectif':Objectif,
        },
        data: function () {
            return {
                title: "Gestion d'objectifs ",
                objectifs : [],
            }
        },
        props: [],
        methods: {
            getObjectifs(){
                this.objectifs = [
                    {title:"Objectif 1",weight:20,krs:[{title:"krs1",weight:100}]},
                    {title:"Objectif 2",weight:20,krs:[{title:"krs1",weight:100}]},
                    {title:"Objectif 3",weight:20,krs:[{title:"krs1",weight:50},{title:"krs2",weight:50}]},
                    {title:"Objectif 4",weight:40,krs:[{title:"krs1",weight:100}]},
                    {title:"Objectif 5",weight:40,krs:[{title:"krs1",weight:100}]},
                    {title:"Objectif 6",weight:40,krs:[{title:"krs1",weight:100}]},
                ]
                
            }
        },
        mounted() {
            this.getObjectifs();
            console.log("HELLO WORLD - ELEVO ! ");
        }
    }
</script>

