<script lang="ts">
	import Icon from './atoms/Icon.svelte';
	import { menuStore } from './../stores/MenuStores';

	function openSubMenu(id: string): void {}
</script>

<div class="flex flex-col gap-2 w-[250px] absolute right-[10vw] top-[10vh]">
	{#each $menuStore as menu}
		{#if !menu.subMenu}
			<div
				class="cursor-pointer flex gap-5 rounded-lg items-center p-5 w-full hover:ps-outline-green ps-bg-darkblue"
			>
				<Icon
					icon={menu.icon}
					color="ps-text-green"
					classes="text-xl"
				/>
				<div class="text flex flex-col text-white">
					<span class="text-lg font-bold">{menu.header}</span>
					<span class="ps-text-lightgrey">{menu.text}</span>
				</div>
			</div>
		{/if}

		{#if menu.subMenu}
			<div
				class="cursor-pointer flex gap-5 rounded-lg items-center p-5 w-full hover:ps-outline-green ps-bg-darkblue"
				on:click={() => openSubMenu(menu.subMenuId)}
			>
				<Icon icon={menu.icon} color="ps-text-green" />
				<span class="text-lg text-white font-bold">{menu.header}</span>
				<i
					class="ps-text-lightgrey text-2xl fa-solid fa-angle-right ml-auto mt-[2px]"
				/>
			</div>
		{/if}
	{/each}
</div>
