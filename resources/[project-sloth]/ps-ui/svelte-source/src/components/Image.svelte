<script lang="ts">
	import { showImageMock } from './../../utils/mockEvent';
	import { imageStore } from './../stores/ImageStore';

	showImageMock();
</script>

<div class="flex items-center justify-center min-h-screen ">
	<div
		class="flex items-center flex-col ps-bg-darkblue p-10 shadow-md shadow-gray-800 rounded-md"
	>
		<!-- svelte-ignore a11y-img-redundant-alt -->
		<img src={$imageStore.url} alt="Image placeholder" />
	</div>
</div>
