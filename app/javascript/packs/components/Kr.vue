<template>

  <div class="row">
    <div class="col-md-1">E</div>
    <div class="col-md-8" @click="edit">{{kr.title}}</div>
    <div class="col-md-3">{{kr.weight}}%</div>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {
                title:""
            }
        },
        props: ["kr"],
        methods: {
            AddSubObjectif() {
                console.log('Liste des kr')
            }
        },
        mounted:{
            
        }
    }
</script>
