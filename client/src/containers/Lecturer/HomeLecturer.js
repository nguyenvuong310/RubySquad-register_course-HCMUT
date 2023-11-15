import React, { Component } from "react";
import { Redirect, Link } from "react-router-dom";
import { connect } from "react-redux";
import HeaderLecturer from "./HeaderLecturer";
class HomeLecturer extends Component {
  render() {
    return (
      <div>
        <HeaderLecturer />{" "}
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    isLoggedIn: state.user.isLoggedIn,
    role: state.user.role,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {};
};

export default connect(mapStateToProps, mapDispatchToProps)(HomeLecturer);
