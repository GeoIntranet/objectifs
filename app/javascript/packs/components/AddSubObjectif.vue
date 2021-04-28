<template>
  <div>
    <button @click="AddSubObjectif" class="btn btn-primary">
      +
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
            AddSubObjectif() {
                console.log('ajouter un KR')
            }
        },
    }
</script>
