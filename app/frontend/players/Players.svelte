<script lang="ts">
    import {onMount} from 'svelte';
    import type {PlayersData} from "./PlayersData";
    import {loadPlayers} from "./PlayersData";
    import FontAwesomeIcon from "../widgets/FontAwesomeIcon.svelte";

    export let tournamentId: string;
    let data: PlayersData;

    onMount(async () => {
        data = await loadPlayers(tournamentId);
    });
</script>

<p>
    <a href="/tournaments/{tournamentId}/players/meeting" class="btn btn-primary">
        <FontAwesomeIcon icon="list-ul"/>
        Player meeting
    </a>
</p>

<div class="alert alert-secondary mt-4">
    <h5 class="mb-3">Register New Player</h5>
</div>

{#if data}
{:else}
    <div class="d-flex align-items-center m-2">
        <div class="spinner-border m-auto"/>
    </div>
{/if}
