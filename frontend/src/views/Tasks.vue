<template>
  <h1>Tasks</h1>
  <div v-for="task in tasks" :key="task.id">
    <div class="task row" :class="task.status === false ? 'noCompleted' : 'Completed'">
        <div class="col1">
              <h5> {{ task.title }}</h5>
        </div>

        <div class="list">
          <button class="completeBtn" @click="completeTask(task.id)">Complete</button>
          <button class="deleteBtn" @click="deleteTask(task.id)">Delete</button>
        </div>
      </div>
  </div>
</template>

<script setup>

import {ref, onMounted} from 'vue'

const tasks = ref([])
const status = ref(false)
const API_URL = "http://localhost:3000/tasks"

onMounted(async() => { //Se ejecuta al cargar la pag
  const res = await fetch(API_URL)
  tasks.value = await res.json()
})

const completeTask = async(id) => {
  const res = await fetch(`${API_URL}/${id}`)
  const data = await res.json()

  const index = tasks.value.findIndex(post => post.id === data.id)
  tasks.value[index] = data
}

const deleteTask = async(id) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  tasks.value = tasks.value.filter(post => post.id !== id)
}

</script>

<style scoped>
.Completed {
  background-color: rgb(79, 110, 79);
  border: rgb(79, 110, 79);
}
.noCompleted{
  background-color: rgb(172, 68, 68);
  border: 2px solid rgb(172, 68, 68);
}

.col1 {
  display: flex;
  width: 100vw;
  word-wrap: break-word;
}
.list{
  align-items: center;
  display: flex;
  flex-grow: 1;
  justify-content: end;
  max-width: 100vh;
}
.row {
  display: flex;
  width: 100vw;
}

.deleteBtn {
  border-radius: 6px;
  border: 1px solid transparent;
  padding: 0.6em 1em;
  font-size: 1em;
  font-weight: 500;
  font-family: inherit;
  background-color: rgb(255, 39, 39);
  transition: border-color 0.25s;
  color: #ccc;
}

.completeBtn{
  border-radius: 6px;
  border: 1px solid transparent;
  padding: 0.6em 0.2em;
  font-size: 1em;
  font-weight: 500;
  font-family: inherit;
  background-color: rgb(55, 143, 55);
  transition: border-color 0.25s;
  color: #ccc;
}

.deleteBtn:hover{
  border-color: #646cff;
}
.completeBtn:hover{
  border-color: #646cff;
}
button:focus,
button:focus-visible {
  outline: 4px auto -webkit-focus-ring-color;
}

h5{
  max-width: 20vh;
}

.list button{
  margin: 0 4px;
}

.task{
  max-width: 100%;
    padding: 0 10px;
    margin: 8px 0;
    box-sizing: border-box;
    border-radius: 6px;
    text-align: left;
    color: #ccc;
    resize: vertical;
}

</style>
