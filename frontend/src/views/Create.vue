<template>
  <div class="create">
    <h1>create a task</h1>

    <div>
      <input type="text" v-model="title" placeholder="Title" class="title-input">
      <div class="btn">
        <router-link to="/">Tasks</router-link>
        <button @click="createPost">Create</button>
        <router-view/>
      </div>
    </div>

  </div>
</template>


<script setup>

import {ref, onMounted} from 'vue'

const tasks = ref([])
const title = ref('')
const API_URL = "http://localhost:3000/tasks"

onMounted(async() => { //Se ejecuta al cargar la pag
  const res = await fetch(API_URL)
  tasks.value = await res.json()
})

const createPost = async() => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      title: title.value
    })
  })

  const data = await res.json()
  tasks.value.push(data)
  title.value = ''
}
</script>

<style scoped>

.btn {
  align-items: center;
  display: flex;
  flex-grow: 1;
  justify-content: end;
  max-width: 100vh;
}

button, a {
  border-radius: 8px;
  border: 1px solid transparent;
  padding: 0.6em 1.2em;
  font-size: 1em;
  font-weight: 500;
  font-family: inherit;
  background-color: #1a1a1a;
  cursor: pointer;
  transition: border-color 0.25s;
  color: #ccc;
  margin: 0 3px;
  text-decoration: none;
}
button:hover {
  border-color: #646cff;
}
button:focus,
button:focus-visible {
  outline: 4px auto -webkit-focus-ring-color;
}
.title-input {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: 2px solid #ccc;
    background-color: #f8f8f8;
    border-radius: 4px;
    resize: vertical;
}
</style>
