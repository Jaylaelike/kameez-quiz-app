<script lang="ts">
    import Leaderboard from "../../lib/Leaderboard.svelte";
    import { leaderboard } from "../../service/host/host";


    function exportToCSV() {
        const data = $leaderboard;
        const csvRows = [];

        // Add headers
        const headers = Object.keys(data[0]);
        csvRows.push(headers.join(','));

        // Add data rows
        for (const row of data) {
            const values = headers.map(header => row[header]);
            csvRows.push(values.join(','));
        }

        // Create CSV file
        const csvString = csvRows.join('\n');
        const blob = new Blob([csvString], { type: 'text/csv' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.setAttribute('href', url);
        a.setAttribute('download', 'leaderboard.csv');
        a.click();
    }
</script>

<div class="flex justify-center bg-purple-500 min-h-screen w-full">
    <div class="mt-32">
        <h2 class="text-center text-white text-5xl font-bold">จบเกมแล้วจ้า!</h2>
        <div class="flex flex-wrap gap-2 mt-10">
            <Leaderboard finish={true} leaderboard={$leaderboard} />
        </div>
        <button on:click={exportToCSV} class="mt-10 bg-white text-purple-500 px-4 py-2 rounded">
            Export to CSV
        </button>
    </div>
</div>
