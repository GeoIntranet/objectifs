<template>
  <div>
    <div class="row wrapper-objectif">
      <div class="col-md-12">
        <div class="row objectif-header">
          <div class="col-3 col-md-2 pt-2 align-self-center hover">
            <div class="wrapper-delete-container" @click.prevent="deleteObjectif"> - </div>
          </div>
          
          <div class="col-7 col-md-6 title center pl-1 align-self-center hover" @click="isOnEditMode = true">
            <h3> {{copyObjectif.title}} </h3>
          </div>
          
          <div class="col-2 col-md-4 border-left weight align-self-center" @click="isOnEditMode = true">
            {{copyObjectif.weight}}%
          </div>
          
          <div class="col-md-12" v-if="isOnEditMode">
            <div class="row">
              <div class="col-md-6 ">
                <input type="text" class="form-control" v-model="copyObjectif.title">
              </div>
              <div class="col-md-3">
                <input type="number" class="form-control" v-model="copyObjectif.weight">
              </div>
              <div class="col-md-1">
                <div
                  data-toggle="tooltip"
                  data-placement="top" title="Cancel"
                  class="wrapper-delete-container" @click.prevent="toggleEditMode"> - </div>
              </div>
              <div class="col-md-1">
                <div
                  data-toggle="tooltip"
                  data-placement="top" title="Save"
                  class="wrapper-delete-container" @click.prevent="update"> || </div>
              </div>
            </div>
          
          </div>
        
        </div>
        <div class="row">
          <div class="col-md-12">
            <add-kr :objectif="copyObjectif"></add-kr>
          </div>
        </div>
        <div class="row liste-kr pb-3">
          <div class="col-md-12 border-bottom" v-for="(kr,index) in copyKrs" :key="kr.id">
            <kr :index="index" :kr="kr"></kr>
          </div>
        </div>
        
        <div class="row text-center my-2" v-if="weightStatusError == true">
          <div class="col-md-12">
            <span class="badge badge-invalid"> Invalid Weight Kr</span>
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
                title: "",
                weight: "",
                copyObjectif: [],
                copyKrs: [],
                weightStatusError: true,
                isOnEditMode: false,
            }
        },
        props: ["index", "objectif"],
        methods: {
            deleteObjectif() {
                // just for th moockup
                let hasConfirmation = confirm("Want to delete?");
                if (hasConfirmation) {
                    let vm = this;
                    axios.delete('/api/v1/objectifs/' + vm.copyObjectif.id, {
                        _token: window.token
                    })
                        .then(function (response) {
                            Event.$emit('delete_objectif', vm.index);
                        })
                        .catch(function (error) {
                        })
                }

            },
            toggleEditMode() {
                this.isOnEditMode = !this.isOnEditMode;
            },
            update() {
                let hasConfirmation = confirm("Want to update?");

                if (hasConfirmation) {
                    this.processUpdate()
                }
                else {
                    this.reverseData()
                }

                this.isOnEditMode = false;
            },
            processUpdate(){
                let vm = this;
                axios.put('/api/v1/objectifs/' + vm.copyObjectif.id, {
                    _token: window.token,
                    title: vm.copyObjectif.title,
                    weight: vm.copyObjectif.weight,
                })
                .then(function (response) {
                    Event.$emit('edit_objectif', vm.index, response.data.data);
                    vm.isOnEditMode = false;
                })
                .catch(function (error) {
                })
            },
            reverseData(){
                this.copyObjectif.title = this.title ;
                this.copyObjectif.weight = this.weight ;
            },
            initVar() {
                this.copyObjectif = this.objectif;
                if (this.copyObjectif.krs === undefined) {
                    this.copyObjectif.krs = [];
                }
                this.copyKrs = this.copyObjectif.krs;
                this.processWeight();
                
                this.title = this.copyObjectif.title;
                this.weight = this.copyObjectif.weight;
            },
            processWeight() {
                let count = this.copyKrs.reduce((a, b) => a + (b.weight || 0), 0);
                this.weightStatusError = count != 100;
            },
        },
        mounted() {
            let keyAddKr = "add_kr_" + this.objectif.id;
            let keyDeleteKr = "delete_kr_" + this.objectif.id;
            let keyEditKr = "edit_kr_" + this.objectif.id;

            this.initVar();
            
            Event.$on(keyEditKr, (index, kr) => {
                this.copyKrs[index] = kr;
                this.processWeight();
            });

            Event.$on(keyAddKr, (kr) => {
                this.copyKrs.push(kr);
                this.processWeight();
            });

            Event.$on(keyDeleteKr, (index) => {
                this.copyKrs.splice(index, 1);
                this.processWeight();
            })
        }
    }
</script>

