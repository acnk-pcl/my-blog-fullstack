<script setup lang="ts">
import { ref, onMounted } from 'vue'

const posts = ref<string[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

onMounted(async () => {
  try {
    const response = await fetch('http://localhost:8080/api/posts')
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    posts.value = await response.json()
  } catch (err) {
    console.error('Failed to fetch posts:', err)
    error.value = 'Failed to load blog posts'
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div class="container">
    <header>
      <h1>My Blog</h1>
    </header>
    
    <main>
      <div v-if="loading" class="loading">
        Loading...
      </div>
      
      <div v-else-if="error" class="error">
        {{ error }}
      </div>
      
      <div v-else class="posts">
        <div v-for="post in posts" :key="post" class="post">
          {{ post }}
        </div>
      </div>
    </main>
  </div>
</template>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

header {
  text-align: center;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e9ecef;
}

header h1 {
  color: #495057;
  margin: 0;
}

.loading, .error {
  text-align: center;
  padding: 2rem;
  color: #6c757d;
}

.error {
  color: #dc3545;
}

.posts {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.post {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  color: #495057;
}
</style>