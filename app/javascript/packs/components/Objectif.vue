<template>
  <div>
    <div class="row wrapper-objectif">
      <div class="col-md-12">
        <div class="row objectif-header">
          <div class="col-md-1 pt-2 align-self-center hover">
            <div class="wrapper-delete-container" @click.prevent="deleteObjectif"> - </div>
          </div>
          
          <div class="col-md-7 title center pl-5 align-self-center hover" @click="isOnEditMode = true">
            <h3> {{copyObjectif.title}} </h3>
          </div>
          
          <div class="col-md-4 border-left weight align-self-center" @click="isOnEditMode = true">
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
                <div class="wrapper-delete-container" @click.prevent="update"> ||</div>
              </div>
              <div class="col-md-1">
                <div class="wrapper-delete-container" @click.prevent="toggleEditMode"> -</div>
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
                }
                else {
                    this.copyObjectif.title = this.title ;
                    this.copyObjectif.weight = this.weight ;
                }

                this.isOnEditMode = false;
            },
            init_var() {
                this.copyObjectif = this.objectif;
                if (this.copyObjectif.krs === undefined) {
                    this.copyObjectif.krs = [];
                }
                this.copyKrs = this.copyObjectif.krs;
                this.process_weight();
                
                this.title = this.copyObjectif.title;
                this.weight = this.copyObjectif.weight;
            },
            process_weight() {
                let count = this.copyKrs.reduce((a, b) => a + (b.weight || 0), 0);
                this.weightStatusError = count == 100 ? false : true;
            },
        },
        mounted() {
            let key_add_kr = "add_kr_" + this.objectif.id;
            let key_delete_kr = "delete_kr_" + this.objectif.id;
            let key_edit_kr = "edit_kr_" + this.objectif.id;

            this.init_var();
            Event.$on(key_edit_kr, (index, kr) => {
                this.copyKrs[index] = kr;
                this.process_weight();
            });

            Event.$on(key_add_kr, (kr) => {
                this.copyKrs.push(kr);
                this.process_weight();
            });

            Event.$on(key_delete_kr, (index) => {
                console.log(key_delete_kr);
                this.copyKrs.splice(index, 1);
                this.process_weight();

            })
        }
    }
</script>

