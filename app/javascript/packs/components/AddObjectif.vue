<template>
  <div>
    <button @click="AddObjectif" class="btn btn-primary">
      Ajouter un objectif
    </button>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {
            }
        },
        props: [],
        methods: {
            AddObjectif() {
                console.log('ajouter un objectif')
            }
        },
    }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
