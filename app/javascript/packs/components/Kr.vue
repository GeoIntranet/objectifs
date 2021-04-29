<template>
  
  <div class="row">
    <div class="col-md-1">E</div>
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
            }
        },
        props: ["kr"],
        methods: {
            ToogleEditMode() {
                console.log("edit mode");
                this.isEditable = !this.isEditable
                console.log(this.isEditable);
            }
        },
        mounted() {
            this.title = this.kr.title;
            this.weight = this.kr.weight;
        }
    }
</script>
