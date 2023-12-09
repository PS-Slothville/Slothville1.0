import type { INotification } from 'src/interfaces/INotification';
import { writable, type Writable } from 'svelte/store';

export const notifications: Writable<Array<INotification>> = writable([]);

export function addNotification(newNotification: INotification): void {
	notifications.update((currentNotifications) => [
		...currentNotifications,
		newNotification,
	]);

	notifications.subscribe((data: Array<INotification>) => {
		data.forEach((notification: INotification) => {

			setTimeout(() => {
				removeNotification(notification);
			}, 3000);
		});
	});
}

function removeNotification(notification: INotification): void {
	// Remove notification from array
}
