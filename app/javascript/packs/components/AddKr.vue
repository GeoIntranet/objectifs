<template>
  <div>
    <a class="badge badge-elevo"
       href="#"
       @click.prevent="AddKr"
    >
      <small> + Add KR</small>
    </a>
  </div>
</template>

<script>
    export default {
        data: function () {
            return {
            }
        },
        props: ["objectif"],
        methods: {
            AddKr() {
                let vm = this;
                axios.post('/api/v1/objectifs/'+this.objectif.id+'/krs', {
                    _token: window.token
                })
                .then(function (response) {
                    let key_add = "add_kr_"+vm.objectif.id;
                    Event.$emit(key_add, response.data.data);
                })
                .catch(function (error) {
                })
            }
        },
    }
</script>
