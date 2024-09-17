
declare namespace Routes {
    function edit_data_tournament_players_path(tournamentId: string): string;
}

export async function loadPlayers(tournamentId: string): Promise<PlayersData> {
    const response = await fetch(
        Routes.edit_data_tournament_players_path(tournamentId),
        {
            method: 'GET',
        }
    );
    return response.json();
}

export type PlayersData = {
    tournament: TournamentSettings;
    players: Player[];
}

export type TournamentSettings = {
    self_registration: boolean;
    registration_closed: boolean;
    nrdb_deck_registration: boolean;
    swiss_deck_visibility: string;
    cut_deck_visibility: string;
    allow_streaming_opt_out: boolean;
}

export type Player = {
    name: string;
    pronouns: string;
    corp_identity: string;
    runner_identity: string;
    first_round_bye: boolean;
    fixed_table_number: number;
}
