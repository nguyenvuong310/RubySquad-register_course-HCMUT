import React, { Component } from "react";
import { connect } from "react-redux";
import NavAdmin from "./navAdmin";

class HomePageStudent extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }
  toggleModalSetupPrint = () => {};

  componentDidMount() {}

  render() {
    return (
      <>
        <div className="container-register-admin-page">
          <NavAdmin />
        </div>
      </>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    language: state.app.language,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(HomePageStudent);
