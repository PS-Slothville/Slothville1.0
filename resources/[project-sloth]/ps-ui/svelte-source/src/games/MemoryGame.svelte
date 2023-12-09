<script lang="ts">
	import type { IGameSettings } from './../interfaces/IGameSettings';
	import { isDevMode, showComponent } from './../stores/GeneralStores';
	import { onMount } from 'svelte';
	import fetchNui from './../../utils/fetch';
	import Skull from './../assets/svgs/Skull.svelte';
	import { gameSettings } from './../stores/GameLauncherStore';

	const skullColor: string = '#02f1b5';

	/** The HTML element that contains the game.  */
	let gameContainer: HTMLDivElement;
	/** The HTML element that contains the timer */
	let time: HTMLSpanElement;
	/** An array of HTML div elements that represent the correct answer inputs. */
	let correctInputs: Array<HTMLDivElement> = [];
	/** An array that stores the current answer sequence. */
	let answer: Array<string> = [];
	/** The duration of the game in seconds. */
	let gameTime: number;
	/** The number of correct answers submitted by the user. */
	let answersCorrect: number = 0;
	/** The number of incorrect answers submitted by the user. */
	let answersIncorrect: number = 0;
	/** The maximum number of incorrect answers allowed before the game ends. */
	let maxAnswersIncorrect: number;
	/** The number of answers to display during the game. */
	let amountOfAnswers: number;
	/** A boolean indicating whether the game is currently active. */
	let gameActive: boolean = true;
	/** A boolean indicating whether the user successfully completed the game. */
	let hackSuccess: boolean;
	/** NUI event that should be called when the game has been completed */
	let triggerEvent: string;
	/** Time remaining before the game ends */
	let timeRemaining: number;
	/** Holds the interval timer for the game countdown */
	let timerInterval: number | null = null;

	/**
	 * Subscribes to the `gameSettings` observable and updates the relevant variables.
	 * @param {IGameSettings} setting - An object containing game settings.
	 * @returns {void}
	 */
	gameSettings.subscribe((setting: IGameSettings) => {
		maxAnswersIncorrect = setting.maxAnswersIncorrect;
		gameTime = setting.gameTime * 1000;
		triggerEvent = setting.triggerEvent;
		amountOfAnswers = setting.amountOfAnswers;
	});

	/**
	 * Resets the game state by resetting all necessary variables and clearing the game container's HTML.
	 * @return {void}
	 */
	function resetGame(): void {
		answer = [];
		answersCorrect = 0;
		answersIncorrect = 0;
		correctInputs = [];
		hackSuccess = false;
		gameActive = false;
	}

	/**
	 * Sets up the game on mount by calling the `setupGame` function.
	 * @returns {void}
	 */
	onMount(async () => {
		// Set the game as active
		gameActive = true;

		// Add game squares to the board
		await addSquares();

		// Generate the answer for the game
		await generateAnswer();

		// Set the correct answers for the game
		await setCorrectAnswers();

		// Set the initial time remaining
		await setTimer();

		// Show the answer for a brief moment to the player
		await showAnswer();

		// Start timer and thereby the game
		await startTimer();
	});

	async function setTimer(): Promise<void> {
		if (time) {
			return new Promise((resolve) => {
				// Calculate the number of seconds and hundredths of a second remaining
				const seconds: number = Math.floor(gameTime / 1000);
				const hundredths: number = Math.floor((gameTime % 1000) / 10);

				// Pad the hundredths part of the timer display string with a leading zero if necessary
				const hundredthsString: string | number =
					hundredths < 10 ? `0${hundredths}` : hundredths;

				// Update the timer display in the DOM
				time.innerHTML = `${seconds}.${hundredthsString}`;

				resolve();
			});
		}
	}

	/**
	 * Starts the game timer countdown
	 */
	async function startTimer(): Promise<void> {
		if (time) {
			// Get the start and end time of the game
			const startTime: number = Date.now();
			const endTime: number = startTime + gameTime;

			// Set the remaining time to the game time
			timeRemaining = gameTime;

			// Initialize the previous time to 0
			let prevTime: number = 0;

			// Set an interval to update the timer display every 10 milliseconds
			timerInterval = setInterval(() => {
				// Get the current time
				const now: number = Date.now();

				// Calculate the remaining time
				timeRemaining = endTime - now;

				// Calculate the number of seconds and hundredths of a second remaining
				const seconds: number = Math.floor(timeRemaining / 1000);
				const hundredths: number = Math.floor(
					(timeRemaining % 1000) / 10
				);

				// Pad the hundredths part of the timer display string with a leading zero if necessary
				const hundredthsString: string | number =
					hundredths < 10 ? `0${hundredths}` : hundredths;

				// Update the timer display in the DOM
				time.innerHTML = `${seconds}.${hundredthsString}`;

				// Set the previous time to the current time
				prevTime = seconds;

				// Check if the time has run out
				if (timeRemaining <= 0) {
					// End the game with a false result
					endGame(false);

					// Set the remaining time to -1
					timeRemaining = -1;

					// Display 0.00 when the timer has finished counting down
					time.innerHTML = `0.00`;
				}
			}, 10);
		}
	}

	/**
	 * Stops the current timer interval
	 */
	async function stopTimer(): Promise<void> {
		return new Promise((resolve) => {
			clearInterval(timerInterval);
			resolve();
		});
	}

	/**
	 * Returns a random integer between the `min` and `max` parameters (inclusive), as a string.
	 * If the generated number already exists in the `answer` array, generate a new random number
	 * until a unique number is found.
	 *
	 * @param min - The minimum number that can be generated (inclusive).
	 * @param max - The maximum number that can be generated (inclusive).
	 * @returns A string representation of a random number between `min` and `max` (inclusive).
	 */
	function randomNumber(min: number, max: number): string {
		let number = `${Math.floor(Math.random() * (max - min) + min)}`;

		while (answer.includes(number)) {
			number = `${Math.floor(Math.random() * (max - min) + min)}`;
		}

		return number;
	}

	/**
	 * Generates 25 new input elements and appends them to a specified container element.
	 * Each input element has a unique identifier and a click event listener that calls the `guessAnswer` function.
	 *
	 * @returns {Promise<void>} A promise that resolves when all input elements have been appended.
	 */
	async function addSquares(): Promise<void> {
		// Create a template element that will be used to generate new input elements
		const template: HTMLDivElement = document.createElement('div');
		template.classList.add(
			'ps-border-green',
			'ps-bg-green-w-opacity',
			'cursor-pointer',
			'input'
		);
		template.setAttribute('data-index', '0');
		template.addEventListener('click', (event: PointerEvent) =>
			guessAnswer(event)
		);

		// Generate 25 new input elements and append them to the container element
		for (let index = 1; index <= 25; index++) {
			const input = template.cloneNode() as HTMLDivElement;
			input.setAttribute('data-index', `${index}`);
			gameContainer.appendChild(input);
		}

		// Add a single click event listener to the container element, and use event delegation
		// to handle clicks on individual input elements. This can improve performance by reducing
		// the number of event listeners that need to be registered and unregistered.
		const promise = new Promise<void>((resolve) => {
			gameContainer.addEventListener('click', (event: MouseEvent) => {
				const target = event.target as HTMLElement;
				if (target.classList.contains('input')) {
					const index: number = parseInt(
						target.getAttribute('data-index') || ''
					);
					if (!isNaN(index)) {
						guessAnswer(event);
					}
				}
			});
			resolve();
		});
		return promise;
	}

	/**
	 * Generates an array of 7 random numbers between 0 and 25, representing the positions
	 * of the correct answers in the grid. The numbers are added to the `answer` array.
	 *
	 * @returns A Promise that resolves after the `answer` array has been generated.
	 */
	async function generateAnswer(): Promise<void> {
		return new Promise((resolve) => {
			for (let answers = 0; answers < amountOfAnswers; answers++) {
				const number: string = randomNumber(0, 25);

				answer.push(number);
			}

			resolve();
		});
	}

	/**
	 * Handles the user's guess and updates the game state accordingly.
	 * @param event - The click or pointer event that triggered the guess.
	 */
	function guessAnswer(event: MouseEvent | PointerEvent): void {
		// Retrieve the target element of the event and the value of its "data-correct" attribute.
		const target = event.target as HTMLElement;
		const correctAnswer: string = target.dataset.correct;

		if (correctAnswer === 'true') {
			// Increment the count of correct answers and end the game if all answers are correct.
			answersCorrect++;

			if (answersCorrect === answer.length) {
				endGame(true);
			}

			// Add the "correctAnswers" class to the target element if it doesn't already have it.
			if (!target.classList.contains('correctAnswers')) {
				target.classList.add('correctAnswers');
			}
		}

		if (correctAnswer === 'false') {
			// Increment the count of incorrect answers and end the game if the maximum number of incorrect answers is reached.
			answersIncorrect++;

			if (answersIncorrect === maxAnswersIncorrect) {
				endGame(false);
			}

			// Add the "incorrectAnswers" class to the target element if it doesn't already have it.
			if (!target.classList.contains('incorrectAnswers')) {
				target.classList.add('incorrectAnswers');
			}
		}
	}

	/**
	 * Sets the "data-correct" attribute on each input element based on whether its "data-answer" attribute matches
	 * one of the correct answers. Also adds the input element to the "correctInputs" array if it is correct.
	 * @returns A Promise that resolves when all inputs have been processed.
	 */
	async function setCorrectAnswers(): Promise<void> {
		// Retrieve the list of input elements and the set of correct answers.
		const inputs: NodeListOf<HTMLDivElement> =
			document.querySelectorAll('.input');
		const correctAnswerSet = new Set(answer);

		// Iterate over each input element and set its "data-correct" attribute and add it to the "correctInputs" array if necessary.
		for (const input of inputs) {
			// Determine whether the input is correct.
			const isCorrect: boolean = correctAnswerSet.has(
				input.dataset.index!
			);

			// Set the "data-correct" attribute on the input element.
			input.dataset.correct = isCorrect ? 'true' : 'false';

			// If the input is correct, add it to the "correctInputs" array.
			if (isCorrect) {
				correctInputs.push(input);
			}
		}

		// Resolve the Promise once all inputs have been processed.
		return Promise.resolve();
	}

	/**
	 * Shows the correct answers on the game board by adding and removing the 'correctAnswers' class to the correct inputs.
	 * After a delay of 1000ms, removes the 'correctAnswers' class from all inputs.
	 * @returns Promise that resolves after the 'correctAnswers' class has been removed from all inputs.
	 */
	async function showAnswer(): Promise<void> {
		await new Promise<void>((resolve) => {
			setTimeout(() => {
				// Add 'correctAnswers' class to the correct inputs
				correctInputs.forEach((input: HTMLDivElement) => {
					input.classList.add('correctAnswers');
				});

				setTimeout(() => {
					// Remove 'correctAnswers' class from all inputs
					correctInputs.forEach((input: HTMLDivElement) => {
						input.classList.remove('correctAnswers');
					});

					resolve();
				}, 1000);
			}, 200);
		});
	}

	/**
	 * Ends the game and triggers the callback to the parent component.
	 * @param success - Whether the game was completed successfully or not.
	 */
	async function endGame(success: boolean): Promise<void> {
		// Stop game timer
		await stopTimer();

		hackSuccess = success;
		gameActive = false;

		// Show the "end game" message and trigger the callback to the parent component
		setTimeout(() => {
			gameSettings.subscribe((setting: IGameSettings) => {
				fetchNui(setting.triggerEvent, { success: hackSuccess });
			});
			showComponent.set(undefined);

			// Reset game settings and data
			resetGame();
		}, 2500);
	}
</script>

<div class="flex items-center justify-center min-h-screen ">
	<div
		class="flex items-center flex-col w-[500px] ps-bg-darkblue p-10 shadow-lg shadow-black"
	>
		<div class="w-[20%]">
			<Skull color={skullColor} />
		</div>
		{#if gameActive}
			<h1 class="ps-font-arcade text-white text-xl mt-5">
				Memory Minigame
			</h1>
			<div class="text-white text-2xl mt-14">
				Time left: <span bind:this={time} />
			</div>
			<div
				class="h-[440px] w-[440px] mt-14 grid grid-cols-5 grid-rows-5 gap-x-[10px] gap-y-[10px]"
				bind:this={gameContainer}
			/>
		{/if}
		{#if !gameActive}
			<div class="flex flex-1 items-center justify-center self-stretch">
				{#if hackSuccess}
					<h1 class="text-white text-3xl mt-5 uppercase">
						Access granted
					</h1>
				{:else}
					<h1 class="text-white text-3xl mt-5 uppercase">
						Access denied
					</h1>
				{/if}
			</div>
		{/if}
	</div>
</div>

<style>
	:global(.correctAnswers) {
		background-color: var(--color-green) !important;
		pointer-events: none;
	}

	:global(.incorrectAnswers) {
		background-color: red !important;
		pointer-events: none;
	}
</style>
