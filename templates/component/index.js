import React, { Component} from 'react';
import { connect } from 'react-redux';
import styles from './<%= @name_l %>.css';
// -- import_hook --

export class <%= @name_p %> extends Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className={styles.base}>
        Contents for <%= @name_p %> go here!
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    // -- state_hook --
  };
}


const mapDispatchToProps = dispatch => {
  return {
    // -- dispatch_hook --
  };
}

export default connect(
  mapStateToProps, 
  mapDispatchToProps
)(<%= @name_p %>);
