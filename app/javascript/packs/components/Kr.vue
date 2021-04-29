<template>
  
  <div class="row">
    <div class="col-md-1" @click="deleteKr">x</div>
    <div class="col-md-8" @click="ToogleEditMode" :title="title" :contentEditable="ToogleEditMode">
      {{title}}
    </div>
    <div class="col-md-3" @click="ToogleEditMode">
      {{weight}}%
    </div>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {
                title: "",
                weight: 0,
                isEditable: false,
                copyKr:'',
            }
        },
        props: ["index","kr"],
        methods: {
            ToogleEditMode() {
                console.log("edit mode");
                this.isEditable = !this.isEditable;
                console.log(this.isEditable);
            },
            deleteKr(){
                let vm = this;
                axios.delete('/api/v1/objectifs/'+vm.kr.objectif_id+'/krs/'+vm.kr.id, {
                    _token: window.token
                })
                    .then(function (response) {
                        let key_delete = "delete_kr_"+vm.kr.objectif_id;
                        Event.$emit(key_delete, vm.index);
                    })
                    .catch(function (error) {
                    })
            },
        },
        mounted() {
            this.title = this.kr.title;
            this.weight = this.kr.weight;
            this.copyKr = this.Kr
        }
    }
</script>
