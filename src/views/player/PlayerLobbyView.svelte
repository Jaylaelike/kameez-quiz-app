<script lang="ts">
    import type { PlayerGame } from "../../service/player/player";

    
    export  let game: PlayerGame;

    let isLoading = true;

// Simulate loading for demonstration purposes
setTimeout(() => {
    isLoading = false;
}, 3000);
</script>

{#if isLoading}
    <motion.div
        class="flex items-center justify-center h-screen bg-gradient-to-r from-amber-500 to-pink-500"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        transition={{ duration: 0.5 }}
    >
        <div class="text-center">
            <div class="loader mb-4"></div>
            <p>Loading...</p>
        </div>
    </motion.div>
{:else}
    <div class="flex flex-col items-center justify-center h-screen bg-gradient-to-r from-amber-500 to-pink-500">
        <h1 class="text-4xl font-bold mb-4 text-white">Welcome to the game!</h1>
        <p class="text-lg text-white">Do you see your name on the screen?</p>

    
    </div>
{/if}
<style>
    .loader {
        border: 4px solid rgba(255, 255, 255, 0.3);
        border-top: 4px solid #fff;
        border-radius: 50%;
        width: 200px;
        height: 200px;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>