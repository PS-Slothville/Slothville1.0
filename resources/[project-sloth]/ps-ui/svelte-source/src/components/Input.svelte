<script lang="ts">
	import { inputStore } from './../stores/InputStores';
	import Icon from './atoms/Icon.svelte';

	import fetchNui from './../../utils/fetch';
	import { onMount } from 'svelte';
	import { hideUi } from './../stores/GeneralStores';
	import { handleKeyUp } from './../../utils/eventHandler';

	let inputs: NodeListOf<HTMLInputElement>;

	document.onkeyup = handleKeyUp;

	onMount(() => {
		inputs = document.querySelectorAll('input');
		inputs[0].focus();
	});

	function submitInputs(): void {
		let returnData: Array<any> = [];
		inputs.forEach((input: HTMLInputElement) => {
			returnData.push({
				input: input.id,
				value: input.value,
			});
		});

		fetchNui('input-callback', returnData);

		closeInputs();
	}

	export function closeInputs(): void {
		inputs.forEach((input: HTMLInputElement) => {
			input.value = '';
		});

		fetchNui('input-close', { ok: true });
		hideUi();
	}
</script>

<div class="flex min-h-screen justify-center items-center">
	<div
		class="flex flex-col flex-nowrap w-[300px] ps-bg-darkblue px-8 pt-8 rounded-md"
	>
		<div class="ps-logo">
			<img src="./images/ps-logo.png" alt="ps-logo" />
		</div>
		<div class="flex flex-col h-full ">
			{#each $inputStore as input}
				<div class="flex flex-col mb-3">
					<label
						for={input.id}
						class="ps-text-lightgrey ml-8 font-bold"
						>{input.label}</label
					>
					<div class="flex items-center w-full mt-[-5px]">
						<Icon
							icon={input.icon}
							color="ps-text-green"
							classes="text-2xl mr-3"
						/>

						<input
							class="p-2 flex-1 bg-transparent rounded-sm"
							type={input.type}
							placeholder={input.placeholder ?? input.placeholder}
							id={input.id}
						/>
					</div>
				</div>
			{/each}
			<div class="flex gap-2 font-bold mt-5 button-wrapper">
				<button
					class="ps-bg-green hover:bg-[#30ffcb] ps-text-darkblue px-4 py-2 rounded-sm"
					on:click={submitInputs}>Submit</button
				>
				<button
					class="ps-bg-lightgrey hover:bg-[#e7e7e7] ps-text-darkblue px-4 py-2 rounded-sm"
					on:click={closeInputs}>Cancel</button
				>
			</div>
			"
		</div>
	</div>
</div>

<style>
	input {
		color: var(--color-lightgrey);
		border-bottom: 1px solid var(--color-lightgrey);
	}

	input::placeholder {
		color: var(--color-lightgrey);
		opacity: 0.8;
	}

	input:not(:focus) {
		padding-left: 0;
	}

	input:focus {
		padding-left: 0;
		outline: none;
		border-bottom-width: 2px;
		border-bottom-color: var(--color-green);
		margin-bottom: -1px;
	}

	.button-wrapper {
		justify-content: center;
	}

	button {
		width: fit-content;
		border-radius: 0.25vw;
		text-transform: uppercase;
	}
</style>
