import { configure } from '@storybook/react';

function loadStories() {
  require('../src/stories');
  // -- require_hook --
}

configure(loadStories, module);
