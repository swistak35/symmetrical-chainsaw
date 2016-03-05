/* @flow */

import React, { PropTypes } from 'react'
import { connect } from 'react-redux'
import { addLink } from '../../redux/modules/links'

type Props = {
  links: Array<string>,
  addLink: Function
};

export class LinksView extends React.Component<void, Props, void> {
  static propTypes = {
    links: PropTypes.array.isRequired,
    addLink: PropTypes.func.isRequired
  };

  constructor (props, context) {
    super(props, context)
    this.state = {
      inputText: ''
    }

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleChange (e) {
    this.setState({ inputText: e.target.value })
  }

  handleSubmit (e) {
    e.preventDefault()
    this.props.addLink(this.state.inputText)
    this.setState({ inputText: '' })
  }

  render () {
    return (
      <div className='container text-left'>
        <h1>Welcome to the React Redux Starter Kit</h1>
        <ul>
          {this.props.links.map((link) => <li>{link}</li>)}
        </ul>
        <form className='form-inline'>
          <div className='form-group'>
            <input type='text'
              className='form-control'
              autoFocus='true'
              value={this.state.inputText}
              onChange={this.handleChange}
              placeholder='URL' />
          </div>
          <button type='submit' className='btn btn-default' onClick={this.handleSubmit}>
            Add link
          </button>
        </form>
      </div>
    )
  }
}

const mapStateToProps = (state) => ({
  links: state.links
})

export default connect((mapStateToProps), {
  addLink: addLink
})(LinksView)
