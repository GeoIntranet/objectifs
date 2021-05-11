<template>
  
  <div class="row py-1">
    <div class="col-2 col-md-1">
      <a class="badge badge-elevo" href="#" @click.prevent="deleteKr"> - </a>
    </div>
    <div class="col-7 col-md-8 hover" @click="InEditMode = true">
      {{copyKr.title}}
    </div>
    <div class="col-3 col-md-3 hover" @click="InEditMode = true">
      {{copyKr.weight}}%
    </div>
    <div class="col-md-12">
      <div class="row py-1" v-if="InEditMode">
        
        <div class="col-md-5 align-self-center"><input type="text" class="form-control" v-model="copyKr.title"></div>
        
        <div class="col-md-3 align-self-center"><input type="text" class="form-control" v-model="copyKr.weight"></div>
        
        <div class="col-md-1 text-center align-self-center">
          <div data-toggle="tooltip" data-placement="top" title="Cancel" style="padding: 5px 8px;"
               class="badge badge-elevo hover" @click="toggleEditMode()">-
          </div>
        </div>
        
        <div class="col-md-1 text-center align-self-center">
          <div style="padding: 5px 8px;" class="p2 badge badge-elevo hover" data-toggle="tooltip" data-placement="top"
               title="Save" @click="update">||
          </div>
        </div>
      
      </div>
    </div>
  </div>

</template>

<script>
    export default {
        data: function () {
            return {
                InEditMode: false,
                copyKr: '',
            }
        },
        props: ["index", "kr"],
        methods: {
            toggleEditMode() {
                this.InEditMode = !this.InEditMode;
            },
            update() {

                axios.put("/api/v1/objectifs/" + this.copyKr.objectif_id + "/krs/" + this.copyKr.id, {
                    _token: window.token,
                    title: vm.copyKr.title,
                    weight: vm.copyKr.weight,
                })
                    .then((response) => {
                        let keyEdit = "edit_kr_" + this.copyKr.objectif_id;
                        Event.$emit(keyEdit, this.index, response.data.data);
                        this.InEditMode = false;
                    })
                    .catch(function (error) {
                    })
            },
            deleteKr() {
                axios.delete('/api/v1/objectifs/' + this.copyKr.objectif_id + '/krs/' + this.copyKr.id, {
                    _token: window.token
                })
                    .then((response) => {
                        let keyDelete = "delete_kr_" + this.copyKr.objectif_id;
                        Event.$emit(keyDelete, vm.index);
                    })
                    .catch(function (error) {
                    })
            },
        },
        mounted() {
            this.copyKr = this.kr
        }
    }
</script>
