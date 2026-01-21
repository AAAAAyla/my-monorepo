<template>
  <h1>Hello Vue3 + Vite + TS</h1>
  <el-button type="primary" @click="msg = 'clicked'">{{ msg }}</el-button>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const msg = ref('click me')
</script>