<script lang="ts">
    import {onMount} from 'svelte';
    import type {PlayersData} from "./PlayersData";
    import {loadPlayers} from "./PlayersData";
    import FontAwesomeIcon from "../widgets/FontAwesomeIcon.svelte";
    import RegisterNewPlayerForm from "./RegisterNewPlayerForm.svelte";

    export let tournamentId: string;
    let data: PlayersData;

    onMount(async () => {
        data = await loadPlayers(tournamentId);
    });
</script>

<p>
    <a href="/tournaments/{tournamentId}/players/meeting" class="btn btn-primary">
        <FontAwesomeIcon icon="list"/>
        Player meeting
    </a>
</p>

<RegisterNewPlayerForm tournamentId="{tournamentId}"/>

{#if data}
{:else}
    <div class="d-flex align-items-center m-2">
        <div class="spinner-border m-auto"/>
    </div>
{/if}
