<script lang="ts" module>
	import { defineMeta } from "@storybook/addon-svelte-csf";
	import Component from "./{{_variable_}}.svelte";

	const { Story } = defineMeta({
		title: "Components/{{_cursor_}}",
		component: Component,
		tags: ["autodocs"],
		parameters: {
			docs: {
				description: {
					component: ``,
				},
			},
		},
	});
</script>

<Story name="Without test" args={{}} />

<Story
	name="With test"
	args={{}}
	play={async ({ canvasElement, args }) => {}}
/>
