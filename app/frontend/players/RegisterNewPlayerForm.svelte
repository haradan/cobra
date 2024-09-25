<script lang="ts">
    export let tournamentId: string;
</script>

<div class="alert alert-secondary mt-4">
    <h5 class="mb-3">Register New Player</h5>
    <form class="simple_form form-inline d-block register-player"
          novalidate="novalidate"
          action="/tournaments/{tournamentId}/players" accept-charset="UTF-8" method="post">
        <input type="hidden" name="authenticity_token" value="KX73NsNeqdCGiswb3bSnGw0nZ41rrSVZn370v2NzRU5pbjhZSjhCHBlxi3-gbOimPJsCLv4RZ9AQzjVZsfvnng" autocomplete="off">
        <div class="identities_form d-block">
            <input value="true" hidden="hidden" class="string required" type="text" name="player[organiser_view]" id="player_organiser_view">
            <div class="form-group">
                <label class="d-block" for="player_name">Name</label>
                <input class="string required form-control" placeholder="Enter player name" type="text" name="player[name]" id="player_name">
            </div><div class="form-group">
                <label class="d-block" for="player_pronouns">Pronouns</label>
                <input class="string required form-control" placeholder="Example: they/them" type="text" name="player[pronouns]" id="player_pronouns">
            </div><div class="form-group">
                <label class="d-block" for="player_corp_identity">Corp ID</label>
                <div class="awesomplete">
                    <input class="string required form-control corp_identities" placeholder="Search for corp ID" type="text" name="player[corp_identity]" id="player_corp_identity" autocomplete="off" aria-autocomplete="list">
                    <ul hidden=""></ul>
                    <span class="visually-hidden" role="status" aria-live="assertive" aria-relevant="additions"></span>
                </div>
            </div><div class="form-group">
                <label class="d-block" for="player_runner_identity">Runner ID</label>
                <div class="awesomplete">
                    <input class="string required form-control runner_identities" placeholder="Search for runner ID" type="text" name="player[runner_identity]" id="player_runner_identity" autocomplete="off" aria-autocomplete="list">
                    <ul hidden=""></ul>
                    <span class="visually-hidden" role="status" aria-live="assertive" aria-relevant="additions"></span>
                </div>
            </div><div class="input boolean optional player_first_round_bye align-middle mr-3">
                <input value="0" autocomplete="off" type="hidden" name="player[first_round_bye]">
                <label class="checkbox">
                    <input class="boolean optional mr-1" type="checkbox" value="1" name="player[first_round_bye]" id="player_first_round_bye"> First Round Bye
                </label>
            </div><div class="input string optional player_fixed_table_number form-group my-2 table-number d-none">
                <label class="string optional align-middle d-inline-block mr-1" for="player_fixed_table_number">Table Number</label>
                <input class="string optional form-control table-number" placeholder="Enter table number" type="text" name="player[fixed_table_number]" id="player_fixed_table_number">
            </div>
        </div>
        <div class="mt-2 text-right">
            <a class="btn btn-link text-info mr-2 assign-table-number" onclick="assignTableNumber()">
                <i class="fa fa-bookmark"></i> Assign table number
            </a><a class="btn btn-link text-warning mr-2 unassign-table-number d-none" onclick="unassignTableNumber()">
                <i class="fa fa-bookmark"></i> Unassign table number
            </a><button name="button" type="submit" class="btn btn-success"><i class="fa fa-plus"></i> Create</button>
        </div>
    </form>
</div>
