import Players from '../players/Players.svelte';

document.addEventListener("turbolinks:load", function () {
    const anchor = document.getElementById('players_anchor');
    if (anchor && anchor.childNodes.length == 0) {
        new Players({
            target: anchor,
            props: {
                tournamentId: anchor.getAttribute('data-tournament')
            }
        });
    }
});
