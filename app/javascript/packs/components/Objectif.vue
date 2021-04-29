<template>
  <div>
  <div class="row">
    <div class="col-lg-12">
      <div class="row">
        <div class="col-md-8"><h3>{{objectif.title}}</h3></div>
        <div class="col-md-4 border-left">{{objectif.weight}}%</div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <add-kr></add-kr>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" v-for="kr,index in objectif.krs">
          <kr :kr="kr"></kr>
        </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
    import AddSubObjectif from './AddSubObjectif.vue';
    import Kr from './Kr.vue';
    
    export default {
        components: {
            'add-kr':AddSubObjectif,
            'kr':Kr,
        },
        data: function () {
            return {
            }
        },
        props: ["objectif"],
        methods: {
            EditObjectif() {
                console.log('ajouter un objectif')
            }
        },
    }
</script>

