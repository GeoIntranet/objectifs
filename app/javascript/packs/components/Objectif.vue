<template>
  <div>
    <div class="row">
      <div class="col-lg-12">
        <div class="row">
          <div class="col-md-8">
            <h3><span @click="deleteObjectif">X</span> {{objectif.title}}</h3>
          </div>
          <div class="col-md-4 border-left">{{objectif.weight}}%</div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <add-kr :objectif="objectif"></add-kr>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12" v-for="kr,index in copyKrs">
            <kr :index="index" :kr="kr"></kr>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import AddKr from './AddKr.vue';
    import Kr from './Kr.vue';

    export default {
        components: {
            'add-kr': AddKr,
            'kr': Kr,
        },
        data: function () {
            return {
                copyObjectif: [],
                copyKrs: []
            }
        },
        props: ["index","objectif"],
        methods: {
            deleteObjectif() {
                let vm = this;
                axios.delete('/api/v1/objectifs/' + vm.copyObjectif.id, {
                    _token: window.token
                })
                    .then(function (response) {
                        Event.$emit('delete_objectif', vm.index);
                    })
                    .catch(function (error) {
                    })
            },
            EditObjectif() {
                console.log('ajouter un objectif')
            },
            init_var(){
                this.copyObjectif = this.objectif;
                if (this.copyObjectif.krs === undefined){
                    this.copyObjectif.krs = [];
                }
                this.copyKrs = this.copyObjectif.krs;
            }
        },
        mounted() {
            let key_add_kr = "add_kr_"+this.objectif.id;
            let key_delete_kr = "delete_kr_"+this.objectif.id;
            
            this.init_var();
            
           
            Event.$on(key_add_kr, (kr) => {
                this.copyKrs.push(kr);
            });

            Event.$on(key_delete_kr, (index) => {
                console.log(key_delete_kr);
                this.copyKrs.splice(index,1)
            })
        }
    }
</script>

