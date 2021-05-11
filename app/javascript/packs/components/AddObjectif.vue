<template>
  <div>
    <button @click="AddObjectif" class="btn btn-objectif">
      + Add Objective
    </button>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {}
        },
        props: [],
        methods: {
            AddObjectif() {

                axios.post('/api/v1/objectifs', {
                    _token: window.token
                })
                    .then((response) => {
                        if (response.data.status === "ok") {
                            Event.$emit('add_objectif', response.data.data);
                        }
                    })
                    .catch(function (error) {
                    })
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
