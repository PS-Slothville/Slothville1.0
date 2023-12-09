import { UIComponentsEnum } from '../enums/UIComponentsEnum';
import { GamesEnum } from '../enums/GamesEnum';
import { ConnectingGameMessageEnum } from '../enums/GameConnectionMessages';
import { hideUi, isDevMode, showComponent } from './GeneralStores';
import type { IGameSettings } from './../interfaces/IGameSettings';
import { writable, type Writable } from 'svelte/store';
import fetchNui from './../../utils/fetch';

export const gameSettings: Writable<IGameSettings> = writable({
	game: '',
	gameName: '',
	gameDescription: '',
	amountOfAnswers: 0,
	gameTime: 0,
	gameShuffleTime: 0,
	gameLifes: 0,
	gameSize: 0,
	maxAnswersIncorrect: 0,
	triggerEvent: '',
});
export const currentGameActive: Writable<GamesEnum> | undefined = writable();
export const currentActiveGameDetails: Writable<any> | undefined = writable();
export const connectionText: Writable<ConnectingGameMessageEnum> = writable();
export const showLoading: Writable<boolean> = writable(true);

export function setupGame(data): void {
	const game = data.data;
	currentActiveGameDetails.set(game);

	switch (data.data.game) {
		case GamesEnum.Memory: {
			showComponent.set(UIComponentsEnum.Game);
			
			currentGameActive.set(GamesEnum.Memory);
			connectionText.set(ConnectingGameMessageEnum.Connecting);

			gameSettings.set({
				game: GamesEnum.Memory,
				gameName: game.gameName,
				gameDescription: game.gameDescription,
				gameTime: game.gameTime || 2,// 1000 = 10 seconds 
				amountOfAnswers: game.amountOfAnswers || 15,
				maxAnswersIncorrect: game.maxAnswersIncorrect || 2,
				triggerEvent: game.triggerEvent || 'memorygame-callback',
			});

			break;
		}

		case GamesEnum.Scrambler: {
			showComponent.set(UIComponentsEnum.Game);
			
			currentGameActive.set(GamesEnum.Scrambler);
			connectionText.set(ConnectingGameMessageEnum.Connecting);

			gameSettings.set({
				game: GamesEnum.Scrambler,
				gameName: game.gameName,
				gameDescription: game.gameDescription,
				gameTime: game.gameTime || 2,// 1000 = 10 seconds 
				amountOfAnswers: game.amountOfAnswers || 4,
				maxAnswersIncorrect: game.maxAnswersIncorrect || 0,
				triggerEvent: game.triggerEvent || 'scrambler-callback',
			});

			break;
		}

		case GamesEnum.NumberMaze: {
			showComponent.set(UIComponentsEnum.Game);
			
			currentGameActive.set(GamesEnum.NumberMaze);
			connectionText.set(ConnectingGameMessageEnum.Connecting);

			gameSettings.set({
				game: GamesEnum.NumberMaze,
				gameName: game.gameName,
				gameDescription: game.gameDescription,
				gameTime: game.gameTime || 2,// 1000 = 10 seconds 
				amountOfAnswers: game.amountOfAnswers || 4,
				maxAnswersIncorrect: game.maxAnswersIncorrect || 0,
				triggerEvent: game.triggerEvent || 'maze-callback',
			});
			break;
		}

		case GamesEnum.NumberPuzzle: {
			showComponent.set(UIComponentsEnum.Game);
			
			currentGameActive.set(GamesEnum.NumberPuzzle);
			connectionText.set(ConnectingGameMessageEnum.Connecting);

			gameSettings.set({
				game: GamesEnum.NumberPuzzle,
				gameName: game.gameName,
				gameDescription: game.gameDescription,
				gameTime: game.gameTime || 2,// 1000 = 10 seconds 
				amountOfAnswers: game.amountOfAnswers || 4,
				maxAnswersIncorrect: game.maxAnswersIncorrect || 0,
				triggerEvent: game.triggerEvent || 'var-callback',
			});
			break;
		}

		case GamesEnum.NumberUp: {
			showComponent.set(UIComponentsEnum.Game);
			
			currentGameActive.set(GamesEnum.NumberUp);
			connectionText.set(ConnectingGameMessageEnum.Connecting);

			gameSettings.set({
				game: GamesEnum.NumberUp,
				gameName: game.gameName,
				gameDescription: game.gameDescription,
				gameTime: game.gameTime || 30,
				gameShuffleTime: game.gameShuffleTime || 15,
				gameLifes: game.gameLifes || 1,
				gameSize: game.gameSize || 5,
				triggerEvent: game.triggerEvent || 'numberup-callback',
			});

			break;
		}
	}
}

export function closeGame(triggerEvent: string, isSuccess: boolean): void {
	if(!isDevMode) {
		fetchNui(triggerEvent, { success: isSuccess });
	}
	closeUi();
}

export function closeUi() {
	hideUi();
	currentGameActive.set(null);
	currentActiveGameDetails.set(null);
	gameSettings.set({
		game: '',
		gameName: '',
		gameDescription: '',
		amountOfAnswers: 0,
		gameTime: 0,
		gameShuffleTime: 0,
		gameLifes: 0,
		gameSize: 0,
		maxAnswersIncorrect: 0,
		triggerEvent: '',
	});
}