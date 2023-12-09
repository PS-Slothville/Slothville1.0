<script lang="ts">
    import { isDevMode } from '../stores/GeneralStores';
	import { showStatusBar, statusBarStore } from '../stores/StatusBarStores';

	import { EventHandler } from './../../utils/eventHandler';
	EventHandler();

	if(isDevMode) {
		showStatusBar({
			title: 'Title',
			description: 'Write some description here',
			icon: '',
			items: [
				{
					key: 'Gang', value: 'Ballas'
				},
				{
					key: 'Dominance', value: '20%'
				}
			],
		});
	}
</script>

<div class="flex min-h-screen justify-center items-end pb-5">
	<div class="status-wrapper ps-bg-darkblue">
		<div class="status-details">
			<i class="ps-text-green fa-solid fa-circle-info info-icon text-xl"></i>
			<div class="status-data ps-text-lightgrey">
				{#if $statusBarStore.title}
					<p class="title">
						{$statusBarStore.title}
					</p>
				{/if}
				{#if $statusBarStore.description}
					<p class="description">
						{$statusBarStore.description}
					</p>
				{/if}

				{#if $statusBarStore.items}
					<div class="mt-2">
						{#each $statusBarStore.items as item}
							<div class="flex">
								<p class="ps-text-lightgrey ps-text-small">
									{item.key}:
								</p>
								<p class="ml-1 ps-text-green ps-text-small">
									{item.value}
								</p>
							</div>
						{/each}
					</div>
				{/if}
			</div>
		</div>
	</div>
</div>

<style>
	.status-wrapper {
		min-height: 6vw;
		height: max-content;

		border-radius: 0.6vw;
		box-shadow: 0.1vw 0.1vw 0.2vw var(--color-darkgrey);

		padding: 1.25vw 0;
	}

	.status-wrapper > .status-details {
		display: flex;
		flex-direction: row;
		justify-content: center;
		
		margin: 0 3vw;
	}

	.status-wrapper > .status-details > .info-icon {
		margin-right: 0.5vw;
	}

	.status-wrapper > .status-details > .status-data {
		margin-top: -0.2vw;
	}
	.status-wrapper > .status-details > .status-data > .title {
		font-size: 0.9vw !important;
		font-weight: bolder !important;
	}
	.status-wrapper > .status-details > .status-data > .description {
		font-size: 0.75vw !important;
		margin-top: -0.1vw;
	}
</style>