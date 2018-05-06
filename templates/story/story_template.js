import React from 'react';

import { storiesOf, addDecorator } from '@storybook/react';
import { action } from '@storybook/addon-actions';
import { linkTo } from '@storybook/addon-links';

import {muiTheme} from 'storybook-addon-material-ui';
import { withKnobs, text, boolean, number, array } from '@storybook/addon-knobs/react';

import Provider from './Provider';

import { <%= @name_p %> } from '<%= @comp_index_path %>' ;
// -- import_hook --



const styles = {
  border: "1px solid"
};
const Bordered = (storyFn) => (
  <div style={styles} className="bordered">
    { storyFn() }
  </div>
);

storiesOf('<%= @name_p %>', module)
  .addDecorator(Bordered)
  .addDecorator(muiTheme())
  .addDecorator(withKnobs)
  .addDecorator(story => <Provider story={story()} />)
  .add('without_props', () => 
    <<%= @name_p %> />
  )
