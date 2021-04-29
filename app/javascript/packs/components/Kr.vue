<template>
  
  <div class="row">
    <div class="col-md-1" >
      <a class="badge badge-elevo" href="#" @click.prevent="deleteKR"> - </a>
    </div>
    <div class="col-md-8" @click="InEditMode = true">
      {{copyKr.title}}
    </div>
    <div class="col-md-3" @click="InEditMode = true">
      {{copyKr.weight}}%
    </div>
    <div class="col-md-12">
      <div class="row" v-if="InEditMode">
        <div class="col-md-5"><input type="text" class="form-control" v-model="copyKr.title" ></div>
        <div class="col-md-3"><input type="text" class="form-control" v-model="copyKr.weight" ></div>
        <div class="col-md-1"> <div class="p2 badge badge-elevo"  @click="toggleEditMode()">-</div> </div>
        <div class="col-md-1">  <div class="p2 badge badge-elevo"  @click="update">||</div></div>
      </div>
    </div>
  </div>
  
</template>

<script>
    export default {
        data: function () {
            return {
                InEditMode: false,
                copyKr:'',
            }
        },
        props: ["index","kr"],
        methods: {
            ToogleEditMode() {
                console.log("edit mode");
                this.InEditMode = !this.InEditMode;
                console.log(this.isEditable);
            },
            update(){
                let vm = this;
                axios.put("/api/v1/objectifs/"+vm.copyKr.objectif_id+"/krs/"+vm.copyKr.id, {
                    _token: window.token,
                    title:vm.copyKr.title,
                    weight:vm.copyKr.weight,
                })
                    .then(function (response) {
                        let key_edit = "edit_kr_"+vm.copyKr.objectif_id;
                        Event.$emit(key_edit, vm.index,response.data.data);
                        vm.InEditMode = false;
                    })
                    .catch(function (error) {
                    })
            },
            deleteKR(){
                let vm = this;
                axios.delete('/api/v1/objectifs/'+vm.copyKr.objectif_id+'/krs/'+vm.copyKr.id, {
                    _token: window.token
                })
                    .then(function (response) {
                        let key_delete = "delete_kr_"+vm.copyKr.objectif_id;
                        Event.$emit(key_delete, vm.index);
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
